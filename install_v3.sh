#!/bin/bash

# Ensure Homebrew is installed on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Checking for Homebrew..."
  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ $? -ne 0 ]; then
      echo "Failed to install Homebrew. Please install it manually to proceed with macOS installations."
      exit 1
    fi
  else
    echo "Homebrew is already installed."
  fi
fi

# --- Clone dotfiles repository ---
clone_dotfiles() {
  echo "Cloning dotfiles repository..."
  local DOTFILES_REPO="https://github.com/Loxxlie/dotfiles.git"
  local DOTFILES_DIR="/tmp/.dotfiles_temp" # Clone to a temporary directory

  if [ -d "$DOTFILES_DIR" ]; then
    echo "Dotfiles temporary directory already exists at $DOTFILES_DIR. Skipping cloning."
  else
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    if [ $? -ne 0 ]; then
      echo "Failed to clone dotfiles repository. Exiting."
      exit 1
    fi
    echo "Dotfiles repository cloned to $DOTFILES_DIR."
  fi
}

# Main script execution flow
# First, clone the dotfiles repository
clone_dotfiles

# Change to the dotfiles directory to ensure subsequent operations are relative to it
cd "/tmp/.dotfiles_temp" || { echo "Failed to change directory to /tmp/.dotfiles_temp. Exiting."; exit 1; }

# Runs first arg if osx, otherwise runs second arg.
os_picker() {
  local osx_func="$1"
  local linux_func="$2"

  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    "$osx_func"
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    "$linux_func"
  else
    echo "Unsupported operating system: $OSTYPE"
  fi
}

# --- Generic function to append a line to the appropriate RC file ---
append_line_to_rc_file() {
  local line_to_add="$1"
  local RC_FILE=""

  if [[ "$SHELL" == */bash ]]; then
    if [ -f "$HOME/.bashrc" ]; then
      RC_FILE="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
      RC_FILE="$HOME/.bash_profile"
    else
      RC_FILE="$HOME/.bashrc"
      touch "$RC_FILE"
    fi
  elif [[ "$SHELL" == */zsh ]]; then
    RC_FILE="$HOME/.zshrc"
    touch "$RC_FILE"
  else
    echo "Warning: Could not determine shell configuration file for $SHELL. Please add the line manually: $line_to_add"
    return 1
  fi

  # Use fgrep for fixed string matching and -x for whole line matching
  if ! fgrep -q -x "${line_to_add}" "$RC_FILE"; then
    echo "$line_to_add" >> "$RC_FILE"
    echo "Added '$line_to_add' to $RC_FILE. Please restart your terminal or run 'source $RC_FILE' for changes to take effect."
  else
    echo "'$line_to_add' already found in $RC_FILE. No changes made."
  fi
}

# --- Install Golang ---
install_golang() {
  echo "Installing Golang..."
  local GO_VERSION="1.24.5" # Using 1.24.5 as per the original script
  local OS=""
  local ARCH="amd64" # Assuming x86-64 architecture

  if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="darwin"
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
  else
    echo "Unsupported operating system for Golang installation: $OSTYPE"
    return 1
  fi

  local GO_TAR="go${GO_VERSION}.${OS}-${ARCH}.tar.gz"
  local GO_URL="https://go.dev/dl/${GO_TAR}"

  echo "Downloading ${GO_URL}..."
  curl -L -o /tmp/${GO_TAR} ${GO_URL}

  if [ $? -ne 0 ]; then
    echo "Failed to download Golang. Exiting."
    return 1
  fi

  echo "Extracting Golang to /usr/local..."
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf /tmp/${GO_TAR}

  if [ $? -ne 0 ]; then
    echo "Failed to extract Golang. Exiting."
    return 1
  fi

  rm /tmp/${GO_TAR}

  echo "Golang installed."
}

install_golang

# --- Install Gopls ---
echo "Installing Gopls..."
go install golang.org/x/tools/gopls@latest

# --- Install GolangCI-Lint ---
echo "Installing GolangCI-Lint..."
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# --- Install Zed ---
install_zed_osx() {
  echo "Installing Zed on macOS..."
  brew install --cask zed
}

install_zed_linux() {
  echo "Installing Zed on Linux..."
  curl -f https://zed.dev/install.sh | sh
}

install_zed_config() {
  echo "Copying Zed configuration..."
  mkdir -p ~/.config/zed
  cp -r .config/zed/* ~/.config/zed/
}

os_picker "install_zed_osx" "install_zed_linux"
install_zed_config

# --- Add GOPATH to PATH permanently ---
add_gopath_to_path() {
  echo "Adding GOPATH to PATH permanently..."
  local GOPATH_BIN="$(go env GOPATH)/bin"
  local PATH_LINE="export PATH=\"\$PATH:${GOPATH_BIN}\""
  append_line_to_rc_file "$PATH_LINE"
}

add_gopath_to_path

# --- Install aliases ---
install_aliases() {
    echo "Adding bash aliases..."
    cp .bash_aliases ~/
    local ADD_ALIASES="source ~/.bash_aliases"
    append_line_to_rc_file "$ADD_ALIASES"
}

install_aliases

# Clean up the temporary dotfiles directory
rm -rf "/tmp/.dotfiles_temp"

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

# --- Install Golang ---
install_golang() {
  echo "Installing Golang..."
  local GO_VERSION="1.24.5"
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

# --- Add GOPATH to PATH ---
add_gopath_to_path() {
  echo "Adding GOPATH to PATH..."
  local GOPATH_BIN="$(go env GOPATH)/bin"
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
    echo "Warning: Could not determine shell configuration file for $SHELL. Please add GOPATH to your PATH manually."
    return 1
  fi

  if ! grep -q "export PATH=.*${GOPATH_BIN}" "$RC_FILE"; then
    echo "export PATH=\"\$PATH:${GOPATH_BIN}\"" >> "$RC_FILE"
    echo "Added GOPATH to $RC_FILE. Please restart your terminal or run 'source $RC_FILE' for changes to take effect."
  else
    echo "GOPATH already found in $RC_FILE. No changes made."
  fi
}

install_golang
add_gopath_to_path

echo "Installing Gopls..."
go install golang.org/x/tools/gopls@latest

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

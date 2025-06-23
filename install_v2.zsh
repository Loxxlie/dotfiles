#!/bin/zsh

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print messages
print_info() {
    echo "\033[1;34m[INFO]\033[0m $1"
}

print_success() {
    echo "\033[1;32m[SUCCESS]\033[0m $1"
}

print_error() {
    echo "\033[1;31m[ERROR]\033[0m $1"
}

# Detect OS
OS="$(uname)"
print_info "Detecting operating system..."
if [[ "$OS" == "Darwin" ]]; then
    PLATFORM="macOS"
    print_info "Operating System: macOS"
elif [[ "$OS" == "Linux" ]]; then
    PLATFORM="Linux"
    print_info "Operating System: Linux"
else
    print_error "Unsupported operating system: $OS"
    exit 1
fi

# Update package lists for Linux
if [[ "$PLATFORM" == "Linux" ]]; then
    if command -v apt-get >/dev/null 2>&1; then
        PACKAGE_MANAGER="apt"
        sudo apt-get update
    elif command -v yum >/dev/null 2>&1; then
        PACKAGE_MANAGER="yum"
        sudo yum check-update
    elif command -v dnf >/dev/null 2>&1; then
        PACKAGE_MANAGER="dnf"
        sudo dnf check-update
    else
        print_error "No supported package manager found (apt, yum, dnf)"
        exit 1
    fi
fi

# Function to install packages using Homebrew (macOS) or appropriate package manager (Linux)
install_package() {
    local package=$1
    if [[ "$PLATFORM" == "macOS" ]]; then
        if brew list "$package" >/dev/null 2>&1; then
            print_info "$package is already installed."
        else
            print_info "Installing $package via Homebrew..."
            brew install "$package"
            print_success "Installed $package."
        fi
    elif [[ "$PLATFORM" == "Linux" ]]; then
        case "$PACKAGE_MANAGER" in
            apt)
                if dpkg -l | grep -qw "$package"; then
                    print_info "$package is already installed."
                else
                    print_info "Installing $package via apt..."
                    sudo apt-get install -y "$package"
                    print_success "Installed $package."
                fi
                ;;
            yum|dnf)
                if rpm -qa | grep -qw "$package"; then
                    print_info "$package is already installed."
                else
                    print_info "Installing $package via $PACKAGE_MANAGER..."
                    sudo "$PACKAGE_MANAGER" install -y "$package"
                    print_success "Installed $package."
                fi
                ;;
        esac
    fi
}

# Ensure Homebrew is installed on macOS
if [[ "$PLATFORM" == "macOS" ]]; then
    if ! command -v brew >/dev/null 2>&1; then
        print_info "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add Homebrew to PATH
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        print_success "Homebrew installed."
    else
        print_info "Homebrew is already installed."
        brew update
    fi
fi

# Install dependencies
print_info "Installing common dependencies (git, curl)..."
install_package "git"
install_package "curl"

# Install the primary packages
print_info "Installing development environment packages..."
install_package "neovim"
install_package "fzf"
install_package "kube-ps1"
install_package "tmux"
install_package "docker"
install_package "python"

# Install zsh-git-prompt
install_zshgitprompt() {
    # Define the Git repository URL and the target directory
    REPO_URL="https://github.com/zsh-git-prompt/zsh-git-prompt.git"
    TARGET_DIR=~/.zsh-git-prompt

    # Check if the target directory already exists
    if [ -d "$TARGET_DIR" ]; then
      echo "zsh-git-prompt is already installed. Skipping installation."
      return
    fi

    # Clone the repository into the target directory
    echo "Installing zsh-git-prompt..."
    git clone "$REPO_URL" "$TARGET_DIR"

    # Add the necessary line to the zshrc file
    echo "Adding zsh-git-prompt to zshrc..."
    echo "source ~/.zsh-git-prompt/zshrc.sh" >> ~/.zshrc
}

install_zshgitprompt

# Install NVM and Node.js
install_nvm() {
    if [[ -d "${HOME}/.nvm" ]]; then
        print_info "NVM is already installed."
    else
        print_info "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        print_success "NVM installed."
    fi

    # Install latest Node.js LTS version
    if command -v nvm >/dev/null 2>&1; then
        print_info "Installing latest Node.js LTS version..."
        nvm install --lts
        nvm use --lts
        nvm alias default 'lts/*'
        print_success "Node.js installed via NVM."
    else
        print_error "NVM is not installed properly."
    fi
}

install_nvm

# Install npm (comes with Node.js, but ensure it's updated)
update_npm() {
    if command -v npm >/dev/null 2>&1; then
        print_info "Updating npm to the latest version..."
        npm install -g npm@latest
        print_success "npm updated to the latest version."
    else
        print_error "npm is not installed."
    fi
}

update_npm

# Install Golang
install_golang() {
    if command -v go >/dev/null 2>&1; then
        print_info "Golang is already installed."
    else
        print_info "Installing Golang..."
        if [[ "$PLATFORM" == "macOS" ]]; then
            brew install go
        elif [[ "$PLATFORM" == "Linux" ]]; then
            if [[ "$PACKAGE_MANAGER" == "apt" ]]; then
                sudo apt-get install -y golang
            elif [[ "$PACKAGE_MANAGER" == "yum" || "$PACKAGE_MANAGER" == "dnf" ]]; then
                sudo "$PACKAGE_MANAGER" install -y golang
            fi
        fi
        print_success "Golang installed."
    fi
}

install_golang
install_package "golangci-lint"

# Install Obsidian
install_obsidian() {
    if [[ "$PLATFORM" == "macOS" ]]; then
        if brew list --cask obsidian >/dev/null 2>&1; then
            print_info "Obsidian is already installed."
        else
            print_info "Installing Obsidian via Homebrew Cask..."
            brew install --cask obsidian
            print_success "Obsidian installed."
        fi
    elif [[ "$PLATFORM" == "Linux" ]]; then
        # Detect Linux distribution
        if [[ "$PACKAGE_MANAGER" == "apt" ]]; then
            OBSIDIAN_URL=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep browser_download_url | grep .deb | cut -d '"' -f 4)
            print_info "Downloading Obsidian DEB package..."
            wget -O ~/obsidian.deb "$OBSIDIAN_URL"
            print_info "Installing Obsidian..."
            sudo dpkg -i ~/obsidian.deb || sudo apt-get install -f -y
            rm ~/obsidian.deb
            print_success "Obsidian installed."
        elif [[ "$PACKAGE_MANAGER" == "yum" || "$PACKAGE_MANAGER" == "dnf" ]]; then
            OBSIDIAN_URL=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep browser_download_url | grep .rpm | cut -d '"' -f 4)
            print_info "Downloading Obsidian RPM package..."
            wget -O ~/obsidian.rpm "$OBSIDIAN_URL"
            print_info "Installing Obsidian..."
            sudo "$PACKAGE_MANAGER" install -y ~/obsidian.rpm
            rm ~/obsidian.rpm
            print_success "Obsidian installed."
        fi
    fi
}

install_obsidian

# Update .zshrc
update_zshrc() {
	# Initialize bash_git_prompt
	echo 'if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then' >> ~/.zshrc
	echo '    source "$HOME/.bash-git-prompt/gitprompt.sh"' >> ~/.zshrc
	echo 'fi' >> ~/.zshrc

	# Initialize fzf
	echo 'export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"' >> ~/.zshrc
	echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> ~/.zshrc

	# Initialize kube-ps1
	echo 'source "$HOME/.kube-ps1/kube-ps1.sh"' >> ~/.zshrc
	echo 'PROMPT=\'\$\(kube_ps1\) '$PROMPT'\'' >> ~/.zshrc'
}

# update_zshrc

# Copy Configs/Snippets
ins_configs ()
{
    cp .bash_aliases ~/.bash_aliases
    cp .bashrc_loxx ~/.bashrc_loxx
    cp -Rf .config ~
}

ins_configs

# Final message
print_success "Development environment setup complete!"
print_info "Please restart your terminal or run 'source ~/.zshrc' to apply changes."

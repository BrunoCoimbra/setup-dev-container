# Description: Setup basic environment for a new container

# Identify package manager
if [ -x "$(command -v apt-get)" ]; then
    PM="apt-get"
elif [ -x "$(command -v dnf)" ]; then
    PM="dnf"
elif [ -x "$(command -v yum)" ]; then
    PM="yum"
else
    echo "No package manager found"
    exit 1
fi
echo "Package manager: $PM"

# Install GitHub CLI
echo "Installing GitHub CLI"
if [ -x "$(command -v gh)" ]; then
    echo "GitHub CLI already installed"
else
    if [ "$PM" == "apt-get" ]; then
        sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
        sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install gh
    elif [ "$PM" == "yum" ]; then
        type -p yum-config-manager >/dev/null || sudo yum install yum-utils
        sudo yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
        sudo yum install gh
    elif [ "$PM" == "dnf" ]; then
        sudo dnf install 'dnf-command(config-manager)'
        sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
        sudo dnf install gh
    fi
    gh auth login
    gh extension install github/gh-copilot
fi

# Install oh-my-zsh
echo "Installing oh-my-zsh and plugins"
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
cp container.zsh-theme ~/.oh-my-zsh/custom/themes
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/cedi/meaningful-error-codes.git
cd -
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.bak
fi
cp .zshrc ~/.zshrc

# Configure git
echo "Configuring git"
git config --global user.name "Bruno Coimbra"
git config --global user.email "coimbra@fnal.gov"

#!/bin/bash

DOTFILES_DIR=$(dirname "$(realpath $0)")
HOMEBREW_PREFIX=/opt/homebrew/
packages=(
    neovim
    ripgrep
    fzf
    git
    gh
    azure-cli
    lazygit
    python@3.12
    iterm2
)

echo "Installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Homebrew has been installed."

echo "Installing homebrew packages..."
for package in "${packages[@]}"; do
    echo "Installing $package..."
    ${HOMEBREW}/brew install "$package"
done
echo "All homebrew packages from the setup script have been installed."

echo "Installing node with pnpm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22
node -v # Should print "v22.15.0".
nvm current # Should print "v22.15.0".
corepack enable pnpm
pnpm -v
echo "Node & pnpm have been installed."

echo "Installing docker..."
curl -o $HOME/Downloads/Docker.dmg https://desktop.docker.com/mac/main/arm64/190950/Docker.dmg
echo "Please authenticate with root user for the following installation when prompted..."
sudo hdiutil attach Docker.dmg
sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license --user=ZEAITER.ZEAITER
sudo hdiutil detach /Volumes/Docker
rm -f $HOME/Downloads/Docker.dmg
echo "Docker has been installed."

echo "Installing dotfiles..."
cp -ft $HOME ${DOTFILES_DIR}/.bashrc ${DOTFILES_DIR}/.gitconfig
source $HOME/.bashrc
cp -rf ${DOTFILES_DIR}/config/* $HOME/.config/
cp -rf ${DOTFILES_DIR}/local/* $HOME/.local/share/

cp -f ${DOTFILES_DIR}/Application\ Support/lazygit/* $HOME/Library/Application\ Support/lazygit
cp -f ${DOTFILES_DIR}/Application\ Support/iTerm2/Profiles.json $HOME/Library/Application\ Support/iTerm2/DynamicProfiles/
echo "Dotfiles have been installed."

echo "Installing fonts..."
unzip ${DOTFILES_DIR}/fonts/SourceCodePro.zip
mkdir -p $HOME/Library/Fonts
mv fonts Sauce* $HOME/Library/Fonts/
rm -f LICENSE* README*
echo "Fonts have been installed."

echo "Installing vim-plug..."
curl -fLo ${XDG_DATA_HOME:-$HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Vim-plug has been installed."

echo "Creating python provider for neovim..."
python3 -m venv $HOME/.local/share/nvim/nvim_venv
source $HOME/.local/share/nvim/nvim_venv/bin/activate
pip install pynvim
deactive
echo "Python provider setup complete."

echo "Running plugin installation in neovim..."
${HOMEBREW_PREFIX}/bin/nvim -c PlugInstall -c q -c q
echo "Neovim plugins installed."

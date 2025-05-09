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
echo "Successfully installed homebrew."

echo "Installing homebrew packages..."
for package in "${packages[@]}"; do
    echo "Installing $package..."
    ${HOMEBREW_PREFIX}/brew install "$package"
done
echo "Successfully installed all homebrew packages."

echo "Installing node with pnpm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22
node -v # Should print "v22.15.0".
nvm current # Should print "v22.15.0".
corepack enable pnpm
pnpm -v
echo "Successfully installed node with pnpm."

echo "Installing docker..."
curl -o ${HOME}/Downloads/Docker.dmg https://desktop.docker.com/mac/main/arm64/190950/Docker.dmg
echo "Please authenticate with root user for the following installation when prompted..."
hdiutil attach Docker.dmg
/Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license --user=ZEAITER.ZEAITER
hdiutil detach /Volumes/Docker
rm -f ${HOME}/Downloads/Docker.dmg
echo "Successfully installed docker."

echo "Installing dotfiles..."
cp -ft ${HOME} ${DOTFILES_DIR}/.bashrc ${DOTFILES_DIR}/.gitconfig
source ${HOME}/.bashrc
cp -rf ${DOTFILES_DIR}/config/* ${HOME}/.config/
cp -rf ${DOTFILES_DIR}/local/* ${HOME}/.local/share/

cp -f ${DOTFILES_DIR}/Application\ Support/lazygit/* ${HOME}/Library/Application\ Support/lazygit
cp -f ${DOTFILES_DIR}/Application\ Support/iTerm2/Profiles.json ${HOME}/Library/Application\ Support/iTerm2/DynamicProfiles/
echo "Successfully installed dotfiles."

echo "Installing fonts..."
FILE='SourceCodePro'
curl -o ${HOME}/Library/Fonts/${FILE}.tar.xz -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.tar.xz
tar xf ${HOME}/Library/Fonts/${FILE}.tar.xz --exclude=LICENSE.txt --exclude=README.md -C ${HOME}/Library/Fonts/
rm -f ${HOME}/Library/Fonts/${FILE}*
echo "Successfully installed fonts."

echo "Installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "Successfully installed vim-plug."

echo "Creating python provider for neovim..."
python3 -m venv ${HOME}/.local/share/nvim/nvim_venv
source ${HOME}/.local/share/nvim/nvim_venv/bin/activate
pip install pynvim
deactive
echo "Python provider setup complete."

echo "Running plugin installation in neovim..."
${HOMEBREW_PREFIX}/bin/nvim -c PlugInstall -c q -c q
echo "Successfully installed neovim plugins."

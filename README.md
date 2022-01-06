# My Neovim configuration

![Neovim screenshot](https://user-images.githubusercontent.com/15816726/147858310-10f08157-8f95-403a-9065-a00c07cfa5b3.png)

## Installation

1. Install [Neovim](https://github.com/neovim/neovim/releases/)

2. ```sh
   # Clone this repository to ~/.config/nvim/
   git clone https://github.com/melkster/nvim/ ~/.config/nvim/
   # Install vim-plug
   curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   # Install plugins using vim-plug
   nvim +PlugInstall +qa 2> /dev/null
   # Install python module for neovim (optional)
   pip install --user neovim
   ```

My other dotfiles are available [here](https://github.com/melkster/nvim/).

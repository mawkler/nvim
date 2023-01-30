# My Neovim configuration

![Neovim screenshot](https://user-images.githubusercontent.com/15816726/147858310-10f08157-8f95-403a-9065-a00c07cfa5b3.png)

## Installation

1. Install [Neovim](https://github.com/neovim/neovim/releases/)
2. ```sh
   # Clone this repository to ~/.config/nvim/
   git clone https://github.com/mawkler/nvim/ ~/.config/nvim/
   # Install packer.nvim
   git clone --depth 1 https://github.com/wbthomason/packer.nvim \
       ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   # Install plugins using packer.nvim
   nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
   # Install python module for Neovim (optional)
   pip install --user neovim
   ```

My other dotfiles are available [here](https://github.com/mawkler/dotfiles).

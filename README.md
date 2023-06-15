# My Neovim configuration

![Neovim screenshot](https://user-images.githubusercontent.com/15816726/147858310-10f08157-8f95-403a-9065-a00c07cfa5b3.png)

## Installation

1. Install [Neovim](https://github.com/neovim/neovim/releases/)
2. ```sh
   # Clone this repository to ~/.config/nvim/
   git clone https://github.com/mawkler/nvim/ ~/.config/nvim/
   # Clone lazy.nvim
   git clone --depth 1 --filter=blob:none --branch=stable \
      https://github.com/folke/lazy.nvim.git \
      ~/.local/share/nvim/lazy/lazy.nvim
   # Install python module for Neovim
   pip install --user neovim
   # Launch Neovim and let lazy.nvim do its thing
   nvim
   ```

My other dotfiles are available [here](https://github.com/mawkler/dotfiles).

------------
-- Packer --
------------
local map, autocmd = require('../utils').map, require('../utils').autocmd

require('packer').init {
  -- opt_default = false, -- true will make loading plugins optional by default
  profile = {
    enable = true,
  },
  display = {
    keybindings = {
      quit = '<Esc>',
    }
  }
}

autocmd('BufWritePost', {
  pattern = 'init.lua',
  command = 'source <afile> | PackerCompile',
  group   = 'Packer'
})

autocmd('BufEnter', {
  pattern = vim.fn.stdpath('config') .. '/init.lua',
  callback = function()
    map('n', '<F5>', ':source ~/.config/nvim/init.lua | PackerInstall<CR>', {
      buffer = true,
    })
  end
})

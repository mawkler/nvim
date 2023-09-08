--------------
-- Autolist --
--------------
local filetypes = { 'markdown', 'text', 'latex' }
return {
  'gaoDean/autolist.nvim',
  ft = filetypes,
  config = function()
    local map = require('utils').map
    local autolist = require('autolist')

    autolist.setup({
      colon = { indent_raw = false },
    })

    local opts = { buffer = true }

    local function set_keymaps()
      map('i', '<CR>',      '<CR><cmd>AutolistNewBullet<CR>',      opts)
      map('n', 'o',         'o<cmd>AutolistNewBullet<CR>',         opts)
      map('n', 'O',         'O<cmd>AutolistNewBulletBefore<CR>',   opts)
    end

    local augroup = vim.api.nvim_create_augroup('Autolist', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      group = augroup,
      callback = set_keymaps,
    })

    -- Set the keymaps the firs time autolist.nvim gets lazy-loaded
    set_keymaps()
  end
}

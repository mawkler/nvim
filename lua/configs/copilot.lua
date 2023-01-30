-------------
-- Copilot --
-------------
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = { TelescopePrompt = false, DressingInput = false }

return { 'github/copilot.vim',
  event = 'InsertEnter',
  enabled = false,
  config = function()
    local map = require('utils').map

    map('i', '<C-l>', 'copilot#Accept("")', { expr = true })
    map('i', '<C-f>', 'copilot#Accept("")', { expr = true })
    map('i', '<M-.>', '<Plug>(copilot-next)')
    map('i', '<M-,>', '<Plug>(copilot-previous)')
  end
}

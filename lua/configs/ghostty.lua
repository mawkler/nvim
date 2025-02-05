-------------
-- Ghostty --
-------------
local ghostty_config_path = os.getenv('HOME') .. '/.config/ghostty/config'

return {
  'isak102/ghostty.nvim',
  dependencies = {
    'bezhermoso/tree-sitter-ghostty', -- Ghostty Treesitter parser
    build = 'make nvim_install',
  },
  event = 'BufReadPost ' .. ghostty_config_path,
  init = function()
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      pattern = ghostty_config_path,
      callback = function(event)
        vim.api.nvim_set_option_value('filetype', 'ghostty', { buf = event.buf })
      end
    })
  end,
  opts = {},
}

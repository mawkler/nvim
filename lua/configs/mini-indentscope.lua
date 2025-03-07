----------------------
-- Mini indentscope --
----------------------
return {
  'echasnovski/mini.indentscope',
  enabled = vim.g.vscode == nil,
  event = 'VeryLazy',
  config = function()
    require('mini.indentscope').setup({
      symbol = '▏',
      mappings = {
        object_scope = 'iI',
        object_scope_with_border = 'aI',
      },
    })

    local augroup = vim.api.nvim_create_augroup('MiniIndentScope', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = require('configs.indent-blankline.config').disabled_filetypes,
      group = augroup,
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end
}

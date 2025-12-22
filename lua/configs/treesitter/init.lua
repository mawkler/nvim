----------------
-- Treesitter --
----------------
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = 'RRethy/nvim-treesitter-endwise',
  build = ':TSUpdate',
  lazy = false,
  enabled = not vim.g.vscode,
  config = function()
    local parsers = require('configs.treesitter.parsers')

    -- Install parsers
    require('nvim-treesitter').install(parsers)

    -- Syntax highlighting
    vim.api.nvim_create_autocmd('FileType', {
      pattern = parsers,
      callback = function() vim.treesitter.start() end,
    })

    -- Indentation (experimental)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
}

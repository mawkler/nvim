-------------
-- null-ls --
-------------
return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local null_ls = require('null-ls')
    local builtins = null_ls.builtins
    local map = require('utils').map
    local b = vim.b

    local sources = {
      builtins.formatting.shfmt,
      builtins.formatting.autopep8,
      builtins.formatting.prettierd,
      builtins.hover.dictionary,
      -- builtins.diagnostics.eslint_d,
      -- builtins.code_actions.eslint_d,
    }

    null_ls.setup({
      sources = sources,
      on_attach = function(client, bufnr)
        require('utils.formatting').format_on_write(client, bufnr)
      end,
    })

    map('n', '<F2>', function()
      b.format_on_write = (not b.format_on_write and b.format_on_write ~= nil)
      vim.notify(
        'Format on write '
        .. (b.format_on_write and 'enabled' or 'disabled')
      )
    end, 'Toggle autoformatting on write')
  end,
}

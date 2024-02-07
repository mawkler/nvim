-------------
-- null-ls --
-------------
return {
  'nvimtools/none-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'davidmh/cspell.nvim' },
  event = 'VeryLazy',
  config = function()
    local b = vim.b
    local map = require('utils').map
    local null_ls, builtins = require('null-ls'), require('null-ls').builtins

    local sources = {
      builtins.formatting.autopep8,
      builtins.formatting.prettier,
      builtins.formatting.latexindent,
      builtins.hover.dictionary,
      builtins.formatting.shfmt.with({
        args = { '-sr' } -- Space after redirects
      }),
    }

    null_ls.setup({
      sources = vim.tbl_map(function(source)
        return source.with({
          diagnostics_postprocess = function(diagnostic)
            if diagnostic.source == 'cspell' then
              diagnostic.severity = vim.diagnostic.severity.HINT
            end
          end,
        })
      end, sources),
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

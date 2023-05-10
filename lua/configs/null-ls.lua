-------------
-- null-ls --
-------------
return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'davidmh/cspell.nvim' },
  event = 'VeryLazy',
  config = function()
    local b = vim.b
    local null_ls, builtins = require('null-ls'), require('null-ls').builtins
    local map = require('utils').map

    local cspell_config = vim.fn.expand('$HOME/.config/cspell.json')

    local sources = {
      builtins.formatting.shfmt,
      builtins.formatting.autopep8,
      builtins.formatting.prettierd,
      builtins.hover.dictionary,
      builtins.diagnostics.cspell,
      builtins.code_actions.cspell.with({
        config = {
          find_json = function()
            return cspell_config
          end,
          on_success = function()
            os.execute( -- Format cspell.json
              "cat " .. cspell_config .. " | jq | tee " .. cspell_config .. " > /dev/null"
            )
          end,
        },
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

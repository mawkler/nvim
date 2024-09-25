-----------------------
-- elixir-tools.nvim --
-----------------------
return {
  'elixir-tools/elixir-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'williamboman/mason.nvim' },
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local elixir = require('elixir')
    local elixirls = require('elixir.elixirls')
    local mason_path = require('mason-core.path')
    local get_install_path = require('utils').get_install_path

    local cmd = mason_path.concat({ get_install_path('elixir-ls'), 'language_server.sh' })

    elixir.setup({
      nextls = { enable = false },
      elixirls = {
        cmd = cmd,
        settings = elixirls.settings {
          dialyzerEnabled = true,
          -- fetchDeps = false,
          -- enableTestLenses = false,
          -- suggestSpecs = false,
        },
        on_attach = function(_, bufnr)
          local function map(mode, lhs, rhs)
            return function()
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
            end
          end

          map('n', '<space>lfp', ':ElixirFromPipe<cr>')
          map('n', '<space>ltp', ':ElixirToPipe<cr>')
          map('v', '<space>lm',  ':ElixirExpandMacro<cr>')
        end
      }
    })
  end,
}

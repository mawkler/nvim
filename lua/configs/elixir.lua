-----------------------
-- elixir-tools.nvim --
-----------------------
return {
  'elixir-tools/elixir-tools.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  version = '*',
  event = 'FileType elixir',
  config = function()
    require('elixir').setup({
      elixirls = {
        settings = require('elixir.elixirls').settings {
          dialyzerEnabled        = true, -- Run ElixirLS's rapid Dialyzer when code is saved
          incrementalDialyzer    = true, -- Use OTP incremental dialyzer
          suggestSpecs           = true, -- Suggest `@spec` annotations inline, using Dialyzer's inferred success typings
          signatureAfterComplete = true, -- Show signature help after confirming autocomplete.
          enableTestLenses       = true, -- Show code lenses to run tests in terminal.
        },
        on_attach = function(_, bufnr)
          local function map(mode, lhs, rhs)
            return function()
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
            end
          end

          map('n', '<leader>lP', ':ElixirFromPipe<cr>')
          map('n', '<leader>lp', ':ElixirToPipe<cr>')
          map('v', '<leader>lm', ':ElixirExpandMacro<cr>')
        end
      },
      projectionist = { enable = false },
    })
  end
}

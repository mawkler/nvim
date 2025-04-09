----------------------
-- TypeScript Tools --
----------------------
return {
  'pmizio/typescript-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
    -- Prettier TypeScript errors (in diagnostics)
    'davidosomething/format-ts-errors.nvim',
    -- Prettier TypeScript errors (in its own windows)
    { 'youyoumu/pretty-ts-errors.nvim', opts = { auto_open = false } },
  },
  ft = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
  opts = {
    on_attach = function(client, bufnr)
      local pretty_errors = require('pretty-ts-errors')

      -- Disable formatting (use prettier instead, see `conform.lua`)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      local map = require('utils').local_map(bufnr)
      local function spread(char)
        return function()
          require('utils').feedkeys('siw' .. char .. '%' .. 'i...<Esc>Ea, ', 'm')
        end
      end

      map('n', '<leader>lo', '<cmd>TSToolsOrganizeImports<CR>',   'LSP Organize imports')
      map('n', '<leader>li', '<cmd>TSToolsAddMissingImports<CR>', 'LSP add missing imports')
      map('n', '<leader>lf', '<cmd>TSToolsFixAll<CR>',            'LSP fix all errors')
      map('n', '<leader>lu', '<cmd>TSToolsRemoveUnused<CR>',      'LSP remove unused')
      map('n', '<leader>lr', '<cmd>TSToolsRenameFile<CR>',        'LSP rename file')
      map('n', '<leader>lc', function() require('tsc').run() end, 'Type check project')
      map('n', '<leader>ls', spread('{'), {
        remap = true,
        desc = 'Spread object under cursor'
      })
      map('n', '<leader>lS', spread('['), {
        remap = true,
        desc = 'Spread array under cursor'
      })

      -- Pretty errors
      map('n', '<leader>E',  '<cmd>fclose!<CR><cmd>PrettyTsError<CR>', 'Show TS error')
      map('n', '<leader>le', pretty_errors.open_all_errors,            'Show all TS errors')
    end,
    handlers = {
      ['textDocument/publishDiagnostics'] = function(_, result, ctx)
        if result.diagnostics == nil then
          return
        end

        -- Ignore some ts_ls diagnostics
        local idx = 1
        -- TODO: change to using `map()` instead of `while`
        while idx <= #result.diagnostics do
          local entry = result.diagnostics[idx]

          local formatter = require('format-ts-errors')[entry.code]
          entry.message = formatter and formatter(entry.message) or entry.message

          if entry.code == 80001 then
            table.remove(result.diagnostics, idx)
          else
            idx = idx + 1
          end
        end

        vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx)
      end,
    },
  },
}

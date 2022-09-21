---------------
-- LSP stuff --
---------------
return { 'neovim/nvim-lspconfig',
  requires = {
    'williamboman/nvim-lsp-installer',      -- LspInstall commands
    'b0o/schemastore.nvim',                 -- YAML/JSON schemas
    'onsails/lspkind-nvim',                 -- Completion icons
    'jose-elias-alvarez/nvim-lsp-ts-utils', -- TypeScript utilities
    'folke/lua-dev.nvim'                    -- Lua signature help and completion
  },
  config = function()
    local map, plugin_setup = require('utils').map, require('utils').plugin_setup
    local lsp, diagnostic = vim.lsp, vim.diagnostic
    local lspconfig = require('lspconfig')
    local telescope = require('telescope.builtin')

    -------------------
    -- LSP Installer --
    -------------------
    plugin_setup('nvim-lsp-installer')

    local lsp_server_dir = vim.fn.stdpath('data') .. '/lsp_servers/'

    -- Typescript --
    lspconfig.tsserver.setup({
      init_options = require('nvim-lsp-ts-utils').init_options,
      on_attach = function(client)
        local ts_utils = require('nvim-lsp-ts-utils')
        ts_utils.setup({
          update_imports_on_move = true,
          require_confirmation_on_move = true,
          auto_inlay_hints = false,
          inlay_hints_highlight = 'NvimLspTSUtilsInlineHint'
        })
        ts_utils.setup_client(client)

        local opts = { buffer = true }
        map('n', '<leader>lo', '<cmd>TSLspOrganize<CR>', opts)
        map('n', '<leader>lr', '<cmd>TSLspRenameFile<CR>', opts)
        map('n', '<leader>li', '<cmd>TSLspImportAll<CR>', opts)
        map('n', '<leader>lI', '<cmd>TSLspImportCurrent<CR>', opts)
        map('n', '<leader>lh', '<cmd>TSLspToggleInlayHints<CR>', opts)
      end,
    })

    -- Lua --
    import('lua-dev', function(luadev)
      lspconfig.sumneko_lua.setup(luadev.setup({
        lspconfig = {
          settings = {
            Lua = {
              diagnostics = {
                globals = {'use', 'packer_plugins'},
              }
            }
          }
        }
      }))
    end)

    -- YAML --
    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          schemaStore = {
            url = 'https://www.schemastore.org/api/json/catalog.json',
            enable = true
          }
        }
      }
    })

    -- Zsh/Bash --
    lspconfig.bashls.setup({
      filetypes = {'sh', 'zsh'}
    })

    -- Json --
    lspconfig.jsonls.setup({
      json = {
        schemas = require('schemastore').json.schemas()
      }
    })

    -- Bicep --
    lspconfig.bicep.setup({
      cmd = { 'dotnet', lsp_server_dir .. 'bicep/Bicep.LangServer.dll' }
    })

    -- HTML --
    lspconfig.html.setup {}


    -- Python --
    lspconfig.pylsp.setup {}

    ------------
    -- Config --
    ------------

    -- Add borders to hover/signature windows
    lsp.handlers['textDocument/hover'] = lsp.with(
      lsp.handlers.hover,
      { border = 'single' }
    )

    lsp.handlers['textDocument/signatureHelp'] = lsp.with(
      lsp.handlers.signature_help,
      { border = 'single' }
    )

    -- Enable LSP snippets by default
    local util = require('lspconfig.util')
    local capabilities = lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    util.default_config = vim.tbl_extend('force', util.default_config, {
      capabilities = { my_capabilities = capabilities, }
    })

    -------------
    -- LSPKind --
    -------------
    require('lspkind').init {
      symbol_map = {
        Class     = '',
        Interface = '',
        Module    = '',
        Enum      = '',
        Text      = '',
        Struct    = ''
      }
    }

    -------------
    -- Keymaps --
    -------------
    local INFO = vim.diagnostic.severity.INFO
    local error_opts = {severity = { min = INFO }, float = { border = 'single' }}
    local info_opts = {severity = { max = INFO }, float = { border = 'single' }}
    local with_border = {float = { border = 'single' }}

    local function lsp_references()
      require('utils').clear_lsp_references()
      vim.lsp.buf.document_highlight()
      require('telescope.builtin').lsp_references({
        include_declaration = false,
        -- fname_width = 60,
      })
    end

    map('n', 'gd',         telescope.lsp_definitions, 'vim.lsp.buf.definition')
    map('n', 'gi',         telescope.lsp_implementations, 'vim.lsp.buf.implementation')
    map('n', 'gd',         telescope.lsp_definitions, 'LSP definitions')
    map('n', 'gi',         telescope.lsp_implementations, 'LSP implementations')
    map('n', '<leader>ts', telescope.lsp_document_symbols, 'LSP document symbols')
    map('n', '<leader>tS', telescope.lsp_workspace_symbols, 'LSP workspace symbols')
    map('n', '<leader>tw', telescope.lsp_dynamic_workspace_symbols, 'LSP dynamic workspace symbols')
    map('n', 'gr',         lsp_references, 'LSP references')

    map('n',        'gD',        lsp.buf.type_definition, 'vim.lsp.buf.type_definition')
    map('n',        'gh',        lsp.buf.hover, 'vim.lsp.buf.hover')
    map('n',        'gs',        lsp.buf.signature_help, 'vim.lsp.buf.signature_help')
    map({'i', 's'}, '<M-s>',     lsp.buf.signature_help, 'vim.lsp.buf.signature_help')
    map({'n', 'x'}, '<leader>r', vim.lsp.buf.rename, 'vim.lsp.buf.rename')
    map({'n', 'x'}, '<leader>a', lsp.buf.code_action, 'vim.lsp.buf.code_action')
    map('n',        '<leader>e', function() return diagnostic.open_float({border = 'single'}) end, 'Diagnostic open float')
    map({'n', 'x'}, ']e',        function() return diagnostic.goto_next(error_opts) end, 'Next error')
    map({'n', 'x'}, '[e',        function() return diagnostic.goto_prev(error_opts) end, 'Previous error')
    map({'n', 'x'}, '[h',        function() return diagnostic.goto_prev(info_opts) end, 'Previous info')
    map({'n', 'x'}, ']h',        function() return diagnostic.goto_next(info_opts) end, 'Next info')
    map({'n', 'x'}, ']d',        function() return diagnostic.goto_next(with_border) end, 'Next diagnostic')
    map({'n', 'x'}, '[d',        function() return diagnostic.goto_prev(with_border) end, 'Previous diagnostic')
    map('n',        '<C-w>gd',   '<C-w>vgd', {desc = 'LSP go to definition in window split', remap = true})
    map('n',        '<C-w>gi',   '<C-w>vgi', {desc = 'LSP go to implementaiton in window split', remap = true})
    map('n',        '<C-w>gD',   '<C-w>vgD', {desc = 'LSP go to type definition in window split', remap = true})

  end
}

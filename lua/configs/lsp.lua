-------------------
-- LSP Installer --
-------------------
return { 'neovim/nvim-lspconfig',
  requires = {
    'williamboman/nvim-lsp-installer', -- Adds LspInstall commands
    'b0o/schemastore.nvim',            -- Adds YAML/JSON schemas
  },
  config = function()
    local map = require('../utils').map
    local lsp, diagnostic = vim.lsp, vim.diagnostic

    -- Enable LSP snippets by default
    local util = require('lspconfig.util')
    local capabilities = lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    util.default_config = vim.tbl_extend('force', util.default_config, {
      capabilities = { my_capabilities = capabilities, }
    })

    -- Typescript LSP config
    local typescript_settings = {
      init_options = require('nvim-lsp-ts-utils').init_options,
      on_attach = function(client)
        local ts_utils = require('nvim-lsp-ts-utils')
        ts_utils.setup({
          update_imports_on_move = true,
          require_confirmation_on_move = true,
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
    }

    -- Lua LSP config
    local lua_settings = require('lua-dev').setup {
      lspconfig = {
        settings = {
          Lua = {
            diagnostics = {
              globals = {'use'},
            }
          }
        }
      }
    }

    -- YAML LSP config
    local yaml_settings = {
      settings = {
        yaml = {
          schemaStore = {
            url = 'https://www.schemastore.org/api/json/catalog.json',
            enable = true
          }
        }
      }
    }

    -- Zsh/Bash LSP config
    local bash_settings = {
      filetypes = {'sh', 'zsh'}
    }

    -- Json
    local json_settings = {
      json = {
        schemas = require('schemastore').json.schemas()
      }
    }

    require('nvim-lsp-installer').setup()
    local lspconfig = require('lspconfig')

    lspconfig.sumneko_lua.setup(lua_settings)
    lspconfig.tsserver.setup(typescript_settings)
    lspconfig.bashls.setup(bash_settings)
    lspconfig.yamlls.setup(yaml_settings)
    lspconfig.jsonls.setup(json_settings)

    ----------------
    -- LSP Config --
    ----------------
    lsp.handlers['textDocument/hover'] = lsp.with(
      lsp.handlers.hover,
      { border = 'single' }
    )

    lsp.handlers['textDocument/signatureHelp'] = lsp.with(
      lsp.handlers.signature_help,
      { border = 'single' }
    )

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

    ------------------
    -- LSP Mappings --
    ------------------
    local INFO = vim.diagnostic.severity.INFO
    local error_opts = {severity = { min = INFO }, float = { border = 'single' }}
    local info_opts = {severity = { max = INFO }, float = { border = 'single' }}
    local with_border = {float = { border = 'single' }}

    local function lsp_references()
      require('../utils').clear_lsp_references()
      vim.lsp.buf.document_highlight()
      require('telescope.builtin').lsp_references({ include_declaration = false })
    end

    -- LSP and diagnostics
    map('n',        'gd',        require('telescope.builtin').lsp_definitions, 'vim.lsp.buf.definition')
    map('n',        'gi',        require('telescope.builtin').lsp_implementations, 'vim.lsp.buf.implementation')
    map('n',        'gD',        lsp.buf.type_definition, 'vim.lsp.buf.type_definition')
    map('n',        'gh',        lsp.buf.hover, 'vim.lsp.buf.hover')
    map('n',        'gs',        lsp.buf.signature_help, 'vim.lsp.buf.signature_help')
    map({'i', 's'}, '<M-s>',     lsp.buf.signature_help, 'vim.lsp.buf.signature_help')
    map('n',        'gr',        lsp_references, 'vim.lsp.buf.references')
    map({'n', 'x'}, '<leader>r', vim.lsp.buf.rename, 'vim.lsp.buf.rename')
    map({'n', 'x'}, '<leader>a', lsp.buf.code_action, 'vim.lsp.buf.code_action')
    map('n',        '<leader>e', function() return diagnostic.open_float({border = 'single'}) end, 'diagnostic.open_float')
    map({'n', 'x'}, ']e',        function() return diagnostic.goto_next(error_opts) end, 'diagnostic.goto_next')
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

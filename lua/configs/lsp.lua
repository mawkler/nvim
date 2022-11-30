---------------
-- LSP stuff --
---------------
return { 'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',              -- For installing LSP servers
    'williamboman/mason-lspconfig.nvim',    -- Integration with nvim-lspconfig
    'b0o/schemastore.nvim',                 -- YAML/JSON schemas
    'onsails/lspkind-nvim',                 -- Completion icons
    'jose-elias-alvarez/nvim-lsp-ts-utils', -- TypeScript utilities
    'folke/neodev.nvim'                     -- Lua signature help and completion
  },
  config = function()
    local map = require('utils').map
    local lsp, diagnostic = vim.lsp, vim.diagnostic
    local lspconfig = require('lspconfig')
    local telescope = require('telescope.builtin')
    local path = require('mason-core.path')

    local servers_path = path.concat({
      vim.fn.stdpath('data'),
      'mason',
      'packages',
    })

    -- TypeScript --
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

        local function spread(char)
          return function()
            require('utils').feedkeys('siw' .. char .. 'a...<Esc>2%i, ', 'm')
          end
        end

        local opts = { buffer = true }
        map('n', '<leader>lo', '<cmd>TSLspOrganize<CR>', opts)
        map('n', '<leader>lr', '<cmd>TSLspRenameFile<CR>', opts)
        map('n', '<leader>li', '<cmd>TSLspImportAll<CR>', opts)
        map('n', '<leader>lI', '<cmd>TSLspImportCurrent<CR>', opts)
        map('n', '<leader>lh', '<cmd>TSLspToggleInlayHints<CR>', opts)
        map('n', '<leader>ls', spread('{'), {
          buffer = true,
          remap = true,
          desc = 'Spread object under cursor'
        })
        map('n', '<leader>lS', spread('['), {
          buffer = true,
          remap = true,
          desc = 'Spread array under cursor'
        })
      end,
    })

    -- Lua --
    require('neodev').setup()

    lspconfig.sumneko_lua.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'use', 'packer_plugins', 'import' },
          },
          completion = {
            callSnippet = 'Replace',
            autoRequire = true,
          },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = 'space',
              indent_size = '2',
              max_line_length = '100',
              trailing_table_separator = 'smart',
            },
          },
        }
      }
    })

    -- Vim --
    lspconfig.vimls.setup({})

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
    lspconfig.jsonls.setup {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    }

    -- Bicep --
    lspconfig.bicep.setup({
      cmd = {
        'dotnet',
        path.concat({
          servers_path,
          'bicep-lsp',
          'bicepLanguageServer',
          'Bicep.LangServer.dll',
        })
      }
    })

    -- HTML --
    lspconfig.html.setup {}


    -- Python --
    lspconfig.pylsp.setup {}

    -- LTeX --
    lspconfig.ltex.setup {
      autostart = false,
    }

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

    local function diagnostic_goto(direction, opts)
      return function()
        diagnostic['goto_' .. direction](opts)
      end
    end

    local function lsp_references()
      require('utils').clear_lsp_references()
      vim.lsp.buf.document_highlight()
      telescope.lsp_references({ include_declaration = false })
    end

    map('n', 'gd',         telescope.lsp_definitions,               'LSP definitions')
    map('n', 'gD',         telescope.lsp_type_definitions,          'LSP type definitions')
    map('n', 'gi',         telescope.lsp_implementations,           'LSP implementations')
    map('n', '<leader>ts', telescope.lsp_document_symbols,          'LSP document symbols')
    map('n', '<leader>tS', telescope.lsp_workspace_symbols,         'LSP workspace symbols')
    map('n', '<leader>tw', telescope.lsp_dynamic_workspace_symbols, 'LSP dynamic workspace symbols')
    map('n', 'gr',         lsp_references,                          'LSP references')

    map('n',        'gh',        lsp.buf.hover,          'LSP hover')
    map('n',        'gs',        lsp.buf.signature_help, 'LSP signature help')
    map({'i'; 's'}, '<M-s>',     lsp.buf.signature_help, 'LSP signature help')
    map({'n'; 'x'}, '<leader>r', lsp.buf.rename,         'LSP rename')
    map({'n'; 'x'}, '<leader>a', lsp.buf.code_action,    'LSP code action')

    map({'n', 'x'}, ']e',        diagnostic_goto('next', error_opts), 'Go to next error')
    map({'n', 'x'}, '[e',        diagnostic_goto('prev', error_opts), 'Go to previous error')
    map({'n', 'x'}, '[h',        diagnostic_goto('prev', info_opts), 'Go to previous info')
    map({'n', 'x'}, ']h',        diagnostic_goto('next', info_opts), 'Go to next info')
    map({'n', 'x'}, ']d',        diagnostic_goto('next', with_border), 'Go to next diagnostic')
    map({'n', 'x'}, '[d',        diagnostic_goto('prev', with_border), 'Go to previous diagnostic')
    map('n',        '<leader>e', function()
      diagnostic.open_float({ border = 'single' })
    end, 'Diagnostic open float')

    map('n', '<C-w>gd', '<C-w>vgd', { desc = 'LSP definition in window split',      remap = true })
    map('n', '<C-w>gi', '<C-w>vgi', { desc = 'LSP implementaiton in window split',  remap = true })
    map('n', '<C-w>gD', '<C-w>vgD', { desc = 'LSP type definition in window split', remap = true })

  end
}

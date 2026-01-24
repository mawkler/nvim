---------------
-- LSP stuff --
---------------
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',           -- For installing LSP servers
    'mason-org/mason-lspconfig.nvim', -- Integration with nvim-lspconfig
    'b0o/schemastore.nvim',           -- YAML/JSON schemas
  },
  config = function()
    local api, lsp = vim.api, vim.lsp
    local utils = require('utils')
    local map = utils.local_map(0)

    local eslint_on_attach = vim.lsp.config.eslint.on_attach
    ---------------------------
    -- Server configurations --
    ---------------------------
    local server_configs = {
      -- Lua --
      lua_ls = {
        settings = {
          Lua = {
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
            diagnostics = {
              globals = { 'vim', 'it', 'describe', 'before_each', 'are' },
            },
            hint = {
              enable = true,
              arrayIndex = 'Disable',
            },
            workspace = {
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          }
        },
        on_attach = function()
          map('n', '<leader>lt', '<Plug>PlenaryTestFile', "Run file's plenary tests")
        end
      },
      -- YAML --
      yamlls = {
        -- Lazy-load schemastore when needed
        on_new_config = function(config)
          config.settings.yaml.schemas = vim.tbl_deep_extend(
            'force',
            config.settings.yaml.schemas or {},
            require('schemastore').yaml.schemas()
          )
        end,
        settings = {
          redhat = {
            telemetry = { enabled = false },
          },
          yaml = {
            schemaStore = {
              -- Disable built-in schemaStore to use schemas from SchemaStore.nvim
              enable = false,
              url = '',
            },
            customTags = {
              -- AWS CloudFormation tags
              '!Equals sequence', '!FindInMap sequence', '!GetAtt', '!GetAZs',
              '!ImportValue', '!Join sequence', '!Ref', '!Select sequence',
              '!Split sequence', '!Sub', '!Or sequence'
            },
          }
        },
        -- Don't attach to Azure Pipeline files (azure_pipelines_ls does that)
        on_attach = function(client, bufnr)
          local path = vim.api.nvim_buf_get_name(bufnr)
          local filename = vim.fn.fnamemodify(path, ':t')
          local is_pipeline_file = #vim.fn.glob('azure-pipeline*.y*ml', true, filename) > 0

          if is_pipeline_file then
            lsp.stop_client(client)
          end
        end
      },
      -- Eslint --
      eslint = {
        on_attach = function(client, bufnr)
          if not eslint_on_attach then return end

          eslint_on_attach(client, bufnr)

          api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'LspEslintFixAll',
          })
        end,
      },
      -- Bash/Zsh --
      bashls = {
        settings = {
          bashIde = {
            shfmt = {
              spaceRedirects = true, -- Allow space after `>` symbols
            },
          },
        },
      },
      -- Json --
      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },
      -- Bicep --
      bicep = {
        cmd = { 'bicep-lsp' }
      },
      tinymist = {
        on_attach = function()
          map('n', '<leader>lw', '<cmd>TypstWatch<CR>', 'Watch file')
        end,
        settings = {
          formatterMode = 'typstyle',
          exportPdf = 'onType',
        }
      },
      -- Typos --
      typos_lsp = {
        on_attach = function(client, _)
          -- Disabled for Markdown, use LTeX instead
          local disabled_filetypes = vim.iter({ 'markdown', 'NvimTree', 'help' })
          if disabled_filetypes:find(vim.bo.filetype) ~= nil then
            -- Force-shutdown seems to be necessary for some reason
            vim.lsp.stop_client(client.id, true)
          end
        end,
        init_options = {
          diagnosticSeverity = 'hint',
          -- Fixes issue where config is ignored when opening a file with
          -- Telescope from some other directory
          config = vim.env.HOME .. '/.typos.toml',
        }
      },
      -- Python --
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              -- Disable formatting diagnostics (that's what formatters are for)
              pylint = { enabled = false },
              pycodestyle = { enabled = false },
            }
          }
        },
      },
      -- Azure pipelines --
      azure_pipelines_ls = {
        root_dir = require('lspconfig.util').root_pattern('azure-pipeline*.y*ml'),
        settings = {
          yaml = {
            schemas = {
              ['https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json']
              = 'azure-pipeline*.y*ml',
            },
          },
        },
      },
      ltex_plus = {
        settings = {
          ltex = {
            language = 'auto',
            diagnosticSeverity = 'hint',
            sentenceCacheSize = 2000,
            additionalRules = {
              motherTongue = 'sv',
            },
          },
        },
      },
      hyprls = {},
      roc_ls = {},
      fish_lsp = {},
      harper_ls = {
        filetypes = { 'markdown', 'typst' },
        settings = {
          ['harper-ls'] = {
            linters = { UseTitleCase = false },
            isolateEnglish = true,
          },
        },
      },
    }

    -- Doesn't exist in Mason yet
    vim.lsp.config.nixd = {
      settings = {
        nixd = {
          formatting = {
            command = { 'nixfmt' },
          },
        },
      },
    }
    vim.lsp.config.nil_ls = {
      on_attach = function(client, _)
        -- These are already covered by nixd
        local disabled_capabilities = {
          'definitionProvider',
          'referencesProvider',
          'implementationProvider',
          'diagnosticProvider',
          'completionProvider',
          'hoverProvider',
          'documentFormattingProvider',
          'renameProvider',
        }
        for _, capability in ipairs(disabled_capabilities) do
          client.server_capabilities[capability] = false
        end

        -- Diagnostics have to be disabled on the client side
        client.handlers['textDocument/publishDiagnostics'] = function(...)
          local result = select(2, ...)
          result.diagnostics = {}
        end
      end
    }

    -- These have their own plugins that enable them
    local special_server_configs = { 'ts_ls', 'zk', 'rust_analyzer', 'gopls', 'nextls', 'elixirls' }

    -----------------------
    -- Configure servers --
    -----------------------
    for server_name, config in pairs(server_configs) do
      -- Enable folding (required by ufo.nvim)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
      config.capabilities = vim.tbl_deep_extend(
        'keep',
        config.capabilities or {},
        capabilities
      )

      vim.lsp.config(server_name, config)
    end

    local ensure_installed = vim.list_extend(
      vim.tbl_keys(server_configs),
      special_server_configs
    )

    require('mason-lspconfig').setup({
      ensure_installed = not utils.is_nixos() and ensure_installed or {},
      -- TODO: perhaps this can be removed to only use the chunk below
      automatic_enable = {
        exclude = special_server_configs,
      },
    })

    -- If we're on NixOS masons `automatic_enable` doesn't work
    if utils.is_nixos() then
      for server, _ in pairs(server_configs) do
        assert(type(server) == 'string')
        vim.lsp.enable(server)
      end

      vim.lsp.enable({ 'nixd', 'nil_ls' })
    end

    -------------
    -- Keymaps --
    -------------
    local function lsp_references()
      utils.clear_lsp_references()

      local method = 'textDocument/documentHighlight'
      if #vim.lsp.get_clients({ method = method }) > 0 then
        lsp.buf.document_highlight()
      end

      require('telescope.builtin').lsp_references({ include_declaration = false })
    end

    local function attach_codelens(bufnr)
      local augroup = api.nvim_create_augroup('Lsp', {})
      api.nvim_create_autocmd({ 'BufReadPost', 'CursorHold', 'InsertLeave' }, {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp.codelens.refresh({ bufnr = bufnr })
        end,
      })
    end

    local function map_vsplit(lhs, fn, description)
      vim.keymap.set('n', lhs, function()
        require('telescope.builtin')[fn]({ jump_type = 'vsplit' })
      end, { desc = description })
    end

    local function attach_keymaps()
      local telescope = require('telescope.builtin')
      local nx = { 'n', 'x' }
      local is = { 'i', 's' }

      map('n', 'gd',         telescope.lsp_definitions,               'LSP definitions')
      map('n', 'gD',         telescope.lsp_type_definitions,          'LSP type definitions')
      map('n', 'gi',         telescope.lsp_implementations,           'LSP implementations')
      map('n', '<leader>ts', telescope.lsp_document_symbols,          'LSP document symbols')
      map('n', '<leader>tS', telescope.lsp_workspace_symbols,         'LSP workspace symbols')
      map('n', '<leader>tw', telescope.lsp_dynamic_workspace_symbols, 'LSP dynamic workspace symbols')
      map('n', 'gr',         lsp_references,                          'LSP references')

      map('n', 'gs',        lsp.buf.signature_help, 'LSP signature help')
      map(is,  '<M-s>',     lsp.buf.signature_help, 'LSP signature help')
      map(nx,  '<leader>r', lsp.buf.rename,         'LSP rename')
      map(nx,  '<leader>A', lsp.codelens.run,       'LSP code lens')

      map('n', '<leader>e', function() vim.diagnostic.open_float({ border = 'single' }) end,
        'Diagnostic open float')

      local function diagnostic_jump(count, severity)
        local float = { border = 'rounded' }
        return function()
          vim.diagnostic.jump({ count = count, severity = severity, float = float })
        end
      end

      local nxo = { 'n', 'x', 'o' }
      local severity = vim.diagnostic.severity
      local error, warn, info, hint = severity.ERROR, severity.WARN, severity.INFO, severity.HINT

      map(nxo, ']d', diagnostic_jump(1),  { desc = 'Next diagnostic' })
      map(nxo, '[d', diagnostic_jump(-1), { desc = 'Previous diagnostic' })

      map(nxo, ']e', diagnostic_jump(1, error),  { desc = 'Next error' })
      map(nxo, '[e', diagnostic_jump(-1, error), { desc = 'Previous error' })

      map(nxo, ']w', diagnostic_jump(1, warn),  { desc = 'Next warning' })
      map(nxo, '[w', diagnostic_jump(-1, warn), { desc = 'Previous warning' })

      map(nxo, ']i', diagnostic_jump(1, info), { desc = 'Next info' })
      map(nxo, '[i', diagnostic_jump(1, info), { desc = 'Previous info' })

      map(nxo, ']h', diagnostic_jump(1, hint),  { desc = 'Next hint' })
      map(nxo, '[h', diagnostic_jump(-1, hint), { desc = 'Previous hint' })

      map_vsplit('<C-w>gd', 'lsp_definitions')
      map_vsplit('<C-w>gi', 'lsp_implementations')
      map_vsplit('<C-w>gD', 'lsp_type_definitions')

      map('n', '<leader>lq', '<cmd>LspStop<CR>', { desc = 'Stop LSP server' })
    end

    ---------------------------
    -- Default LSP on_attach --
    ---------------------------
    local augroup = api.nvim_create_augroup('LSP', { clear = true })
    api.nvim_create_autocmd('LspAttach', {
      group = augroup,
      desc = 'Default LSP on_attach',
      callback = function(event)
        local client = lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        -- Keymaps
        attach_keymaps()

        -- Code lens
        if client.server_capabilities.codeLensProvider then
          attach_codelens(event.buf)
        end

        -- Inlay hints
        lsp.inlay_hint.enable()

        map('n', '<leader>lh', function()
          lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
        end, 'Toggle LSP inlay hints')

        -- This has to be called from LspAttach event for some reason, not sure why
        vim.diagnostic.config({
          signs = false,
          virtual_text = {
            spacing = 4,
            prefix = function(diagnostic, _, _)
              local icon = require('configs.diagnostics').get_icon(diagnostic.severity)
              return ' ' .. icon
            end,
          }
        })
      end
    })
  end
}

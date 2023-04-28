---------------
-- LSP stuff --
---------------
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',               -- For installing LSP servers
    'williamboman/mason-lspconfig.nvim',     -- Integration with nvim-lspconfig
    'b0o/schemastore.nvim',                  -- YAML/JSON schemas
    'jose-elias-alvarez/typescript.nvim',    -- TypeScript utilities
    'folke/neodev.nvim',                     -- Lua signature help and completion
    'simrat39/rust-tools.nvim',              -- Rust tools
    'davidosomething/format-ts-errors.nvim', -- Prettier TypeScript errors
    { 'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  },
  event = 'VeryLazy',
  config = function()
    local lsp, diagnostic = vim.lsp, vim.diagnostic
    local lspconfig, util = require('lspconfig'), require('lspconfig.util')
    local telescope = require('telescope.builtin')
    local path = require('mason-core.path')
    local rust_tools = require('rust-tools')
    local typescript = require('typescript')
    local get_install_path  = require('utils').get_install_path

    local map = function(modes, lhs, rhs, opts)
      if type(opts) == 'string' then
        opts = { desc = opts }
      end
      opts = vim.tbl_extend('keep', opts, { buffer = true })
      return require('utils').map(modes, lhs, rhs, opts)
    end

    -- TypeScript --
    local tsserver_config = {
      on_attach = function()
        local actions = typescript.actions

        local function spread(char)
          return function()
            require('utils').feedkeys('siw' .. char .. 'a...<Esc>2%i, ', 'm')
          end
        end

        local function rename_file()
          local workspace_path = vim.lsp.buf.list_workspace_folders()[1]
          local file_path = vim.fn.expand('%:' .. workspace_path .. ':.')
          vim.ui.input({ prompt = 'Rename file', default = file_path },
            function(target)
              if target ~= nil then
                typescript.renameFile(file_path, target)
              end
            end
          )
        end

        map('n', '<leader>lo', actions.organizeImports, 'LSP Organize imports')
        map('n', '<leader>li', actions.addMissingImports, 'LSP add missing imports')
        map('n', '<leader>lf', actions.fixAll, 'LSP fix all errors')
        map('n', '<leader>lu', actions.removeUnused, 'LSP remove unused')
        map('n', '<leader>lr', rename_file, 'LSP rename file')
        map('n', '<leader>lc', function() require('tsc').run() end, 'Type check project')
        map('n', '<leader>ls', spread('{'), {
          remap = true,
          desc = 'Spread object under cursor'
        })
        map('n', '<leader>lS', spread('['), {
          remap = true,
          desc = 'Spread array under cursor'
        })
      end,
      handlers = {
        ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
          if result.diagnostics == nil then
            return
          end

          -- Ignore some tsserver diagnostics
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

          vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end,
      },
    }

    local eslint_config = {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    }

    -- Lua --
    require('neodev').setup()

    local lua_config = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
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
    }

    -- Rust --
    local rust_config = {
      tools = {
        inlay_hints = {
          max_len_align = true,
          highlight = 'InlineHint',
        },
      },
      server = {
        on_attach = function()
          map('n', '<Leader>a', rust_tools.code_action_group.code_action_group, {
            desc = 'LSP action (rust-tools)',
          })
        end,
      },
    }

    -- YAML --
    local yaml_config = {
      settings = {
        yaml = {
          schemaStore = {
            url = 'https://www.schemastore.org/api/json/catalog.json',
            enable = true
          }
        }
      }
    }

    -- Zsh/Bash --
    local bash_config = {
      filetypes = {'sh', 'zsh'}
    }

    -- Json --
    local json_config = {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    }

    -- Bicep --
    local bicep_config = {
      cmd = {
        'dotnet',
        path.concat({
          get_install_path('bicep-lsp'),
          'bicepLanguageServer',
          'Bicep.LangServer.dll',
        })
      }
    }

    -- Azure pipeline --
    local azure_pipelines_path = get_install_path('azure-pipelines-language-server')
    local azure_pipelines_config = {
      cmd = { azure_pipelines_path .. '/azure-pipelines-language-server', '--stdio'},
      settings = {
        yaml = {
          schemas = {
            ['https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json'] = {
              '/azure-pipeline*.y*l',
              '/*.azure*',
              'Azure-Pipelines/**/*.y*l',
              'Pipelines/*.y*l',
            }
          }
        }
      }
    }

    -- LTeX --
    local ltex_config = {
      autostart = false,
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
    }

    -----------
    -- Setup --
    -----------
    local function setup(server_name, options)
      return function()
        lspconfig[server_name].setup(options or {})
      end
    end

    require('mason-lspconfig').setup_handlers({
      function(server_name)
        -- Fallback setup for any other language
        lspconfig[server_name].setup({})
      end,
      lua_ls = setup('lua_ls', lua_config),
      yamlls = setup('yamlls', yaml_config),
      bashls = setup('bashls', bash_config),
      jsonls = setup('jsonls', json_config),
      bicep = setup('bicep', bicep_config),
      ltex = setup('ltex', ltex_config),
      eslint = setup('eslint', eslint_config),
      azure_pipelines_ls = setup('azure_pipelines_ls', azure_pipelines_config),
      rust_analyzer = function()
        return rust_tools.setup(rust_config)
      end,
      tsserver = function ()
        typescript.setup({
          server = tsserver_config
        })
      end
    })

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
    local capabilities = lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    util.default_config = vim.tbl_extend('force', util.default_config, {
      capabilities = { my_capabilities = capabilities, }
    })

    -------------
    -- Keymaps --
    -------------
    local INFO = diagnostic.severity.INFO
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

    local function attach_codelens(bufnr)
      vim.api.nvim_create_augroup('Lsp', {})
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        group = 'Lsp',
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end

    local function attach_keymaps()
      map('n', 'gd',         telescope.lsp_definitions,               'LSP definitions')
      map('n', 'gD',         telescope.lsp_type_definitions,          'LSP type definitions')
      map('n', 'gi',         telescope.lsp_implementations,           'LSP implementations')
      map('n', '<leader>ts', telescope.lsp_document_symbols,          'LSP document symbols')
      map('n', '<leader>tS', telescope.lsp_workspace_symbols,         'LSP workspace symbols')
      map('n', '<leader>tw', telescope.lsp_dynamic_workspace_symbols, 'LSP dynamic workspace symbols')
      map('n', 'gr',         lsp_references,                          'LSP references')

      map('n',        'gh',        lsp.buf.hover,          'LSP hover')
      map('n',        'gs',        lsp.buf.signature_help, 'LSP signature help')
      map({'i', 's'}, '<M-s>',     lsp.buf.signature_help, 'LSP signature help')
      map({'n', 'x'}, '<leader>r', lsp.buf.rename,         'LSP rename')
      map({'n', 'x'}, '<leader>a', lsp.buf.code_action,    'LSP code action')
      map({'n', 'x'}, '<leader>A', lsp.codelens.run,       'LSP code lens')

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

      map('n', '<leader>ll', lsp.start, { desc = 'Start LSP server' })
    end

    local format_on_write_blacklist = { 'lua' }

    ---------------------------
    -- Default LSP on_attach --
    ---------------------------
    local augroup = vim.api.nvim_create_augroup('LSP', { clear = true })
    vim.api.nvim_create_autocmd('LspAttach', {
      group = augroup,
      desc = 'Default LSP on_attach',
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')

        -- Keymaps
        attach_keymaps()

        -- Autoformatting
        if not vim.tbl_contains(format_on_write_blacklist, filetype) then
          require('utils.formatting').format_on_write(client, bufnr)
        end

        -- Code lens
        if client.server_capabilities.codeLensProvider then
          attach_codelens(bufnr)
        end
      end
    })
  end
}

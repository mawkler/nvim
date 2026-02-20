------------------
-- Rustaceanvim --
------------------
return {
  'mrcjkb/rustaceanvim',
  dependencies = 'neovim/nvim-lspconfig',
  ft = { 'rust' },
  config = function()
    local settings = {
      check = {
        ignore = { 'dead_code', 'unused_variables' },
      },
      procMacro = {
        enable = false,
      },
      assist = {
        preferSelf = true,
      },
      completion = {
        snippets = {
          custom = {
            ['thread spawn'] = {
              prefix = { 'spawn' },
              body = {
                'thread::spawn(move || {',
                '\t$0',
                '});',
              },
              description = 'Insert a thread::spawn call',
              requires = 'std::thread',
              scope = 'expr',
            },
          },
        },
      },
    }

    -- Nice to have when not in a huge workspace
    if vim.uv.os_gethostname() ~= 'framework13-df' then
      local less_performant_settings = {
        check = {
          command = 'clippy', -- Add clippy lints for Rust.
          extraArgs = { '--no-deps' },
        },
        cargo = {
          features = 'all',
        },
        procMacro = {
          enable = true, -- The default
        },
      }

      settings = vim.tbl_deep_extend('force', settings, less_performant_settings)
    end

    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, bufnr)
          local map = require('utils').local_map(bufnr)

          map('n', '<leader>lc', '<cmd>RustLsp openCargo<CR>',        'Go to Cargo.toml')
          map('n', '<leader>lC', '<C-w>v<cmd>RustLsp openCargo<CR>',  'Go to Cargo.toml (in new window)')
          map('n', '<leader>le', '<cmd>RustLsp explainError<CR>',     'Explain error')
          map('n', '<leader>lj', '<cmd>RustLsp moveItem down<CR>',    'Move item down')
          map('n', '<leader>lk', '<cmd>RustLsp moveItem up<CR>',      'Move item up')
          map('n', '<leader>dd', '<cmd>RustLsp debug<CR>',            'Debug item under cursor')
          map('n', '<leader>dD', '<cmd>RustLsp debuggables<CR>',      'List debuggables')
          map('n', '<leader>dl', '<cmd>RustLsp! debuggables<CR>',     'Debug latest')
          map('n', '<leader>ld', '<cmd>RustLsp renderDiagnostic<CR>', 'Render idiagnostics')
          map('n', '<leader>lm', '<cmd>RustLsp expandMacro<CR>',      'Expand macro')
          map('n', '<leader>lr', '<cmd>RustLsp run<CR>',              'Run')
          map('n', '<leader>lR', '<cmd>RustLsp! run<CR>',             'Rerun latest run')
        end,
        settings = {
          ['rust-analyzer'] = settings,
        },
      }
    }
  end
}

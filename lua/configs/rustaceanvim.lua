------------------
-- Rustaceanvim --
------------------
return {
  'mrcjkb/rustaceanvim',
  dependencies = 'neovim/nvim-lspconfig',
  ft = { 'rust' },
  opts = {
    server = {
      on_attach = function(_, bufnr)
        local map = require('utils').local_map(bufnr)

        map('n', 'go',         '<cmd>RustLsp openCargo<CR>',        'Go to cargo.toml')
        map('n', '<C-w>go',    '<C-w>v<cmd>RustLsp openCargo<CR>',  'Go to cargo.toml (in new window)')
        map('n', '<leader>le', '<cmd>RustLsp explainError<CR>',     'Explain error')
        map('n', '<leader>lj', '<cmd>RustLsp moveItem down<CR>',    'Move item down')
        map('n', '<leader>lk', '<cmd>RustLsp moveItem up<CR>',      'Move item up')
        map('n', '<leader>dc', '<cmd>RustLsp debuggables last<CR>', 'Debug')
        map('n', '<leader>ld', '<cmd>RustLsp renderDiagnostic<CR>', 'Render idiagnostics')
        map('n', '<leader>lm', '<cmd>RustLsp expandMacro<CR>',      'Expand macro')
        map('n', '<leader>lr', '<cmd>RustLsp run<CR>',              'Run')
      end,
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true,
          },
          checkOnSave = { -- Add clippy lints for Rust.
            allFeatures = true,
            command = 'clippy',
            extraArgs = { '--no-deps' },
          },
          procMacro = {
            enable = true,
            ignored = {
              ['async-trait'] = { 'async_trait' },
              ['napi-derive'] = { 'napi' },
              ['async-recursion'] = { 'async_recursion' },
            },
          },
        },
      },
    }
  },
  config = function(_, opts)
    vim.g.rustaceanvim = opts or {}
  end
}

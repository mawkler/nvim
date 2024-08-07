--------
-- Go --
--------
return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'go', 'gomod' },
  config = function()
    local function on_attach()
      local map = require('utils').local_map(0)

      vim.o.shiftwidth = 0 -- Use tabstop's width

      map('n', '<leader>li', '<cmd>GoImports<CR>',         'Fix imports')
      map('n', '<leader>ld', '<cmd>GoInstallBinaries<CR>', 'Make sure all tools are updated')
      map('n', '<leader>lr', '<cmd>GoGenReturn<CR>',       'Go generate return values for function')
      map('n', 'go',         '<cmd>GoAlt<CR>',             'Go alternative file')
      map('n', '<C-w>go',    '<cmd>GoAltV<CR>',            'Go alternative file in vertical split')
      map('n', '<leader>lt', '<cmd>GoAddTag<CR>',          'Go add tag')

      map({'n', 'x'}, '<leader>lj', '<cmd>GoJson2Struct<CR>', 'Go struct from json')
    end

    require('go').setup({
      lsp_cfg = {
        settings = {
          gopls = {
            analyses = {
              unusedvariable = false,
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      },
      lsp_inlay_hints = { enable = false }, -- Handled in lsp-inlay-hints.lua
      lsp_keymaps = false,
      lsp_on_attach = on_attach,
      lsp_codelens = false, -- Temporary fix for https://github.com/ray-x/go.nvim/issues/113
      luasnip = true,
    })
  end
}

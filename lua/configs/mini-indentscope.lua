----------------------
-- Mini indentscope --
----------------------
return {
  'echasnovski/mini.indentscope',
  enabled = vim.g.vscode == nil,
  event = 'VeryLazy',
  opts = {
    symbol = '▏',
  },
  -- config = function()
  --   local augroup = vim.api.nvim_create_augroup('MiniIndentScope', {})

  --   -- TODO: import from indent-blankline
  --   local filetype_exclude = {
  --     'markdown',
  --     'alpha',
  --     'sagahover',
  --     'NvimTree',
  --     'mason',
  --     'toggleterm',
  --     'lazy',
  --   }

  --   -- vim.api.nvim_create_autocmd('FileType', {
  --   --   pattern = 'FileType',
  --   --   group = augroup,
  --   --   callback = function()
  --   --     vim.b.miniindentscope_disable = true
  --   --   end,
  --   -- })
  -- end
}

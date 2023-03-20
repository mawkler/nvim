-----------
-- Other --
-----------
return {
  'rgroli/other.nvim',
  keys = {
    { 'go',      '<cmd>Other<CR>',       desc = 'Alternate file' },
    { '<C-w>go', '<cmd>OtherVSplit<CR>', desc = 'Alternate file (vsplit)' },
  },
  cmd = { 'Other', 'OtherSplit', 'OtherVSplit' },
  config = function()
    require('other-nvim').setup({
      mappings = {
        -- TypeScript Azure functions
        {
          pattern = '/(.*)/index.ts$',
          target = '/%1/function.json',
        },
        {
          pattern = '/(.*)/function.json$',
          target = '/%1/index.ts',
        },
        -- init.lua from any plugin configuration
        {
          pattern = '/lua/configs/.*.lua$',
          target = '/init.lua',
        },
      },
    })
  end
}

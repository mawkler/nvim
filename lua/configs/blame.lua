-----------
-- Blame --
-----------
return {
  'FabijanZulj/blame.nvim',
  cmd = 'BlameToggle',
  keys = {
    { 'gB', '<cmd>BlameToggle<CR>', desc = 'Git blame file' },
  },
  opts = {
    mappings = {
      commit_info = '<space>',
    },
  }
}

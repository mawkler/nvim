------------
-- Beacon --
------------
return {
  'DanilaMihailov/beacon.nvim',
  cond = function() return not vim.g.neovide end,
  event = 'VeryLazy',
}

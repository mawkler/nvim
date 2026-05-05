----------------------
-- Refactoring.nvim --
----------------------

-- Disabled because async dependency clashes with nvim-ufo's async library
return {
  'ThePrimeagen/refactoring.nvim',
  keys = {
    { '<leader>R', mode = 'x' },
    { 'gRe',       mode = 'x' },
    { 'gRf',       mode = 'x' },
  },
  dependencies = 'lewis6991/async.nvim',
  lazy = false,
  config = function()
    vim.keymap.set('x', '<leader>R', '<cmd>Refactor<CR>', { desc = 'Select refactor' })
  end
}

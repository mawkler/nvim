----------------------
-- Refactoring.nvim --
----------------------
return { 'ThePrimeagen/refactoring.nvim',
  keys = {
    {'x', '<leader>R'},
    {'x', 'gRe'},
    {'x', 'gRf'},
  },
  config = function()
    local map, feedkeys = require('utils').map, require('utils').feedkeys

    local refactoring = require('refactoring')
    refactoring.setup {}

    map('x', 'gRe', function() return refactoring.refactor('Extract Function') end)
    map('x', 'gRf', function() return refactoring.refactor('Extract Function To File') end)
    map('x', '<leader>R', function()
      feedkeys('<Esc>', 'n')
      require('telescope').extensions.refactoring.refactors()
    end, 'Select refactor')

    require('telescope').load_extension('refactoring')
  end
}

local map = require('utils').map

-- Install lazy if it's missing
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
  vim.notify('Installing lazy.nvim...')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

map('n', '<leader>zz', '<cmd>Lazy<CR>',         'Open lazy UI')
map('n', '<leader>zi', '<cmd>Lazy install<CR>', 'Lazy install')
map('n', '<leader>zu', '<cmd>Lazy update<CR>',  'Lazy update')
map('n', '<leader>zc', '<cmd>Lazy clean<CR>',   'Lazy clean')
map('n', '<leader>zp', '<cmd>Lazy profile<CR>', 'Lazy profile')
map('n', '<leader>zs', '<cmd>Lazy sync<CR>',    'Lazy sync')

local map = require('utils').map

-- Install lazy.nvim if it's missing
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

map('n', '<leader>Zz', '<cmd>Lazy<CR>',         'Open lazy UI')
map('n', '<leader>Zi', '<cmd>Lazy install<CR>', 'Lazy install')
map('n', '<leader>Zu', '<cmd>Lazy update<CR>',  'Lazy update')
map('n', '<leader>Zc', '<cmd>Lazy clean<CR>',   'Lazy clean')
map('n', '<leader>Zp', '<cmd>Lazy profile<CR>', 'Lazy profile')
map('n', '<leader>Zs', '<cmd>Lazy sync<CR>',    'Lazy sync')

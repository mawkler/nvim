-- Undo tree --
vim.cmd.packadd('nvim.undotree')

vim.keymap.set('n', '<leader>u', '<cmd>Undotree<CR>', { desc = 'Undo tree' })

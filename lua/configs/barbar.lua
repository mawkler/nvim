------------
-- Barbar --
------------
local map = require('utils').map

vim.g.bufferline = {
  closable = false,
  no_name_title = '[No Name]',
  insert_at_end = true,
  exclude_name = { '[dap-repl]' },
  exclude_ft = { 'qf' },
  maximum_length = 60,
  hide = {
    extensions = true,
  },
}

return { 'romgrk/barbar.nvim',
  event = 'BufAdd',
  init = function()
    -- Fallback if Barbar hasn't been loaded yet
    map('n', '<leader><M-w>', '<cmd>bdelete!<CR>')
  end,
  config = function()
    map('n', '<M-w>',           '<cmd>BufferClose<CR>')
    map('n', '<M-W>',           '<cmd>BufferClose<CR><cmd>wincmd c<CR>')
    map('n', '<leader>bC',      '<cmd>BufferClose<CR><cmd>wincmd c<CR>')
    map('n', '<leader><M-w>',   '<cmd>BufferClose!<CR>')
    -- Buffer-picking mode
    map('n', '<C-Space>',       '<cmd>BufferPick<CR>')
    map('n', '<leader>bd',      '<cmd>BufferPickDelete<CR>')
    -- Sort automatically by...
    map('n', '<leader>bD',      '<cmd>BufferOrderByDirectory<CR>')
    map('n', '<leader>bl',      '<cmd>BufferOrderByLanguage<CR>')
    map('n', '<leader>bc',      '<cmd>BufferClose<CR>')
    map('n', '<leader>bo',      '<cmd>BufferCloseAllButVisible<CR>')
    -- Move to previous/next
    map('n', '<C-Tab>',         '<cmd>BufferNext<CR>')
    map('n', '<C-S-Tab>',       '<cmd>BufferPrevious<CR>')
    map('n', '<M-l>',           '<cmd>BufferNext<CR>')
    map('n', '<M-h>',           '<cmd>BufferPrevious<CR>')
    map('n', '<leader><Tab>',   '<cmd>BufferNext<CR>')
    map('n', '<leader><S-Tab>', '<cmd>BufferPrevious<CR>')
    -- Re-order to previous/next
    map('n', '<M-.>',           '<cmd>BufferMoveNext<CR>')
    map('n', '<M-,>',           '<cmd>BufferMovePrevious<CR>')
    -- Goto buffer in position...
    map('n', '<M-1>',           '<cmd>BufferGoto 1<CR>')
    map('n', '<M-2>',           '<cmd>BufferGoto 2<CR>')
    map('n', '<M-3>',           '<cmd>BufferGoto 3<CR>')
    map('n', '<M-4>',           '<cmd>BufferGoto 4<CR>')
    map('n', '<M-5>',           '<cmd>BufferGoto 5<CR>')
    map('n', '<M-6>',           '<cmd>BufferGoto 6<CR>')
    map('n', '<M-7>',           '<cmd>BufferGoto 7<CR>')
    map('n', '<M-8>',           '<cmd>BufferGoto 8<CR>')
    map('n', '<M-9>',           '<cmd>BufferLast<CR>')
    map('n', '<leader>1',       '<cmd>BufferGoto 1<CR>')
    map('n', '<leader>2',       '<cmd>BufferGoto 2<CR>')
    map('n', '<leader>3',       '<cmd>BufferGoto 3<CR>')
    map('n', '<leader>4',       '<cmd>BufferGoto 4<CR>')
    map('n', '<leader>5',       '<cmd>BufferGoto 5<CR>')
    map('n', '<leader>6',       '<cmd>BufferGoto 6<CR>')
    map('n', '<leader>7',       '<cmd>BufferGoto 7<CR>')
    map('n', '<leader>8',       '<cmd>BufferGoto 8<CR>')
    map('n', '<leader>9',       '<cmd>BufferLast<CR>')
  end
}

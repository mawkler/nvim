------------
-- Barbar --
------------
return { 'romgrk/barbar.nvim',
  config = function()
    local map = require('utils').map

    vim.g.bufferline = {
      closable = false,
      no_name_title = '[No Name]',
      insert_at_end = true,
      exclude_name = {'[dap-repl]'},
      exclude_ft = {'qf'},
    }

    map('n', '<M-w>',           '<cmd>BufferClose<CR>')
    map('n', '<leader>bC',      '<cmd>BufferClose<CR>:wincmd c<CR>')
    map('n', '<C-Space>',       '<cmd>BufferClose!<CR>')
    -- Magic buffer-picking mode
    map('n', '<C-Space>',       '<cmd>BufferPick<CR>')
    -- Sort automatically by...
    map('n', '<Leader>bd',      '<cmd>BufferOrderByDirectory<CR>')
    map('n', '<Leader>bl',      '<cmd>BufferOrderByLanguage<CR>')
    map('n', '<Leader>bc',      '<cmd>BufferClose<CR>')
    map('n', '<Leader>bo',      '<cmd>BufferCloseAllButCurrent<CR>')
    -- Move to previous/next
    map('n', '<C-Tab>',         '<cmd>BufferNext<CR>')
    map('n', '<C-S-Tab>',       '<cmd>BufferPrevious<CR>')
    map('n', '<M-l>',           '<cmd>BufferNext<CR>')
    map('n', '<M-h>',           '<cmd>BufferPrevious<CR>')
    map('n', '<Leader><Tab>',   '<cmd>BufferNext<CR>')
    map('n', '<Leader><S-Tab>', '<cmd>BufferPrevious<CR>')
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
    map('n', '<Leader>1',       '<cmd>BufferGoto 1<CR>')
    map('n', '<Leader>2',       '<cmd>BufferGoto 2<CR>')
    map('n', '<Leader>3',       '<cmd>BufferGoto 3<CR>')
    map('n', '<Leader>4',       '<cmd>BufferGoto 4<CR>')
    map('n', '<Leader>5',       '<cmd>BufferGoto 5<CR>')
    map('n', '<Leader>6',       '<cmd>BufferGoto 6<CR>')
    map('n', '<Leader>7',       '<cmd>BufferGoto 7<CR>')
    map('n', '<Leader>8',       '<cmd>BufferGoto 8<CR>')
    map('n', '<Leader>9',       '<cmd>BufferLast<CR>')
  end
}

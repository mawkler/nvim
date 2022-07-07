--------------
-- Quickfix --
--------------
return { 'ten3roberts/qf.nvim', -- Quickfix utilities
  config = function()
    local qf = require('qf')
    local map = require('utils').map
    require('../quickfix') -- Better quickfix UI

    qf.setup {
      pretty = false
    }

    -- Sets `bufhidden = delete` if buffer was jumped to
    local function list_jump(command, list)
      if vim.b.buffer_jumped_to then
        vim.bo.bufhidden = 'delete'
      end

      local successful, _ = pcall(command, list)
      if successful then
        vim.b.buffer_jumped_to = true
      end
    end

    map('n', ']q', function() list_jump(qf.below, 'c') end, 'Next quickfix item')
    map('n', '[q', function() list_jump(qf.above, 'c') end, 'Previous quickfix item')
    map('n', ']l', function() list_jump(qf.below, 'l') end, 'Next location list item')
    map('n', '[l', function() list_jump(qf.above, 'l') end, 'Previous location list item')

    map('n', '<leader>Q', function() qf.toggle('c', true) end, 'Toggle quickfix')
    map('n', '<leader>L', function() qf.toggle('l', true) end, 'Toggle location list')

    vim.api.nvim_create_augroup('Quickfix', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'qf',
      callback = function()
        map('n', '<C-j>', function() qf.below('visible') end, { buffer = true })
        map('n', '<C-k>', function() qf.above('visible') end, { buffer = true })

        map('n',        '<Space>', '<CR><C-w>p', { buffer = true })
        map({'n', 'x'}, '<CR>',    '<CR>', { buffer = true })
      end,
      group = 'Quickfix'
    })
  end
}

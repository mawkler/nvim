--------------
-- Quickfix --
--------------

-- Sets `bufhidden = delete` if buffer was jumped to
local function list_jump(command, list)
  return function ()
    local qf = require('qf')
    if vim.b.buffer_jumped_to then
      vim.bo.bufhidden = 'delete'
    end

    ---@diagnostic disable-next-line: param-type-mismatch
    local successful, _ = pcall(qf[command], list, false)
    if successful then
      vim.b.buffer_jumped_to = true
    end
  end
end

local function toggle(list)
  return function()
    require('qf').toggle(list, false)
  end
end

return { 'ten3roberts/qf.nvim',
  event = 'QuickFixCmdPre',
  keys = {
    { ']q',        list_jump('below', 'c'), mode = 'n', desc = 'Next quickfix item' },
    { '[q',        list_jump('above', 'c'), mode = 'n', desc = 'Previous quickfix item' },
    { ']l',        list_jump('below', 'l'), mode = 'n', desc = 'Next location list item' },
    { '[l',        list_jump('above', 'l'), mode = 'n', desc = 'Previous location list item' },
    { ']Q',        '<cmd>cnext<CR>',        mode = 'n', desc = 'Next quickfix item' },
    { '[Q',        '<cmd>cprev<CR>',        mode = 'n', desc = 'Previous quickfix item' },
    { '<leader>Q', toggle('c'),             mode = 'n', desc = 'Toggle quickfix' },
    { '<leader>L', toggle('l'),             mode = 'n', desc = 'Toggle location list' },
  },
  config = function()
    local qf = require('qf')
    local map, feedkeys = require('utils').map, require('utils').feedkeys

    require('quickfix') -- Better quickfix UI

    qf.setup({
      pretty = false,
      l = {
        wide = true,
        min_height = 3,
      },
      c = {
        wide = true,
        min_height = 3,
      },
    })

    local function quickfix_step(direction)
      return function()
        qf[direction]('visible')
        feedkeys('<CR><C-w>p')
      end
    end

    vim.api.nvim_create_augroup('Quickfix', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'qf',
      callback = function()
        map('n', '<C-j>', quickfix_step('below'), { buffer = true })
        map('n', '<C-k>', quickfix_step('above'), { buffer = true })

        map('n',        '<Space>', '<CR><C-w>p', { buffer = true })
        map({'n', 'x'}, '<CR>',    '<CR>',       { buffer = true })
      end,
      group = 'Quickfix'
    })
  end

}

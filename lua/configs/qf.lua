--------------
-- Quickfix --
--------------

---@diagnostic disable: missing-fields

local function toggle(list)
  return function()
    require('qf').toggle(list, false)
  end
end

return {
  'ten3roberts/qf.nvim',
  event = 'QuickFixCmdPre',
  ft = 'qf',
  keys = {
    { '<leader>Q', toggle('c'), mode = 'n', desc = 'Toggle quickfix' },
    { '<leader>L', toggle('l'), mode = 'n', desc = 'Toggle location list' },
  },
  config = function()
    local qf = require('qf')
    local map, feedkeys = require('utils').map, require('utils').feedkeys

    require('quickfix') -- Better quickfix UI

    qf.setup({
      pretty = false,
      silent = true,
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

        map('n',          '<Space>', '<CR><C-w>p', { buffer = true, nowait = true })
        map({ 'n', 'x' }, '<CR>',    '<CR>',       { buffer = true })
      end,
      group = 'Quickfix'
    })
  end

}

---------------
-- Autocmds --
---------------
local utils = require('../utils')
local autocmd, map = utils.autocmd, utils.map
local o, opt, bo, wo = vim.o, vim.opt, vim.bo, vim.wo
local fn, api = vim.fn, vim.api

-- Highlight text object on yank
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 350 })
  end,
})

-- TypeScript specific --
autocmd('FileType', {
  pattern = 'typescript',
  callback = function()
    opt.matchpairs:append('<:>')
  end,
})

-- Disabled until TSLspOrganize and/or TSLspImportAll doesn't collide with
--     ['*.ts,*.tsx'] = function()
--       if b.format_on_write ~= false then
--         vim.cmd 'TSLspOrganize'
--         vim.cmd 'TSLspImportAll'
--       end
--     end
--   }
-- }

-- Check if any file has changed when Neovim is focused
autocmd('FocusGained', { command = 'checktime' })

-- Custom filetypes
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.dconf',
  callback = function() o.syntax = 'sh' end,
})

-- Open :help in vertical split instead of horizontal
autocmd('FileType', {
  pattern = 'help',
  callback = function()
    bo.bufhidden = 'unload'
    vim.cmd 'wincmd L'
    vim.cmd 'vertical resize 81'
  end,
})

-- Don't conceal current line in some file formats
autocmd('FileType', {
  pattern = { 'markdown', 'latex', 'tex', 'json', 'http' },
  callback = function() wo.concealcursor = '' end,
})

-- Adds horizontal line below and enters insert mode below it
autocmd('FileType', {
  pattern = 'markdown',
  callback = function() map('n', '<leader>-', 'o<Esc>0Do<Esc>0C---<CR><CR>') end,
})

-- Filetype specific indent settings
autocmd('FileType', {
  pattern = { 'css', 'python', 'cs' },
  callback = function() bo.shiftwidth = 4 end,
})

-- Start git commits at start of line, and insert mode if message is empty
autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    wo.spell = true
    api.nvim_win_set_cursor(0, {1, 0})
    if fn.getline(1) == '' then
      vim.cmd 'startinsert!'
    end
  end,
})

-- `K` in Lua files opens Vim helpdocs
autocmd('FileType', {
  pattern = 'lua',
  callback = function() bo.keywordprg = ':help' end,
})

-- `F` surround object in Lua files
autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.cmd [[ let b:surround_{char2nr('F')} = "function() return \r end" ]]
  end,
})

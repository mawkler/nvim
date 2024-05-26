local map, feedkeys = require('utils').map, require('utils').feedkeys

local append_chars = { '.', ',', ';', '!', '?' }

local function visual_append(char)
  return function()
    vim.cmd('normal! m0')
    feedkeys(':normal! A' .. char .. '<CR>:<Esc>')
    vim.cmd('normal! `0')

    vim.o.operatorfunc = 'v:lua.visual_append'
  end
end

local function visual_append_map(char)
  local desc = 'Visual append ' .. char
  map({'n', 'x'}, '<leader>' .. char, visual_append(char), desc)
end

for _, char in pairs(append_chars) do
  visual_append_map(char)
end

map('n', '<leader>\\', visual_append(' \\'))

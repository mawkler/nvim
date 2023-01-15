local map, feedkeys = require('utils').map, require('utils').feedkeys

local append_chars = { '.', ',', ';', '!', '?' }

local function visual_append(char)
  vim.cmd('normal! m0')
  feedkeys(':normal! A' .. char .. '<CR>:<Esc>')
  vim.cmd('normal! `0')

  vim.o.operatorfunc = 'v:lua.visual_append'
end

local function visual_append_map(char)
  local desc = 'Visual append ' .. char
  map({'n', 'x'}, '<leader>' .. char, function() visual_append(char) end, desc)
end

for _, char in pairs(append_chars) do
  visual_append_map(char)
end

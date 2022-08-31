local search = vim.fn.search
local map, feedkeys = require('utils').map, require('utils').feedkeys

local function set_normal_mode()
  if vim.fn.mode() == 'v' then
    feedkeys('<Esc>', 'inx!')
  end
end

-- Like `aw`, but always includes leading whitespace instead of trailing
local function age()
  set_normal_mode()
  search('\\w\\>', 'cW')
  feedkeys('v', 'inx!')
  search('\\>', 'bW')
end

-- Like `aW`, but always includes leading whitespace instead of trailing
local function agE()
  set_normal_mode()
  search('\\w\\s', 'cW')
  feedkeys('v', 'inx!')
  search('\\>\\s', 'bW')
end

map({'x', 'o'}, 'age', age)
map({'x', 'o'}, 'agE', agE)

local M = {}

M.keymaps = {
  f = '@function',
  c = '@call',
  C = '@class',
  a = '@parameter',
  o = '@loop',
  R = '@return',
  m = '@method',
  N = '@number',
  X = '@regex',
  ['@'] = '@block',
  ['2'] = '@block',
  [';'] = '@comment',
  ['?'] = '@conditional',
  ['s'] = '@statement',
  ['='] = '@assignment',
}

M.special_keymaps = {
  -- Keymaps that shouldn't be prefixed with i/a
  ['ik'] = '@assignment.lhs',
  ['iv'] = '@assignment.rhs',
  ['i;'] = '@comment.outer',   -- @comment.inner isn't implemented yet
  ['is'] = '@statement.outer', -- @statement.inner isn't implemented
}

function M.get_all()
  return vim.tbl_extend('force', M.keymaps, M.special_keymaps)
end

---@param key string
---@param query string
---@param map 'next_start' | 'next_end' | 'previous_start' | 'previous_end'
local function set_textobject_motion_mapping(key, query, map)
  local ts_move = require('nvim-treesitter-textobjects.move')
  vim.keymap.set({ 'n', 'x', 'o' }, key, function()
    ts_move['goto_' .. map](query .. '.outer', 'textobjects')
  end)
end

---@param key string
---@param query string
function M.set_textobject_select_mapping(key, query)
  local ts_select = require('nvim-treesitter-textobjects.select')
  vim.keymap.set({ 'x', 'o' }, key, function()
    ts_select.select_textobject(query, 'textobjects')
  end)
end

---@param key string
---@param query string
---@param direction 'next' | 'previous'
local function set_textobject_swap_mapping(key, query, direction)
  vim.keymap.set('n', key, function()
    require('nvim-treesitter-textobjects.swap')['swap_' .. direction](query)
  end)
end

---@param textobject string
---@param query string
function M.create_keymaps(textobject, query)
  local maps = {
    [']' .. textobject] = 'next_start',
    ['[' .. textobject] = 'previous_start',
    [']' .. textobject:upper()] = 'next_end',
    ['[' .. textobject:upper()] = 'previous_end',
  }

  for key, direction in pairs({ ['>'] = 'next', ['<'] = 'previous' }) do
    set_textobject_swap_mapping(key .. 'a' .. textobject, query .. '.outer', direction)
  end

  for key, preposition in pairs({ a = 'outer', i = 'inner' }) do
    local select_key = key .. textobject
    local select_query = query .. '.' .. preposition
    M.set_textobject_select_mapping(select_key, select_query)
  end

  for key, map in pairs(maps) do
    set_textobject_motion_mapping(key, query, map)
  end
end

return M

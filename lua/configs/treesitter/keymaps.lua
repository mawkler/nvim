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
  ['S'] = '@statement',
  ['='] = '@assignment',
}

M.special_keymaps = {
  -- Keymaps that shouldn't be prefixed with i/a
  ['ik'] = '@assignment.lhs',
  ['iv'] = '@assignment.rhs',
  ['i;'] = '@comment.outer',   -- @comment.inner isn't implemented yet
  ['iS'] = '@statement.outer', -- @statement.inner isn't implemented yet
}

local function merge(t1, t2)
  return vim.tbl_extend('force', t1, t2)
end

M.get = function()
  return merge(M.keymaps, M.special_keymaps or {})
end

M.get_with_prepositions = function()
  local maps = {}

  for key, capture in pairs(M.keymaps) do
    maps['a' .. key] = capture .. '.outer'
    maps['i' .. key] = capture .. '.inner'
  end

  return merge(maps, M.special_keymaps or {})
end

--- @param direction ']' | '['
--- @param overrides {}
M.get_motion_keymaps = function(direction, overrides)
  local maps = {}

  for key, capture in pairs(M.keymaps) do
    maps[direction .. key] = capture .. '.outer'
  end

  return merge(maps, overrides or {})
end

--- @param direction '>' | '<'
--- @param overrides {}
M.get_textobj_swap_keymaps = function(direction, overrides)
  local maps = {}

  for key, capture in pairs(M.get_with_prepositions()) do
    maps[direction .. key] = capture
  end

  return merge(maps, overrides or {})
end

-- TODO: rename file to keymaps.lua
return M

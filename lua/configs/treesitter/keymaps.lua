local M = {}

M.capture_keymaps = {
  f = '@function',
  c = '@call',
  C = '@class',
  t = '@class', -- `t` for "type"
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

local function merge(t1, t2)
  return vim.tbl_extend('force', t1, t2)
end

--- @param overrides {}
M.get_textobj_keymaps = function(overrides)
  local keymaps = {}

  for key, capture in pairs(M.capture_keymaps) do
    keymaps['a' .. key] = capture .. '.outer'
    keymaps['i' .. key] = capture .. '.inner'
  end

  return merge(keymaps, overrides or {})
end

--- @param direction ']' | '['
--- @param overrides {}
M.get_motion_keymaps = function(direction, overrides)
  local keymaps = {}

  for key, capture in pairs(M.capture_keymaps) do
    keymaps[direction .. key] = capture .. '.outer'
  end

  return merge(keymaps, overrides or {})
end

--- @param direction '>' | '<'
--- @param overrides {}
M.get_textobj_swap_keymaps = function(direction, overrides)
  local keymaps = {}

  for key, capture in pairs(M.get_textobj_keymaps()) do
    keymaps[direction .. key] = capture
  end

  return merge(keymaps, overrides or {})
end

-- TODO: rename file to keymaps.lua
return M

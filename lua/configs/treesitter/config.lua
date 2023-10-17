local config = {}

config.query_keymaps = {
  f = '@function',
  C = '@class',
  c = '@call',
  a = '@parameter',
  o = '@loop',
  R = '@return',
  m = '@method',
  N = '@number',
  x = '@regex',
  [';'] = '@block',
  ['#'] = '@comment',
  ['?'] = '@conditional',
  ['!'] = '@statement',
  ['='] = '@assignment',
}

config.get_keymaps = function()
  local keymaps = {}

  for map, query in pairs(config.query_keymaps) do
    keymaps['a' .. map] = query .. 'outer'
    keymaps['i' .. map] = query .. 'inner'
  end

  return keymaps
end

return config

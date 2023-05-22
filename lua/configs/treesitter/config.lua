local config = {}

config.query_keymaps = {
  F = '@function',
  C = '@class',
  f = '@call',
  a = '@parameter',
  c = '@comment',
  i = '@conditional',
  o = '@loop',
  k = '@block',
  R = '@return',
  m = '@method'
}

config.get_keymaps = function()
  local query_keymaps = require('configs.treesitter.config').query_keymaps
  local keymaps = {}

  for map, query in pairs(query_keymaps) do
    keymaps['a' .. map] = query
    keymaps['i' .. map] = query
  end

  return keymaps
end

return config

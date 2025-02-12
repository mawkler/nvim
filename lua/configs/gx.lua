-------------
-- gx.nvim --
-------------
return {
  'chrishrb/gx.nvim',
  keys = {
    { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' }, desc = 'Open link in web browser' },
  },
  dependencies = 'nvim-lua/plenary.nvim',
  ---@type GxOptions | Any
  opts = {
    handlers = { search = false },
    handler_options = { search_engine = 'duckduckgo' },
  },
}

-------------
-- gx.nvim --
-------------
return {
  'chrishrb/gx.nvim',
  keys = {
    { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' }, desc = 'Open link in web browser' },
  },
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    handlers = { search = false },
    handler_options = { search_engine = 'duckduckgo' },
  },
}

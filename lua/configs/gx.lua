-------------
-- gx.nvim --
-------------
return {
  'chrishrb/gx.nvim',
  keys = 'gx',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    handlers = { search = false, },
    handler_options = { search_engine = 'duckduckgo' },
  },
}

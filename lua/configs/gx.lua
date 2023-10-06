-------------
-- gx.nvim --
-------------
return {
  'chrishrb/gx.nvim',
  event = { 'BufEnter' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    handlers = { search = false, },
    handler_options = { search_engine = 'duckduckgo' },
  },
}

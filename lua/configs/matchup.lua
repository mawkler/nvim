-------------
-- Matchup --
-------------
return {
  'andymass/vim-matchup',
  dependencies = 'tpope/vim-repeat',
  event = 'CursorMoved',
  init = function()
    vim.g.matchup_matchparen_offscreen = {} -- Dont' display off-screen matches
    vim.g.matchup_delim_nomids = 1          -- Don't include words like `return`
  end
}

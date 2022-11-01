-------------
-- Matchup --
-------------
return { 'andymass/vim-matchup',
  -- `keys` seems to be clashing with some other plugin because it works if I
  -- only have vim-matchup
  -- keys = {{'n', '%'}, {'x', '%'}, {'o', '%'}},
  event = 'CursorMoved',
  setup = function()
    vim.g.matchup_matchparen_offscreen = {} -- Dont' display off-screen matches
    vim.g.matchup_delim_nomids = 1          -- Don't include words like `return`
  end
}

-------------
-- Matchup --
-------------
return {
  'andymass/vim-matchup',
  init = function()
    vim.g.matchup_matchparen_offscreen = {} -- Dont' display off-screen matches
    vim.g.matchup_delim_nomids = 1          -- Don't include words like `return`
    vim.g.matchup_treesitter_disable_virtual_text = true
    vim.g.matchup_treesitter_include_match_words = true
  end
}

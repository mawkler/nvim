-------------
-- Refjump --
-------------
return {
  'mawkler/refjump.nvim',
  event = 'LspAttach',
  ---@type RefjumpOptions
  opts = {
    verbose = false,
  }
}

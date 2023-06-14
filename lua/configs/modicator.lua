---------------
-- Modicator --
---------------
return {
  'mawkler/modicator.nvim',
  event = 'ModeChanged',
  opts = {
    show_warnings = false,
    highlights = {
      defaults = { bold = true },
    },
  }
}

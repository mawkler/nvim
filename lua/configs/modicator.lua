---------------
-- Modicator --
---------------
return {
  'mawkler/modicator.nvim',
  event = 'ModeChanged',
  ---@type ModicatorOptions
  opts = {
    highlights = {
      defaults = { bold = true },
    },
  }
}

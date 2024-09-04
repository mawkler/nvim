------------
-- Fidget --
------------
return {
  'j-hui/fidget.nvim',
  event = 'LspAttach',
  opts = {
    progress = {
      display = {
        done_icon = ' ',
        done_ttl = 2,
      }
    },
    notification = {
      window = {
        max_height = 4,
        normal_hl = 'FidgetNormal',
      }
    },
  }
}

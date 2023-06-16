------------
-- Fidget --
------------
return {
  'j-hui/fidget.nvim',
  event = 'LspAttach',
  tag = 'legacy', -- TODO: remove once fidget has been rewritten
  config = function()
    require('fidget').setup {
      text = { spinner = 'dots', done = '' },
      window = {
        relative = 'editor',
      },
    }
  end
}

------------
-- Fidget --
------------
return {
  'j-hui/fidget.nvim',
  event = 'LspAttach',
  config = function()
    require('fidget').setup {
      text = { spinner = 'dots', done = '' },
      window = {
        relative = 'editor',
      },
    }
  end
}

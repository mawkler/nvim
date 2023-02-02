------------
-- Dap UI --
------------
local ui = require('dapui')
local dap, widgets = require('dap'), require('dap.ui.widgets')

return { 'rcarriga/nvim-dap-ui',
  keys = {
    {
      '<leader>dd', function()
        dap.continue()
        ui.open()
      end, mode = 'n', desc = 'Toggle DAP UI'
    },
    { '<leader>de', ui.eval,       mode = {'n', 'x'}, desc = 'DAP evaluate expression' },
    { '<leader>dt', ui.toggle,     mode = 'n',        desc = 'DAP toggle UI' },
    { '<leader>dh', widgets.hover, mode = 'n',        desc = 'DAP hover' },
  },
  config = function()
    ui.setup()

  end
}

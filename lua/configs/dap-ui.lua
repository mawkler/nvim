------------
-- Dap UI --
------------
local function eval() require('dapui').eval() end
local function toggle() require('dapui').toggle() end
local function hover() require('dap.ui.widgets').hover() end

return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  keys = {
    { '<leader>dt', toggle, desc = 'DAP toggle UI' },
    { '<leader>dh', hover,  desc = 'DAP hover' },
    { '<leader>de', eval,   desc = 'DAP evaluate expression', mode = { 'n', 'x' } },
  },
  config = true
}

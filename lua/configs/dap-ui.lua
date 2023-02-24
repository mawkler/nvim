------------
-- Dap UI --
------------
local function eval() return require('dapui').eval() end
local function toggle() return require('dapui').toggle() end
local function hover() return require('dap.ui.widgets').hover() end

return {
  'rcarriga/nvim-dap-ui',
  keys = {
    { '<leader>dt', toggle,                    desc = 'DAP toggle UI' },
    { '<leader>dh', hover,                     desc = 'DAP hover' },
    { '<leader>de', eval,   mode = {'n', 'x'}, desc = 'DAP evaluate expression' },
  },
  config = true
}

local cmd, call, fn = vim.cmd, vim.call, vim.fn
local api = vim.api

local di = require('dap-install')
di.setup { verbosely_call_debuggers = true }
di.config('chrome', {})
di.config('jsnode')
di.config('python')
di.config('lua')

require('dap.ext.vscode').load_launchjs()

local function map(modes, lhs, rhs, opts)
  if (type(modes) ~= 'table') then modes = {modes} end

  for _, mode in pairs(modes) do
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_set_keymap(mode, lhs, rhs, options)
  end
end

-- Mappings --
map('n', '<F5>', ':lua require("dap").continue() require("dapui").open()<CR>', {silent = true})
map('n', '<F10>', ':lua require"dap".step_over()<CR>', {silent = true})
map('n', '<F11>', ':lua require"dap".step_into()<CR>', {silent = true})
map('n', '<F12>', ':lua require"dap".step_out()<CR>', {silent = true})
map('n', '<F12>', ':lua require"dap".step_out()<CR>', {silent = true})
map('n', '<F9>',  ':lua require"dap".toggle_breakpoint()<CR>', {silent = true})
map('n', '<leader><F9>',  ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', {silent = true})
-- nnoremap <silent> <leader>dr :lua require"dap".repl.open()<CR>
-- nnoremap <silent> <leader>dl :lua require"dap".run_last()<CR>

-- dap-ui --
require('dapui').setup()

map('n', '<leader>De',  ':lua require("dapui").eval()<CR>', {silent = true})



-- local dap = require"dap"
-- dap.configurations.lua = {
--   {
--     type = 'nlua',
--     request = 'attach',
--     name = "Attach to running Neovim instance",
--     host = function()
--       local value = vim.fn.input('Host [127.0.0.1]: ')
--       if value ~= "" then
--         return value
--       end
--       return '127.0.0.1'
--     end,
--     port = function()
--       local val = tonumber(vim.fn.input('Port: '))
--       assert(val, "Please provide a port number")
--       return val
--     end,
--   }
-- }

-- dap.adapters.nlua = function(callback, config)
--   callback({ type = 'server', host = config.host, port = config.port })
-- end

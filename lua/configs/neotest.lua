-------------
-- Neotest --
-------------

---@diagnostic disable: missing-fields

local function neotest()
  return require('neotest')
end

local function run_file() neotest().run.run(vim.fn.expand('%')) end
local function debug_file() neotest().run.run({ vim.fn.expand('%'), strategy = 'dap' }) end
local function open() neotest().output.open({ enter = true }) end
local function watch_file() neotest().watch.toggle(vim.fn.expand('%')) end

local function neotest_jump(direction, status)
  return function()
    require('neotest').jump[direction]({ status = status })
  end
end

local nxo = { 'n', 'x', 'o' }

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-neotest/nvim-nio',
    'nvim-treesitter/nvim-treesitter',
    'haydenmeade/neotest-jest',
    'rouge8/neotest-rust',
    'nvim-neotest/neotest-go',
  },
  keys = {
    { '<leader>Tr', function() neotest().run.run() end,             desc = 'Run test' },
    { '<leader>Tc', function() neotest().run.stop() end,            desc = 'Cancel running test' },
    { '<leader>Td', function() debug_file() end,                    desc = 'Cancel running test' },
    { '<leader>TR', function() run_file() end,                      desc = 'Run tests in file' },
    { '<leader>To', function() open() end,                          desc = 'Open test output' },
    { '<leader>Tw', function() neotest().watch.toggle() end,        desc = 'Watch tests' },
    { '<leader>TW', function() watch_file() end,                    desc = 'Watch tests in file' },
    { '<leader>TO', function() neotest().output_panel.toggle() end, desc = 'Open test output panel' },
    { '<leader>Tm', function() neotest().summary.marked() end,      desc = 'Run marked tests' },
    { '<leader>TT', function() neotest().summary.toggle() end,      desc = 'Toggle tests summary' },
    { ']t',         neotest_jump('next'),                           desc = 'Next test',             mode = nxo },
    { '[t',         neotest_jump('prev'),                           desc = 'Previous test',         mode = nxo },
    { ']T',         neotest_jump('next', 'failed'),                 desc = 'Next failed test',      mode = nxo },
    { '[T',         neotest_jump('prev', 'failed'),                 desc = 'Previous failed test',  mode = nxo },
  },
  cmd = { 'Neotest' },
  config = function()
    local neotest_jest = require('neotest-jest')

    neotest().setup({
      diagnostic = {
        severity = vim.diagnostic.severity.INFO
      },
      icons = {
        unknown = '',
        passed = '',
        failed = '',
        running = '',
        skipped = '',
        watching = '',
        running_animated = {
          '⠋', '⠙', '⠹', '⠸', '⠼',
          '⠴', '⠦', '⠧', '⠇', '⠏',
        },
      },
      summary = {
        mappings = {
          next_failed = ']',
          prev_failed = '[',
        },
      },
      quickfix = {
        open = false
      },
      adapters = {
        neotest_jest({
          jestCommand = 'npm test --',
        }),
        require('neotest-rust'),
        require('neotest-go'),
      },
    })
  end
}

-------------
-- Neotest --
-------------

local function neotest()
  return require('neotest')
end

local function run_file() neotest().run.run(vim.fn.expand("%")) end
local function open() neotest().output.open({ enter = true }) end
local function watch_file() neotest().watch.toggle(vim.fn.expand("%")) end
local function jump_to_failed(direction, opts)
  return neotest().jump[direction](opts)
end

return {
  'nvim-neotest/neotest',
  dependencies = {
    'haydenmeade/neotest-jest',
    'rouge8/neotest-rust',
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>Tr', function() neotest().run.run() end,             'Run test' },
    { '<leader>Tc', function() neotest().run.stop() end,            'Cancel running test' },
    { '<leader>TR', function() run_file() end,                      'Run tests in file' },
    { '<leader>To', function() open() end,                          'Open test output' },
    { '<leader>Tw', function() neotest().watch.toggle() end,        'Watch tests' },
    { '<leader>TW', function() watch_file() end,                    'Watch tests in file' },
    { '<leader>TO', function() neotest().output_panel.toggle() end, 'Open test output panel' },
    { '<leader>Tm', function() neotest().summary.marked() end,      'Run marked tests' },
    { '<leader>Ts', function() neotest().summary.toggle() end,      'Toggle teset summary' },
    { ']t',         function() neotest().jump.next() end,           'Jump to next test' },
    { '[t',         function() neotest().jump.prev() end,           'Jump to previous test' },
    { ']T',         function() jump_to_failed('next') end,          'Jump to next failed test' },
    { '[T',         function() jump_to_failed('prev') end,          'Jump to next failed test' },
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
        require("neotest-rust"),
      },
    })
  end
}

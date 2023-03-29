-------------
-- Neotest --
-------------
return {
  'nvim-neotest/neotest',
  dependencies = { 'haydenmeade/neotest-jest' },
  keys = {
    '<leader>Tt',
    '<leader>Tc',
    '<leader>TT',
    '<leader>To',
    '<leader>Tm',
    '<leader>Ts',
    ']t',
    '[t',
    ']T',
    '[T',
  },
  config = function()
    local neotest, neotest_jest = require('neotest'), require('neotest-jest')
    local map = require('utils').map

    neotest.setup({
      diagnostic = {
        severity = vim.diagnostic.severity.INFO
      },
      icons = {
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
      },
    })

    local function run_file() neotest.run.run(vim.fn.expand("%")) end
    local function open() neotest.output.open({ enter = true }) end
    local function jump_failed(direction, opts)
      return function() neotest.jump[direction](opts) end
    end

    map('n', '<leader>Tt', neotest.run.run,        'Run test')
    map('n', '<leader>Tc', neotest.run.stop,       'Cancel running test')
    map('n', '<leader>TT', run_file,               'Run tests in file')
    map('n', '<leader>To', open,                   'Open test output')
    map('n', '<leader>Tm', neotest.summary.marked, 'Run marked tests')
    map('n', '<leader>Ts', neotest.summary.toggle, 'Toggle teset summary')
    map('n', ']t',         neotest.jump.next,      'Jump to next test')
    map('n', '[t',         neotest.jump.prev,      'Jump to previous test')
    map('n', ']T',         jump_failed('next'),    'Jump to next failed test')
    map('n', '[T',         jump_failed('prev'),    'Jump to next failed test')
  end
}

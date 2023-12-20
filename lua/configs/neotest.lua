-------------
-- Neotest --
-------------
return {
  'nvim-neotest/neotest',
  dependencies = { 'haydenmeade/neotest-jest', 'rouge8/neotest-rust', 'nvim-lua/plenary.nvim' },
  keys = {
    '<leader>Tr',
    '<leader>Tc',
    '<leader>TR',
    '<leader>To',
    '<leader>Tw',
    '<leader>TO',
    '<leader>Tm',
    '<leader>Ts',
    ']t',
    '[t',
    ']T',
    '[T',
  },
  cmd = { 'Neotest' },
  config = function()
    local neotest, neotest_jest = require('neotest'), require('neotest-jest')
    local map = require('utils').map

    neotest.setup({
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

    local function run_file() neotest.run.run(vim.fn.expand("%")) end
    local function open() neotest.output.open({ enter = true }) end
    local function watch_file() neotest.watch.toggle(vim.fn.expand("%")) end
    local function jump_failed(direction, opts)
      return function() neotest.jump[direction](opts) end
    end

    map('n', '<leader>Tr', neotest.run.run,             'Run test')
    map('n', '<leader>Tc', neotest.run.stop,            'Cancel running test')
    map('n', '<leader>TR', run_file,                    'Run tests in file')
    map('n', '<leader>To', open,                        'Open test output')
    map('n', '<leader>Tw', neotest.watch.toggle,        'Watch tests')
    map('n', '<leader>TW', watch_file,                  'Watch tests in file')
    map('n', '<leader>TO', neotest.output_panel.toggle, 'Open test output panel')
    map('n', '<leader>Tm', neotest.summary.marked,      'Run marked tests')
    map('n', '<leader>Ts', neotest.summary.toggle,      'Toggle teset summary')
    map('n', ']t',         neotest.jump.next,           'Jump to next test')
    map('n', '[t',         neotest.jump.prev,           'Jump to previous test')
    map('n', ']T',         jump_failed('next'),         'Jump to next failed test')
    map('n', '[T',         jump_failed('prev'),         'Jump to next failed test')
  end
}

---------
-- DAP --
---------
return { 'mfussenegger/nvim-dap',
  requires = {
    'rcarriga/nvim-dap-ui',             -- UI for nvim-dap
    'ravenxrz/DAPInstall.nvim',         -- Installing/uninstalling debuggers - temporary branch while dap-buddy is re-written
    'David-Kunz/jester',                -- Debugging Jest tests
    'theHamsta/nvim-dap-virtual-text',  -- Show variable values in virtual text
  },
  -- TODO: fix lazy loading
  -- keys = {
  --   -- '<F10>',
  --   -- '<F11>',
  --   -- '<S-F11>',
  --   -- '<F9>',
  --   -- '<leader>s',
  --   -- '<leader>di',
  --   -- '<leader>do',
  --   -- '<leader>db',
  --   -- '<leader>dB',
  --   -- '<leader>dr',
  --   -- '<leader>dl',
  --   -- '<leader>de',
  --   -- '<leader>dt',
  --   -- '<leader>dj',
  --   -- '<leader>dJ',
  -- },
  -- cmd = { 'DIInstall', 'DIUninstall', 'DIList' },
  -- module_pattern = { 'dap.*', 'jester.*' },
  config = function()
    local sign_define = vim.fn.sign_define
    local dap, widgets = require('dap'), require('dap.ui.widgets')
    local dap_ui, di = require('dapui'), require('dap-install')
    local jester = require('jester')
    local map = require('utils').map
    local plugin_setup = require('utils').plugin_setup

    sign_define('DapBreakpoint',          { text='', texthl='Error' })
    sign_define('DapBreakpointCondition', { text='לּ', texthl='Error' })
    sign_define('DapLogPoint',            { text='', texthl='Directory' })
    sign_define('DapStopped',             { text='ﰲ', texthl='TSConstant' })
    sign_define('DapBreakpointRejected',  { text='', texthl='Error' })

    -- DAPInstall --
    di.config('jsnode')

    -- Mappings --
    -- TODO: use stackmap.nvim to add ]s as "next step", or something similar
    map('n', '<leader>dd', function()
      dap.continue()
      dap_ui.open()
    end)
    map('n', '<leader>dB', function()
      vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(condition)
        dap.set_breakpoint(condition)
      end)
    end, 'DAP set conditional breakpoint')
    map('n', '<leader>dc', dap.continue,          'DAP continue')
    map('n', '<leader>ds', dap.step_over,         'DAP step over')
    map('n', '<leader>di', dap.step_into,         'DAP step into')
    map('n', '<leader>do', dap.step_out,          'DAP step out')
    map('n', '<leader>db', dap.toggle_breakpoint, 'DAP toggle breakpoint')
    map('n', '<leader>dr', dap.repl.open,         'DAP open REPL')
    map('n', '<leader>dl', dap.run_last,          'DAP run last session')
    map('n', '<leader>dr', dap.restart,           'DAP restart session')
    map('n', '<leader>dq', dap.terminate,         'DAP terminate session')
    map('n', '<leader>dh', widgets.hover,         'DAP hover')

    -- DAP-UI
    map({'n', 'x'}, '<leader>de', dap_ui.eval,   'DAP evaluate expression')
    map('n',        '<leader>dt', dap_ui.toggle, 'DAP toggle UI')

    -- Jester
    map('n', '<leader>djt', jester.debug,      'DAP Jester debug test')
    map('n', '<leader>djf', jester.debug_file, 'DAP Jester debug file')
    map('n', '<leader>djr', jester.debug_last, 'DAP Jester rerun debug')
    map('n', '<leader>djT', jester.run,        'DAP Jester run test')
    map('n', '<leader>djF', jester.run_file,   'DAP Jester run file')
    map('n', '<leader>djR', jester.run_last,   'DAP Jester rerun test')

    -- DAP virtual text --
    plugin_setup('nvim-dap-virtual-text')

    -- DAP-UI --
    dap_ui.setup()

    dap.adapters.node2 = {
      type = 'executable',
      command = 'node',
      args = {
        vim.fn.stdpath('data') .. '/dapinstall/jsnode/vscode-node-debug2/out/src/nodeDebug.js',
      },
    }

    dap.configurations.typescript = {
      {
        name = 'ts-node (Node2 with ts-node)',
        type = 'node2',
        request = 'launch',
        cwd = vim.loop.cwd(),
        runtimeArgs = { '-r', 'ts-node/register' },
        runtimeExecutable = 'node',
        args = {'--inspect', '${file}'},
        sourceMaps = true,
        skipFiles = { '<node_internals>/**', 'node_modules/**' },
      },
      {
        name = 'Jest (Node2 with ts-node)',
        type = 'node2',
        request = 'launch',
        cwd = vim.loop.cwd(),
        runtimeArgs = {'--inspect-brk', '${workspaceFolder}/node_modules/.bin/jest'},
        runtimeExecutable = 'node',
        args = {'${file}', '--runInBand', '--coverage', 'false'},
        sourceMaps = true,
        port = 9229,
        skipFiles = { '<node_internals>/**', 'node_modules/**' },
      },
      {
        name = 'op host start',
        type = 'node2',
        request = 'launch',
        cwd = vim.loop.cwd(),
        runtimeArgs = { '-r', 'ts-node/register' },
        args = {'--inspect', '${file}'},
        sourceMaps = true,
        skipFiles = { '<node_internals>/**', 'node_modules/**' },
      }
    }

    -- Loads .vscode/launch.json files if available
    require('dap.ext.vscode').load_launchjs(nil, { node = {'typescript'} })

  end,
}

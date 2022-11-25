---------
-- DAP --
---------
return { 'mfussenegger/nvim-dap',
  requires = {
    'rcarriga/nvim-dap-ui',             -- UI for nvim-dap
    'David-Kunz/jester',                -- Debugging Jest tests
    'theHamsta/nvim-dap-virtual-text',  -- Show variable values in virtual text
    'mxsdev/nvim-dap-vscode-js',        -- DAP adapter for vs**de-js-debug
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
  -- module_pattern = { 'dap.*', 'jester.*' },
  config = function()
    local sign_define = vim.fn.sign_define
    local dap, widgets = require('dap'), require('dap.ui.widgets')
    local dap_ui = require('dapui')
    local jester = require('jester')
    local map = require('utils').map

    local install_location = vim.fn.stdpath('data') .. '/mason/packages'

    sign_define('DapBreakpoint',          { text='', texthl='Error' })
    sign_define('DapBreakpointCondition', { text='לּ', texthl='Error' })
    sign_define('DapLogPoint',            { text='', texthl='Directory' })
    sign_define('DapStopped',             { text='ﰲ', texthl='TSConstant' })
    sign_define('DapBreakpointRejected',  { text='', texthl='Error' })

    -- Mappings --
    -- TODO: use stackmap.nvim to add ]s as "next step", or something similar
    map('n', '<leader>dd', function()
      dap.continue()
      dap_ui.open()
    end, 'Toggle DAP UI')
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
    require('nvim-dap-virtual-text').setup()

    -- DAP-UI --
    dap_ui.setup()

    require('dap-vscode-js').setup({
      debugger_path = install_location .. '/js-debug-adapter',
      debugger_cmd = { 'js-debug-adapter' },
      adapters = {
        'pwa-node',
        'pwa-chrome',
        'pwa-msedge',
        'node-terminal',
        'pwa-extensionHost',
      },
    })

    for _, language in ipairs({ 'typescript', 'javascript' }) do
      require('dap').configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug Jest Tests beep boop',
          runtimeExecutable = 'node',
          runtimeArgs = {
            './node_modules/jest/bin/jest.js',
            '--runInBand',
          },
          rootPath = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require'dap.utils'.pick_process,
          cwd = '${workspaceFolder}',
        }

      }
    end

    -- Loads .vscode/launch.json files if available
    require('dap.ext.vscode').load_launchjs(nil, { node = {'typescript'} })
  end,
}

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
    local dap, dap_ui, di = require('dap'), require('dapui'), require('dap-install')
    local jester = require('jester')
    local map = require('utils').map

    sign_define('DapBreakpoint',          { text='', texthl='Error' })
    sign_define('DapBreakpointCondition', { text='לּ', texthl='Error' })
    sign_define('DapLogPoint',            { text='', texthl='Directory' })
    sign_define('DapStopped',             { text='ﰲ', texthl='TSConstant' })
    sign_define('DapBreakpointRejected',  { text='', texthl='Error' })

    -- DAPInstall --
    di.config('jsnode')

    -- Mappings --
    -- TODO: use stackmap.nvim to add ]s as "next step", or something similar
    map('n', '<F5>', function()
      dap.continue()
      dap_ui.open()
    end)
    map('n', '<leader>dd', function()
      dap.continue()
      dap_ui.open()
    end)
    map('n', '<leader>dc', dap.continue)
    map('n', '<F10>',      dap.step_over)
    map('n', '<leader>ds', dap.step_over)
    map('n', '<F11>',      dap.step_into)
    map('n', '<leader>di', dap.step_into)
    map('n', '<S-F11>',    dap.step_out)
    map('n', '<leader>do', dap.step_out)
    map('n', '<F9>',       dap.toggle_breakpoint)
    map('n', '<leader>db', dap.toggle_breakpoint)
    map('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end)
    map('n', '<leader>dr', dap.repl.open)
    map('n', '<leader>dl', dap.run_last)
    map('n', '<leader>dr', dap.restart)
    map('n', '<leader>dq', dap.terminate)

    -- DAP-UI
    map('n', '<leader>de', dap_ui.eval)
    map('n', '<leader>dt', dap_ui.toggle)

    -- Jester
    map('n', '<leader>dj', jester.debug)
    map('n', '<leader>dJ', jester.debug_file)

    -- DAP virtual text --
    require('nvim-dap-virtual-text').setup()

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

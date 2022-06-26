---------
-- DAP --
---------
return { 'mfussenegger/nvim-dap',
  requires = {
    'rcarriga/nvim-dap-ui',     -- UI for nvim-dap
    'ravenxrz/DAPInstall.nvim', -- Installing/uninstalling debuggers
                                -- temporary branch while dap-buddy is written
    'David-Kunz/jester',        -- Debugging Jest tests
  },
  keys = { '<F5>', '<F10>', '<F11>', '<F12>', '<F12>', '<F9>' },
  cmd = { 'DIInstall', 'DIUninstall', 'DIList' },
  module_pattern = { 'dap.*', 'jester.*' },
  config = function()
    local sign_define = vim.fn.sign_define
    local dap, dap_ui, di = require('dap'), require('dapui'), require('dap-install')
    local map = require('utils').map

    sign_define('DapBreakpoint',          { text='', texthl='Error' })
    sign_define('DapBreakpointCondition', { text='לּ', texthl='Error' })
    sign_define('DapLogPoint',            { text='', texthl='Directory' })
    sign_define('DapStopped',             { text='ﰲ', texthl='TSConstant' })
    sign_define('DapBreakpointRejected',  { text='', texthl='Error' })

    -- DAPInstall --
    di.config('jsnode')

    -- Mappings --
    map('n', '<F5>', function()
      dap.continue()
      dap_ui.open()
    end)
    map('n', '<F10>', dap.step_over)
    map('n', '<F11>', dap.step_into)
    map('n', '<F12>', dap.step_out)
    map('n', '<F12>', dap.step_out)
    map('n', '<F9>',  dap.toggle_breakpoint)
    map('n', '<leader><F9>', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end)
    map('n', '<leader>dr', dap.repl.open)
    map('n', '<leader>dl', dap.run_last)
    map('n', '<leader>de', dap_ui.eval)

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

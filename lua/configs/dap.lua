---------
-- DAP --
---------
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- 'David-Kunz/jester',                 -- Debugging Jest tests
    'theHamsta/nvim-dap-virtual-text',   -- Show variable values in virtual text
    'mxsdev/nvim-dap-vscode-js',         -- DAP adapter for vs**de-js-debug
    'mason-org/mason.nvim',              -- Manage DAP adapters
    'jay-babu/mason-nvim-dap.nvim',      -- Automatic DAP configuration
    'ofirgall/goto-breakpoints.nvim',    -- Jump to next/previous breakpoint
    'nvim-telescope/telescope-dap.nvim', -- Telescope integration
  },
  keys = {
    { '<leader>td', '<cmd>Telescope dap commands<CR>',         desc = 'DAP commands' },
    { '<leader>tb', '<cmd>Telescope dap list_breakpoints<CR>', desc = 'DAP breakpoints' },
    { '<leader>tv', '<cmd>Telescope dap variables<CR>',        desc = 'DAP variables' },
    { '<leader>tf', '<cmd>Telescope dap frames<CR>',           desc = 'DAP variables' },
  },
  cmd = {
    'DapContinue',
    'DapDisconnect',
    'DapNew',
    'DapTerminate',
    'DapRestartFrame',
    'DapStepInto',
    'DapStepOut',
    'DapStepOver',
    'DapEval',
    'DapToggleRepl',
    'DapClearBreakpoints',
    'DapToggleBreakpoint',
    'DapSetLogLevel',
  },
  config = function()
    local dap = require('dap')
    -- local jester = require('jester')
    local mason_dap = require('mason-nvim-dap')
    local map = require('utils').map
    local sign_define = vim.fn.sign_define
    local breakpoint = require('goto-breakpoints')

    sign_define('DapBreakpoint',          { text = '', texthl = 'Error' })
    sign_define('DapBreakpointCondition', { text = 'לּ', texthl = 'Error' })
    sign_define('DapLogPoint',            { text = '', texthl = 'Directory' })
    sign_define('DapStopped',             { text = 'ﰲ', texthl = 'TSConstant' })
    sign_define('DapBreakpointRejected',  { text = '', texthl = 'Error' })

    -- Automatically set up installed DAP adapters
    ---@diagnostic disable-next-line: missing-fields
    mason_dap.setup({ automatic_installation = true })

    local function continue()
      -- Loads .vscode/launch.json files if available
      require('dap.ext.vscode').load_launchjs(nil, {
        ['pwa-node'] = { 'typescript' },
        ['node'] = { 'typescript' },
      })

      dap.continue()
    end

    -- Mappings --
    -- TODO: use stackmap.nvim to add ]s as "next step", or something similar
    map('n', '<leader>dB', function()
      vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(condition)
        dap.set_breakpoint(condition)
      end)
    end, 'DAP set conditional breakpoint')
    map('n', '<leader>dc', continue,              'DAP continue')
    map('n', '<leader>ds', dap.step_over,         'DAP step over')
    map('n', '<leader>di', dap.step_into,         'DAP step into')
    map('n', '<leader>do', dap.step_out,          'DAP step out')
    map('n', '<leader>db', dap.toggle_breakpoint, 'DAP toggle breakpoint')
    map('n', '<leader>dB', dap.clear_breakpoints, 'DAP remove breakpoints')
    map('n', '<leader>dR', dap.repl.open,         'DAP open REPL')
    map('n', '<leader>dl', dap.run_last,          'DAP run last session')
    map('n', '<leader>dr', dap.restart,           'DAP restart session')
    map('n', '<leader>dq', dap.terminate,         'DAP terminate session')

    -- -- Jester
    -- map('n', '<leader>djt', jester.debug,      'DAP Jester debug test')
    -- map('n', '<leader>djf', jester.debug_file, 'DAP Jester debug file')
    -- map('n', '<leader>djr', jester.debug_last, 'DAP Jester rerun debug')
    -- map('n', '<leader>djT', jester.run,        'DAP Jester run test')
    -- map('n', '<leader>djF', jester.run_file,   'DAP Jester run file')
    -- map('n', '<leader>djR', jester.run_last,   'DAP Jester rerun test')

    -- Go to breakpoints
    map('n', ']b', breakpoint.next, 'Go to next breakpoint')
    map('n', '[b', breakpoint.prev, 'Go to previous breakpoint')

    -- DAP virtual text --
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-dap-virtual-text').setup({})

    -- Rust/C++/C --
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = 'codelldb',
        args = { '--port', '${port}' },
      }
    }

    dap.configurations.rust = {
      -- {
      --   name = 'Launch current file',
      --   type = 'codelldb',
      --   request = 'launch',
      --   program = function() return vim.api.nvim_buf_get_name(0) end, -- TODO: find debug binary
      --   cwd = '${workspaceFolder}',
      --   stopOnEntry = false,
      -- },
      {
        name = 'Launch file...',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    dap.configurations.cpp = dap.configurations.rust
    dap.configurations.c = dap.configurations.rust

    -- TypeScript/JavaScript --
    ---@diagnostic disable-next-line: missing-fields
    require('dap-vscode-js').setup({
      debugger_cmd = { 'js-debug-adapter' },
      adapters = {
        'pwa-node',
        'pwa-chrome',
        'pwa-msedge',
        'node-terminal',
        'pwa-extensionHost',
      },
    })

    -- Jester
    -- Doesn't seem to have been updated to the new nvim-treesitter API
    -- jester.setup({
    --   dap = {
    --     type = 'pwa-node',
    --   },
    -- })

    for _, language in ipairs({ 'typescript', 'javascript' }) do
      dap.configurations[language] = {
        {
          name = 'Debug Jest Unit Tests (default)',
          type = 'pwa-node',
          request = 'launch',
          runtimeArgs = {
            './node_modules/jest/bin/jest.js',
            '--runInBand',
          },
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
        },
        {
          name = 'Attach to running process (default)',
          type = 'pwa-node',
          request = 'attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        }
      }
    end

    -- Loads .vscode/launch.json files if available
    require('dap.ext.vscode').load_launchjs(nil, {
      ['pwa-node'] = { 'typescript' },
      ['node'] = { 'typescript' },
    })
  end,
}

---------
-- DAP --
---------
return { 'mfussenegger/nvim-dap',
  requires = {
    'rcarriga/nvim-dap-ui',    -- UI for nvim-dap
    'ravenxrz/DAPInstall.nvim' -- Installing/uninstalling debuggers
                               -- temporary branch while dap-buddy is written
  },
  keys = { '<F5>', '<F10>', '<F11>', '<F12>', '<F12>', '<F9>' },
  cmd = { 'DIInstall', 'DIUninstall', 'DIList' },
  config = function ()
    -- local di = require('dap-install')
    -- di.setup { verbosely_call_debuggers = true }
    -- di.config('chrome', {})
    -- di.config('jsnode')
    -- di.config('python')
    -- di.config('lua')

    -- require('dap.ext.vscode').load_launchjs()

    local function map(modes, lhs, rhs, opts)
      if (type(modes) ~= 'table') then modes = {modes} end

      for _, mode in pairs(modes) do
        local options = {noremap = true}
        if opts then options = vim.tbl_extend('force', options, opts) end
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
      end
    end

    -- local map = require('utils').map
    -- map('n', '<F5>', require'dap'.continue)

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

    -- -- dap-ui --
    -- require('dapui').setup()

    -- map('n', '<leader>De',  ':lua require("dapui").eval()<CR>', {silent = true})



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


    local home = os.getenv('HOME')
    local dap = require('dap')
    dap.adapters.node2 = {
      type = 'executable',
      command = 'node',
      -- args = {home .. '/personal/microsoft-sucks/vscode-node-debug2/out/src/nodeDebug.js'},
      args = { home .. '/.local/share/nvim/dapinstall/jsnode/vscode-node-debug2/out/src/nodeDebug.js' },
    }

    dap.configurations.javascript = {
      {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.loop.cwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require('dap.utils').pick_process,
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
    }
  end,
}


----------
-- Lens --
----------
return { 'camspiers/lens.vim', -- Automatic window resizing
  event = 'WinEnter',
  config = function()
    vim.g['lens#disabled_filetypes'] = {
      'qf',
      'fzf',
      'fugitiveblame',
      'NvimTree',
      'DiffviewFiles',
      'DiffviewFileHistory',
      'dapui_scopes',
      'dap-repl',
      'dapui_watches',
      'dapui_console',
      'dapui_stacks',
      'dapui_breakpoints',
    }
  end
}

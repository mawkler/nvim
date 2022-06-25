----------
-- Lens --
----------
return { 'camspiers/lens.vim', -- Automatic window resizing
  event = 'WinEnter',
  config = function()
    vim.g['lens#disabled_filetypes'] = {
      'fzf',
      'fugitiveblame',
      'NvimTree',
      'DiffviewFileHistory',
      'dapui_scopes',
      'dap-repl',
    }
  end
}

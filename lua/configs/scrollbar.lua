return { 'petertriho/nvim-scrollbar',
  after = 'gitsigns.nvim',
  config = function()
    local diagnostics = {
      text = { '─', '═' },
    }

    require('scrollbar').setup({
      show_in_active_only = true,
      hide_if_all_visible = true,
      excluded_filetypes = {
        'prompt',
        'TelescopePrompt',
        'noice',
        'DressingInput',
      },
      handle = {
        highlight = 'Scrollbar',
      },
      marks = {
        Cursor = { text = '─' },
        Error = diagnostics,
        Warn = diagnostics,
        Info = diagnostics,
        Hint = diagnostics,
      },
    })
  end
}

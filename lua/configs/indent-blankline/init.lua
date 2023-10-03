----------------------
-- Indent blankline --
----------------------
return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  main = 'ibl',
  config = function()
    -- Don't show lines on the first indent level
    local hooks, builtin = require ('ibl.hooks'), require('ibl.hooks').builtin
    hooks.register(hooks.type.WHITESPACE, builtin.hide_first_space_indent_level)
    hooks.register(hooks.type.WHITESPACE, builtin.hide_first_tab_indent_level)

    require('ibl').setup({
      indent = { char = '▏' },
      scope = { enabled = false, },
      exclude = {
        filetypes = require('configs.indent-blankline.config').disabled_filetypes,
        buftypes = { 'fzf', 'help', 'terminal', 'nofile' },
      },
    })
  end
}

------------------------
-- editable-term.nvim --
------------------------
return {
  'xb-bx/editable-term.nvim',
  opts = {
    promts = {
      ['╰─❯ '] = {}, -- zsh
      ['^>>> '] = {}, -- python
      ['^%(gdb%) '] = {}, -- gdb
    },
  },
}

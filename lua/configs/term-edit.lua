---------------
-- Term-edit --
---------------
return {
  'chomosuke/term-edit.nvim',
  event = 'TermEnter',
  config = function()
    require('term-edit').setup({
      prompt_end = '╰─❯ '
    })
  end
}

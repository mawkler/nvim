---------------
-- Term-edit --
---------------
return {
  'chomosuke/term-edit.nvim',
  event = 'TermEnter',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('term-edit').setup({
      prompt_end = '╰─❯ '
    })
  end
}

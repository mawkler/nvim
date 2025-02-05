----------------------
-- vim-textobj-user --
----------------------
return {
  'kana/vim-textobj-user',
  keys = {
    -- vim-textobj-user
    { 'iD', mode = { 'x', 'o' } },
    { 'aD', mode = { 'x', 'o' } },
  },
  config = function()
    vim.fn['textobj#user#plugin']('datetime', {
      date = {
        pattern = '\\<\\d\\d\\d\\d-\\d\\d-\\d\\d\\>',
        select = { 'aD', 'iD' },
      }
    })
  end
}

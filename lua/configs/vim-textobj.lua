----------------------
-- vim-textobj-user --
----------------------
local mode = { 'x', 'o' }
return {
  'kana/vim-textobj-user',
  dependencies = {
    'kana/vim-textobj-line',               -- Line text object
    'Julian/vim-textobj-variable-segment', -- camelCase/snake_case text objects
  },
  keys = {
    -- vim-textobj-line
    { 'aL', '<Plug>(textobj-line-a)', mode = mode },
    { 'iL', '<Plug>(textobj-line-i)', mode = mode },
    -- vim-textobj-user
    { 'id', mode = mode },
    { 'ad', mode = mode },
    -- vim-textobj-variable-segment
    { 'iv', mode = mode },
    { 'av', mode = mode },
  },
  setup = function()
    vim.g.textobj_line_no_default_key_mappings = 1
  end,
  config = function()
    vim.fn['textobj#user#plugin']('datetime', {
      date = {
        pattern = '\\<\\d\\d\\d\\d-\\d\\d-\\d\\d\\>',
        select = {'ad', 'id'},
      }
    })
  end
},
-- Markdown text-objects
{
  'coachshea/vim-textobj-markdown',
  dependencies = 'kana/vim-textobj-user',
  ft = 'markdown'
}

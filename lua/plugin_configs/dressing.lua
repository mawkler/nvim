--------------
-- Dressing --
--------------
local utils = require('../utils')
local map, feedkeys, autocmd = utils.map, utils.feedkeys, utils.autocmd

local d_input = require('dressing.input')
require('dressing').setup {
  select = {
    telescope = require('telescope.themes').get_dropdown()
  },
  input = {
    insert_only = false,
    relative = 'editor',
    default_prompt = ' ', -- Doesn't seem to work
  }
}

autocmd('Filetype', {
  pattern = 'DressingInput',
  callback = function()
    feedkeys('<Esc>V<C-g>', 'i') -- Enter input window in select mode
    map({'i', 's'}, '<C-j>', d_input.history_next, { buffer = true })
    map({'i', 's'}, '<C-k>', d_input.history_prev, { buffer = true })
    map({'s', 'n'}, '<C-c>', d_input.close,        { buffer = true })
    map('s',        '<CR>',  d_input.confirm,      { buffer = true })
  end,
  group = 'Dressing'
})

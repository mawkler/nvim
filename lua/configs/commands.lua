-------------------
-- User commands --
-------------------
local api, fn = vim.api, vim.fn

api.nvim_create_user_command(
  'Search',
  ':let @/="\\\\V" . escape(<q-args>, "\\\\\") | normal! n',
  { nargs = 1, desc = 'Search literally, with no regex' }
)

api.nvim_create_user_command(
  'CDHere',
  'cd %:p:h',
  { desc = "Change working directory to current file's" }
)

api.nvim_create_user_command(
  'YankPath',
  function()
    fn.setreg('+', fn.expand('%:~'))
    vim.notify('Yanked file path: ' .. fn.getreg('+'))
  end,
  { desc = "Yank current file's path" }
)

api.nvim_create_user_command(
  'YankPathRelative',
  function()
    fn.setreg('+', fn.expand('%'))
    vim.notify('Yanked file path: ' .. fn.getreg('+'))
  end,
  { desc = "Yank current file's path" }
)

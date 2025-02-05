--------------
-- Dressing --
--------------
return {
  'stevearc/dressing.nvim',
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    local utils = require('utils')
    local map, feedkeys = utils.map, utils.feedkeys

    require('dressing').setup({
      select = {
        telescope = require('telescope.themes').get_dropdown()
      },
      input = {
        insert_only = false,
        relative = 'editor',
        default_prompt = ' ', -- Doesn't seem to work
      }
    })

    vim.api.nvim_create_augroup('Dressing', {})
    vim.api.nvim_create_autocmd('Filetype', {
      pattern = 'DressingInput',
      callback = function()
        local input = require('dressing.input')

        if vim.g.grep_string_mode then
          -- Enter input window in select mode
          feedkeys('<Esc>V<C-g>', 'i')
        end
        map({ 'i', 's' }, '<C-j>', input.history_next, { buffer = true })
        map({ 'i', 's' }, '<C-k>', input.history_prev, { buffer = true })
        map({ 's', 'n' }, '<C-c>', input.close,        { buffer = true })
        map('s',          '<CR>',  input.confirm,      { buffer = true })
      end,
      group = 'Dressing'
    })
  end
}

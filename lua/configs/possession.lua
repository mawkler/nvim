----------------
-- Possession --
----------------

local function list_sessions()
  local telescope, themes = require('telescope'), require('telescope.themes')
  telescope.extensions.possession.list(themes.get_dropdown({
    layout_config = { mirror = true },
  }))
end

return {
  'jedrzejboczar/possession.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VimLeavePre',
  keys = {
    { '<leader>s', list_sessions, { desc = 'Open session' } },
  },
  cmd = {
    'SessionSave',
    'SessionLoad',
    'SessionRename',
    'SessionClose',
    'SessionDelete',
    'SessionShow',
    'SessionList',
    'SessionMigrate',
  },
  config = function()
    local telescope = require('telescope')
    local delete_hidden_filetypes = { 'toggleterm', 'undotree' }

    require('possession').setup({
      silent = true,
      autosave = {
        current = true,
        tmp = true,
        tmp_name = 'default',
      },
      commands = {
        save = 'SessionSave',
        load = 'SessionLoad',
        rename = 'SessionRename',
        close = 'SessionClose',
        delete = 'SessionDelete',
        show = 'SessionShow',
        list = 'SessionList',
        migrate = 'SessionMigrate',
      },
      plugins = {
        delete_hidden_buffers = {
          force = function(bufnr)
            local buf = { buf = bufnr }
            local filetype = vim.api.nvim_get_option_value('filetype', buf)
            return vim.tbl_contains(delete_hidden_filetypes, filetype)
          end,
          hooks = {
            'before_load',
            not vim.o.sessionoptions:match('buffer') and 'before_save',
          },
        },
      },
    })

    telescope.load_extension('possession')
  end
}

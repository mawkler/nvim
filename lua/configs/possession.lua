----------------
-- Possession --
----------------

local function list_sessions()
  local telescope, themes = require('telescope'), require('telescope.themes')
  telescope.extensions.possession.list(themes.get_dropdown({
    previewer = false,
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
          force = function(buf)
            local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
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

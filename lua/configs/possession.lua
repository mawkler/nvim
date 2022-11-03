----------------
-- Possession --
----------------
return { 'jedrzejboczar/possession.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  event = 'VimLeavePre',
  keys = '<leader>s',
  cmd = {
    'SessionSave',
    'SessionLoad',
    'SessionClose',
    'SessionDelete',
    'SessionShow',
    'SessionList',
    'SessionMigrate',
  },
  config = function()
    local plugin_setup = require('utils').plugin_setup
    local map = require('utils').map
    local telescope, themes = require('telescope'), require('telescope.themes')

    local delete_hidden_filetypes = { 'toggleterm' }

    plugin_setup('possession', {
      silent = true,
      autosave = {
        current = true,
        tmp = true,
        tmp_name = 'default',
      },
      commands = {
        save = 'SessionSave',
        load = 'SessionLoad',
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

    local function list_sessions()
      telescope.extensions.possession.list(themes.get_dropdown({
        previewer = false,
      }))
    end

    map('n', '<leader>s', list_sessions, { desc = 'Sessions' })
  end
}

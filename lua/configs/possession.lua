----------------
-- Possession --
----------------
return { 'jedrzejboczar/possession.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    local plugin_setup = require('utils').plugin_setup
    local map = require('utils').map
    local telescope, themes = require('telescope'), require('telescope.themes')

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
      }
    })

    local function list_sessions()
      telescope.extensions.possession.list(themes.get_dropdown({
        previewer = false,
      }))
    end

    map('n', '<leader>s', list_sessions, { desc = 'Sessions' })
  end
}

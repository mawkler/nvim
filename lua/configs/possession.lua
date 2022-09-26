----------------
-- Possession --
----------------
return { 'jedrzejboczar/possession.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    local plugin_setup = require('utils').plugin_setup
    local map = require('utils').map

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

    map('n', '<leader>s', function()
      require('telescope').extensions.possession.list()
    end, { desc = 'Sessions' })
  end
}

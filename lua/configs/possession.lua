----------------
-- Possession --
----------------

local function list_sessions()
  local telescope, themes = require('telescope'), require('telescope.themes')
  telescope.extensions.possession.list(themes.get_dropdown({
    layout_config = { mirror = true },
  }))
end

local function compute_session_name()
  local active_session_name = require('possession.session').get_session_name()
  if active_session_name ~= nil then
    return active_session_name
  end

  local git_root_dir = vim.fn.finddir('.git', vim.fn.expand('%:p:h') .. ';')

  local root_path
  if git_root_dir ~= '' then
    root_path = vim.fn.fnamemodify(git_root_dir, ':p:h:h')
  else
    root_path = vim.fn.getcwd()
  end

  return vim.fn.fnamemodify(root_path, ':t')
end

local function save_session()
  local session_name = compute_session_name()
  local command = ('SessionSave! %s'):format(session_name)

  vim.cmd(command)
  vim.notify(("Saved session '%s'"):format(session_name))
end

return {
  'jedrzejboczar/possession.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VimLeavePre',
  keys = {
    { '<leader>so', list_sessions,            { desc = 'Open session' } },
    { '<leader>ss', save_session,             { desc = 'Save session' } },
    { '<leader>sr', '<cmd>SessionRename<CR>', { desc = 'Rename session' } },
    { '<leader>sd', ':SessionDelete',         { desc = 'Delete session' } },
  },
  cmd = {
    'SessionSave',
    'SessionLoad',
    'SessionSaveCwd',
    'SessionLoadCwd',
    'SessionRename',
    'SessionClose',
    'SessionDelete',
    'SessionShow',
    'SessionList',
    'SessionListCwd',
    'SessionMigrate',
  },
  config = function()
    local telescope = require('telescope')

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
        save_cwd = 'SessionSaveCwd',
        load_cwd = 'SessionLoadCwd',
        rename = 'SessionRename',
        close = 'SessionClose',
        delete = 'SessionDelete',
        show = 'SessionShow',
        list = 'SessionList',
        list_cwd = 'SessionListCwd',
        migrate = 'SessionMigrate',
      },
      plugins = {
        delete_buffers = true,
        delete_hidden_buffers = true,
        close_windows = {
          match = {
            buftype = { 'help', 'nofile' },
            filetype = { 'toggleterm', 'undotree', 'rest_nvim_result' },
          },
        },
      },
      hooks = {
        -- I sometimes get an error with windows.nvim when restoring
        -- sessions, Hopefully this fixes that.
        before_load = function()
          pcall(vim.cmd.WindowsDisableAutowidth)
          return true
        end,
        after_load = function()
          pcall(vim.cmd.WindowsEnableAutowidth)
        end,
      },
    })

    telescope.load_extension('possession')
  end
}

--------------
-- Resession --
--------------

local function list_sessions()
  local telescope, themes = require('telescope'), require('telescope.themes')
  telescope.extensions.resession.resession(themes.get_dropdown({
    layout_config = { mirror = true },
  }))
end

local function compute_session_name()
  local current = require('resession').get_current()
  if current ~= nil then
    return current
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
  require('resession').save(session_name)
end

local function rename_session()
  local resession = require('resession')
  local current = resession.get_current()
  if current == nil then
    vim.notify('No active session to rename', vim.log.levels.WARN)
    return
  end

  local info = resession.get_current_session_info()
  local is_tab = info and info.tab_scoped or false

  vim.ui.input({ prompt = 'New session name: ', default = current }, function(new_name)
    if new_name == nil or new_name == '' or new_name == current then
      return
    end

    if is_tab then
      resession.save_tab(new_name)
    else
      resession.save(new_name)
    end

    local dir = info and info.dir or nil
    resession.delete(current, { dir = dir, notify = false })
    vim.notify(("Renamed session '%s' -> '%s'"):format(current, new_name))
  end)
end

local function delete_session()
  require('resession').delete()
end

return {
  'stevearc/resession.nvim',
  lazy = true,
  event = 'VimLeavePre',
  keys = {
    { '<leader>so', list_sessions,  { desc = 'Open session' } },
    { '<leader>ss', save_session,   { desc = 'Save session' } },
    { '<leader>sr', rename_session, { desc = 'Rename session' } },
    { '<leader>sd', delete_session, { desc = 'Delete session' } },
  },
  config = function()
    local resession = require('resession')

    resession.setup({
      autosave = {
        enabled = true,
        interval = 60,
        notify = true,
      },
      buf_filter = function(bufnr)
        local filetype = vim.bo[bufnr].filetype
        if filetype == 'toggleterm' or filetype == 'undotree' or filetype == 'rest_nvim_result' then
          return false
        end

        local buftype = vim.bo[bufnr].buftype
        if buftype == 'nofile' then
          return false
        end

        return resession.default_buf_filter(bufnr)
      end,
      extensions = {
        quickfix = {},
      },
    })

    local ok, err = pcall(function()
      require('telescope').load_extension('resession')
    end)
    if not ok then
      vim.notify('Failed to load resession telescope extension: ' .. tostring(err), vim.log.levels.ERROR)
    end
  end,
}

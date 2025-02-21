local M = {}

function M.termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---@param mode string | string[]
---@param lhs string
---@param rhs string | function
---@param opts? string | vim.keymap.set.Opts
function M.map(mode, lhs, rhs, opts)
  if type(opts) == 'string' then
    opts = { desc = opts }
  end
  local options = vim.tbl_extend('keep', opts or {}, { silent = true })
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.local_map(buffer)
  return function(modes, lhs, rhs, opts)
    if type(opts) == 'string' then
      opts = { desc = opts, buffer = buffer }
    end
    local options = vim.tbl_extend('keep', opts or {}, { silent = true })

    vim.keymap.set(modes, lhs, rhs, options)
  end
end

function M.feedkeys(keys, mode)
  if mode == nil then mode = 'in' end
  return vim.api.nvim_feedkeys(M.termcodes(keys), mode, true)
end

function M.feedkeys_count(keys, mode)
  return M.feedkeys(vim.v.count1 .. keys, mode)
end

function M.error(message)
  vim.api.nvim_echo({ { message, 'Error' } }, false, {})
end

--- Returns a new table with `element` appended to `tbl`
function M.append(tbl, element)
  local new_table = vim.deepcopy(tbl)
  table.insert(new_table, element)
  return new_table
end

--- Gets the buffer number of every visible buffer
--- @return integer[]
function M.visible_buffers()
  return vim.tbl_map(vim.api.nvim_win_get_buf, vim.api.nvim_list_wins())
end

local function lsp_server_has_references()
  return vim.tbl_contains(vim.lsp.get_clients(), function(client)
    local capabilities = client.server_capabilities
    return capabilities and capabilities.referencesProvider
  end, { predicate = true })
end

--- Clear all highlighted LSP references in all windows
function M.clear_lsp_references()
  vim.cmd.nohlsearch()
  if lsp_server_has_references() then
    vim.lsp.buf.clear_references()
    for _, buffer in pairs(M.visible_buffers()) do
      vim.lsp.util.buf_clear_references(buffer)
    end
  end
end

--- Get Mason package install path
function M.get_install_path(package)
  return require('mason-registry').get_package(package):get_install_path()
end

--- Import plugin config from external module in `lua/configs/`
function M.use(module)
  local ok, m = pcall(require, ('configs.%s'):format(module))
  if ok then
    return m
  else
    vim.notify(('Failed to import Lazy config module %s: %s'):format(module, m))
    return {}
  end
end

function M.noice_is_loaded()
  local success, _ = pcall(require, 'noice.config')
  return success and require('noice.config')._running
end

function M.plugin_is_loaded(plugin)
  -- Checking with `require` and `pcall` will cause Lazy to load the plugin
  local plugins = require('lazy.core.config').plugins
  return not not plugins[plugin] and plugins[plugin]._.loaded
end

return M

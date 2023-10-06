local M = {}

M.termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.map = function(modes, lhs, rhs, opts)
  if type(opts) == 'string' then
    opts = { desc = opts }
  end
  local options = vim.tbl_extend('keep', opts or {}, { silent = true })
  vim.keymap.set(modes, lhs, rhs, options)
end

M.feedkeys = function(keys, mode)
  if mode == nil then mode = 'in' end
  return vim.api.nvim_feedkeys(M.termcodes(keys), mode, true)
end

M.feedkeys_count = function(keys, mode)
  return M.feedkeys(vim.v.count1 .. keys, mode)
end

M.error = function(message)
  vim.api.nvim_echo({{ message, 'Error' }}, false, {})
end

--- Returns a new table with `element` appended to `tbl`
M.append = function(tbl, element)
  local new_table = vim.deepcopy(tbl)
  table.insert(new_table, element)
  return new_table
end

--- Gets the buffer number of every visible buffer
--- @return integer[]
M.visible_buffers = function()
  return vim.tbl_map(vim.api.nvim_win_get_buf, vim.api.nvim_list_wins())
end

local function lsp_server_has_references()
  vim.tbl_contains(vim.lsp.get_clients(), function(client)
    return client.server_capabilities
  end, { predicate = true })
end

--- Clear all highlighted LSP references in all windows
M.clear_lsp_references = function()
  vim.cmd.nohlsearch()
  if lsp_server_has_references() then
    vim.lsp.buf.clear_references()
    for _, buffer in pairs(M.visible_buffers()) do
      vim.lsp.util.buf_clear_references(buffer)
    end
  end
end

--- Close every floating window
M.close_floating_windows = function()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    -- Sometimes the window doesn't exist anymore for some reason
    local success, win_config = pcall(vim.api.nvim_win_get_config, win)
    if success and vim.tbl_contains({'win', 'editor'}, win_config.relative) then
      vim.api.nvim_win_close(win, false)
    end
  end
end

--- Get Mason package install path
 M.get_install_path = function(package)
  return require('mason-registry').get_package(package):get_install_path()
end


--- Import plugin config from external module in `lua/configs/`
M.use = function(module)
  local ok, m = pcall(require, string.format('configs.%s', module))
  if ok then
    return m
  else
    vim.notify(string.format('Failed to import Lazy config module %s: %s', module, m))
    return {}
  end
end

M.noice_is_loaded = function()
  local success, _ = pcall(require, 'noice.config')
  return success and require('noice.config')._running
end

return M

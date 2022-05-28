local M = {}

M.termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.map = function(modes, lhs, rhs, opts)
  if type(opts) == 'string' then
    opts = { desc = opts }
  end
  vim.keymap.set(modes, lhs, rhs, opts)
end

M.feedkeys = function(keys, mode)
  if mode == nil then mode = 'i' end
  return vim.api.nvim_feedkeys(M.termcodes(keys), mode, true)
end

M.error = function(message)
  vim.api.nvim_echo({{ message, 'Error' }}, false, {})
end

vim.api.nvim_create_augroup('DefaultAugroup', {})

M.autocmd = function(event, opts)
  opts.group = opts.group or 'DefaultAugroup'
  vim.api.nvim_create_autocmd(event, opts)
end

M.visible_buffers = function()
  local bufs = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    bufs[vim.api.nvim_win_get_buf(win)] = true
  end
  return vim.tbl_keys(bufs)
end

local function lsp_server_has_references()
  for _, client in pairs(vim.lsp.buf_get_clients()) do
    if client.resolved_capabilities.find_references then
      return true
    end
  end
  return false
end

M.clear_lsp_references = function()
  vim.cmd 'nohlsearch'
  if lsp_server_has_references() then
    vim.lsp.buf.clear_references()
    for _, buffer in pairs(M.visible_buffers()) do
      vim.lsp.util.buf_clear_references(buffer)
    end
  end
end

return M

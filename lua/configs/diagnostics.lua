-----------------
-- Diagnostics --
-----------------

local M = {}

---@param severity vim.diagnostic.Severity
---@return string
function M.get_icon(severity)
  local icons = {
    [vim.diagnostic.severity.ERROR] = '',
    [vim.diagnostic.severity.WARN]  = '',
    [vim.diagnostic.severity.HINT]  = '',
    [vim.diagnostic.severity.INFO]  = '',
  }
  return icons[severity]
end

return M

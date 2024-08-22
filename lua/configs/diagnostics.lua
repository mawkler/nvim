-----------------
-- Diagnostics --
-----------------

local M = {}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
  }
)

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

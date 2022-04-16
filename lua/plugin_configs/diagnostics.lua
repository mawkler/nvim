-----------------
-- Diagnostics --
-----------------
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
  }
)

local function sign_define(name, symbol)
  vim.fn.sign_define(name, {
    text   = symbol,
    texthl = name,
  })
end

sign_define('DiagnosticSignError', '')
sign_define('DiagnosticSignWarn',  '')
sign_define('DiagnosticSignHint',  '')
sign_define('DiagnosticSignInfo',  '')

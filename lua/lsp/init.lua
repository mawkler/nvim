-- LSPInstall --
require('lspinstall').setup()

local on_attach = require('completion').on_attach()

-- Config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- Lua config
local lua_settings = {
  Lua = {
    diagnostics = {
      globals = {'vim'}, -- Make the LSP recognize the `vim` global
    }
  }
}

-- LSPInstall
local servers = require('lspinstall').installed_servers()
for _, server in pairs(servers) do
  local config = make_config()
  if server == "lua" then
    config.settings = lua_settings
  end

  require'lspconfig'[server].setup(config)
end

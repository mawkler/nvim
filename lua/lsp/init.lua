-- LSPInstall --
require('lspinstall').setup()

-- Config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    capabilities = capabilities, -- enable snippet support
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

local servers = require('lspinstall').installed_servers()
for _, server in pairs(servers) do
  local config = make_config()
  if server == 'lua' then
    config.settings = lua_settings
  end
  require'lspconfig'[server].setup(config)
end

-- Compe --
require('compe').setup {
  preselect = 'always',
  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.tab_complete()
  if vim.fn.pumvisible() == 1 then
    return vim.fn['compe#confirm']()
  elseif vim.fn['vsnip#available'] then
    return t '<Plug>(vsnip-expand-or-jump)'
  else
    return t '<C-t>'
  end
end

function _G.s_tab_complete()
  if vim.fn['vsnip#jumpable(-1)'] then
    return t '<Plug>(vsnip-jump-prev)'
  else
    return t '<C-d>'
  end
end

-- Mappings --
vim.api.nvim_set_keymap('i', '<Tab>',     'v:lua.tab_complete()',        {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>',     'v:lua.tab_complete()',        {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>',   'v:lua.s_tab_complete()',      {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>',   'v:lua.s_tab_complete()',      {expr = true})
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()',            {expr = true})
vim.api.nvim_set_keymap('i', '<C-y>',     'compe#scroll({"delta": -2})', {expr = true})
vim.api.nvim_set_keymap('i', '<C-e>',     'compe#scroll({"delta": +2})', {expr = true})

-- lspkind --
require('lspkind').init()

-- Telescope --
require('telescope').setup()

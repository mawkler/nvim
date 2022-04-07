-------------------
-- LSP Installer --
-------------------

local map = require('../utils').map
local visible_buffers = require('../utils').visible_buffers
local feedkeys = require('../utils').feedkeys

local b, bo, lsp, diagnostic = vim.b, vim.bo, vim.lsp, vim.diagnostic

local function make_opts(snippets)
  if snippets == nil then snippets = true end
  local capabilities = lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = snippets
  return { capabilities = capabilities } -- enable snippet support
end

-- Typescript LSP config
local typescript_settings = {
  init_options = require('nvim-lsp-ts-utils').init_options,
  on_attach = function(client)
    local ts_utils = require('nvim-lsp-ts-utils')
    ts_utils.setup({
      update_imports_on_move = true,
      require_confirmation_on_move = true,
      inlay_hints_highlight = 'NvimLspTSUtilsInlineHint'
    })
    ts_utils.setup_client(client)

    local opts = { buffer = true }
    map('n', '<leader>lo', '<cmd>TSLspOrganize<CR>', opts)
    map('n', '<leader>lr', '<cmd>TSLspRenameFile<CR>', opts)
    map('n', '<leader>li', '<cmd>TSLspImportAll<CR>', opts)
    map('n', '<leader>lI', '<cmd>TSLspImportCurrent<CR>', opts)
    map('n', '<leader>lh', '<cmd>TSLspToggleInlayHints<CR>', opts)
  end,
}

-- Lua LSP config
local lua_settings = require('lua-dev').setup {
  lspconfig = {
    settings = {
      Lua = {
        diagnostics = {
          globals = {'use'},
        }
      }
    }
  }
}

-- YAML LSP config
local yaml_settings = {
  yaml = {
    schemaStore = {
      url = 'https://www.schemastore.org/api/json/catalog.json',
      enable = true
    }
  }
}

-- Zsh/Bash LSP config
local bash_settings = {
  filetypes = {'sh', 'zsh'}
}

-- Json
local json_settings = {
  json = {
    schemas = require('schemastore').json.schemas()
  }
}

require('nvim-lsp-installer').on_server_ready(function(server)
  local opts = make_opts()
  if server.name == 'sumneko_lua' then
    opts = lua_settings
  elseif server.name == 'bashls' then
    opts = bash_settings
  elseif server.name == 'tsserver' then
    opts = typescript_settings
  elseif server.name == 'yaml' then
    opts.settings = yaml_settings
  elseif server.name == 'jsonls' then
    opts.settings = json_settings
  end
  server:setup(opts)
  vim.cmd 'do User LspAttachBuffers'
end)

----------------
-- LSP Config --
----------------
lsp.handlers['textDocument/hover'] = lsp.with(
  lsp.handlers.hover,
  { border = 'single' }
)

lsp.handlers['textDocument/signatureHelp'] = lsp.with(
  lsp.handlers.signature_help,
  { border = 'single' }
)

-------------
-- LSPKind --
-------------
require('lspkind').init {
  symbol_map = {
    Class     = '',
    Interface = '',
    Module    = '',
    Enum      = '',
    Text      = '',
    Struct    = ''
  }
}

------------------
-- LSP Mappings --
------------------
local INFO = vim.diagnostic.severity.INFO
local error_opts = {severity = { min = INFO }, float = { border = 'single' }}
local info_opts = {severity = { max = INFO }, float = { border = 'single' }}
local with_border = {float = { border = 'single' }}

local function lsp_server_has_references()
  for _, client in pairs(vim.lsp.buf_get_clients()) do
    if client.resolved_capabilities.find_references then
      return true
    end
  end
  return false
end

local function clear_lsp_references()
  vim.cmd 'nohlsearch'
  if lsp_server_has_references() then
    lsp.buf.clear_references()
    for _, buffer in pairs(visible_buffers()) do
      lsp.util.buf_clear_references(buffer)
    end
  end
end

local function lsp_references()
  clear_lsp_references()
  vim.lsp.buf.document_highlight()
  require('telescope.builtin').lsp_references({ includeDeclaration = false })
end

-- LSP and diagnostics
map('n',        'gd',        require('telescope.builtin').lsp_definitions, 'vim.lsp.buf.definition')
map('n',        'gi',        require('telescope.builtin').lsp_implementations, 'vim.lsp.buf.implementation')
map('n',        'gD',        lsp.buf.type_definition, 'vim.lsp.buf.type_definition')
map('n',        'gh',        lsp.buf.hover, 'vim.lsp.buf.hover')
map('n',        'gs',        lsp.buf.signature_help, 'vim.lsp.buf.signature_help')
map({'i', 's'}, '<M-s>',     lsp.buf.signature_help, 'vim.lsp.buf.signature_help')
map('n',        'gr',        lsp_references, 'vim.lsp.buf.references')
map({'n', 'x'}, '<leader>r', vim.lsp.buf.rename, 'vim.lsp.buf.rename')
map({'n', 'x'}, '<leader>a', lsp.buf.code_action, 'vim.lsp.buf.code_action')
map('n',        '<leader>e', function() return diagnostic.open_float({border = 'single'}) end, 'diagnostic.open_float')
map('n',        ']e',        function() return diagnostic.goto_next(error_opts) end, 'diagnostic.goto_next')
map('n',        '[e',        function() return diagnostic.goto_prev(error_opts) end, 'Previous error')
map('n',        '[h',        function() return diagnostic.goto_prev(info_opts) end, 'Previous info')
map('n',        ']h',        function() return diagnostic.goto_next(info_opts) end, 'Next info')
map('n',        ']d',        function() return diagnostic.goto_next(with_border) end, 'Next diagnostic')
map('n',        '[d',        function() return diagnostic.goto_prev(with_border) end, 'Previous diagnostic')
map('n',        '<C-w>gd',   '<C-w>vgd', {desc = 'LSP go to definition in window split', remap = true})
map('n',        '<C-w>gi',   '<C-w>vgi', {desc = 'LSP go to implementaiton in window split', remap = true})
map('n',        '<C-w>gD',   '<C-w>vgD', {desc = 'LSP go to type definition in window split', remap = true})

-- Sets `bufhidden = delete` if buffer was jumped to
local function quickfix_jump(command)
  if b.buffer_jumped_to then
    bo.bufhidden = 'delete'
  end

  local successful, err_message = pcall(vim.cmd, command)
  if successful then
    b.buffer_jumped_to = true
  else
    error(err_message)
  end
end

map('n', ']q', function() return quickfix_jump('cnext') end, 'Next quickfix item')
map('n', '[q', function() return quickfix_jump('cprev') end, 'Previous quickfix item')
map('n', ']Q', '<cmd>cbelow<CR>')
map('n', '[Q', '<cmd>cabove<CR>')
map('n', ']l', '<cmd>lbelow<CR>')
map('n', '[l', '<cmd>labove<CR>')

map('n', '<Esc>', function()
  if bo.modifiable then
    clear_lsp_references()
  else
    return feedkeys('<C-w>c', 'n')
  end
end , 'Close window if not modifiable, otherwise :set nohlsearch')
map('t', '<Esc>', '<C-\\><C-n>')


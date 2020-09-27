local on_attach = function()
  require('completion').on_attach()
  require('diagnostic').on_attach()
end

require('nvim_lsp').tsserver.setup{on_attach=on_attach}
require('nvim_lsp').pyls.setup{on_attach=on_attach}
require('nvim_lsp').jdtls.setup{on_attach=on_attach}
require('nvim_lsp').vimls.setup{on_attach=on_attach}
require('nvim_lsp').sumneko_lua.setup{on_attach=on_attach}

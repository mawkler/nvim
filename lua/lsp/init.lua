local on_attach = function()
  require('completion').on_attach()
end

require('lspconfig').tsserver.setup{on_attach=on_attach}
require('lspconfig').pyls.setup{on_attach=on_attach}
require('lspconfig').jdtls.setup{on_attach=on_attach}
require('lspconfig').vimls.setup{on_attach=on_attach}
require('lspconfig').sumneko_lua.setup{on_attach=on_attach}

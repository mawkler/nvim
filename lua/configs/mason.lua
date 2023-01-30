-----------
-- Mason --
-----------
return { 'williamboman/mason.nvim',
  dependencies = 'williamboman/mason-lspconfig.nvim',
  config = function()
    require('mason').setup()

    require('mason-lspconfig').setup({
      ensure_installed = {
        'sumneko_lua',
        'vimls',
        'bashls',
        'pylsp',
        'tsserver',
      },
    })
  end
}

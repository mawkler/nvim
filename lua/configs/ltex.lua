----------
-- LTeX --
----------
return {
  'barreiroleo/ltex_extra.nvim',
  ft = { 'markdown', 'tex', 'text', },
  dependencies = 'neovim/nvim-lspconfig',
  opts = {
    -- ltex_extra options
    {
      load_langs = { 'en-US', 'sv' }
    },
    -- ltex-ls options
    server_opts = {
      settings = {
        ltex = {
          language = 'auto',
          diagnosticSeverity = 'hint',
          sentenceCacheSize = 2000,
          additionalRules = { motherTongue = 'sv' },
        },
      },
    },
  }
}

----------
-- LTeX --
----------
return {
  'barreiroleo/ltex_extra.nvim',
  ft = { 'markdown', 'tex', 'text', },
  dependencies = 'neovim/nvim-lspconfig',
  branch = 'dev', -- This plugin is being rewritten, so this is the maintained branch
  opts = {
    load_langs = { 'en-US', 'sv' },
  }
}

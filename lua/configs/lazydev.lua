-------------
-- Lazydev --
-------------
return {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      -- This This increases the indexing time quite significantly so I've
      -- disabled it for now in favour of explicit `--@module`s
      --
      -- '~/.local/share/nvim/lazy/',
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },
}

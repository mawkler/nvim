-------------
-- Lazydev --
-------------
return {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },

      -- This This increases the indexing time quite significantly so I've
      -- disabled it for now in favour of explicit `--@module`s, or adding the
      -- plugin path below
      --
      -- '~/.local/share/nvim/lazy/',
      { path = 'blink.cmp',          words = { 'Blink' } },
      { path = 'gx.nvim',            words = { 'Gx' } },
      { path = 'modicator.nvim',     words = { 'Modicator' } },
      { path = 'refjump.nvim',       words = { 'Refjump' } },
    },
  },
}

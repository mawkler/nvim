-----------
-- Other --
-----------
return {
  'rgroli/other.nvim',
  keys = {
    { 'go',      '<cmd>Other<CR>',       desc = 'Alternate file' },
    { '<C-w>go', '<cmd>OtherVSplit<CR>', desc = 'Alternate file (vsplit)' },
  },
  cmd = { 'Other', 'OtherSplit', 'OtherVSplit' },
  config = function()
    require('other-nvim').setup({
      style = {
        border = 'rounded',
      },
      mappings = {
        -- Bundled with other.nvim
        'livewire',
        'angular',
        'laravel',
        'rails',
        'golang',
        'python',
        'react',
        'rust',
        'elixir',
        'clojure',
        -- TypeScript Azure functions
        {
          pattern = '/(.*)/index.ts$',
          target = '/%1/function.json',
        },
        {
          pattern = '/(.*)/function.json$',
          target = '/%1/index.ts',
        },
        -- Jest tests
        {
          pattern = '(.*)/(.*).ts$',
          target = '%1/__{test,tests}__/%2.test.ts',
        },
        {
          pattern = '(.*)/__tests?__/(.*).test.ts$',
          target = '%1/%2.ts',
        },
        -- init.lua from any plugin configuration
        {
          pattern = '/lua/configs/.*.lua$',
          target = '/init.lua',
        },
        -- `default.nix` from module in the same directory
        {
          pattern = '(.*)/.*.nix',
          target = '%1/default.nix',
        },
        {
          context = 'mod.rs',
          pattern = '(.*)/.*.rs',
          target = '%1/mod.rs',
        },
      },
    })
  end
}

return { 'tpope/vim-surround',
  keys = {
    {'n', 's'},
    {'n', 'S'},
    {'n', 'ds'},
    {'n', 'cs'},
    {'x', 's'},
    {'x', 'S'},
  },
  setup = function()
    local map = require('utils').map

    -- Noun `r` means `]`
    map({'o', 'x'}, 'ir', 'i]', { remap = true })
    map({'o', 'x'}, 'ar', 'a]', { remap = true })

    -- Noun `q` means `'`
    map({'o', 'x'}, 'iQ',  'i"',  { remap = true })
    map({'o', 'x'}, 'aQ',  'a"',  { remap = true })

    -- Noun `A` means `
    map({'o', 'x'}, 'iA',  'i`',  { remap = true })
    map({'o', 'x'}, 'aA',  'a`',  { remap = true })
  end,
  config = function ()
    local map = require('utils').map

    map('x', 's', '<Plug>VSurround')
    map('x', 'S', '<Plug>VgSurround')
    map('n', 's', 'ys',  { remap = true })
    map('n', 'S', 'ys$', { remap = true })

    -- Surround noun `q` means `'`
    map('n',        'csq', "cs'", { remap = true })
    map('n',        'dsq', "ds'", { remap = true })
    -- Surround noun `q` already means any quotes i.e. `/"/'
    vim.cmd [[ let g:surround_{char2nr('q')} = "'\r'" ]]

    -- Surround noun `Q` means `"`
    map('n',        'csQ', 'cs"', { remap = true })
    map('n',        'dsQ', 'ds"', { remap = true })
    vim.cmd [[ let g:surround_{char2nr('Q')} = '"\r"' ]]

    -- Surround noun `A` means `
    map('n',        'csA', 'cs`', { remap = true })
    map('n',        'dsA', 'ds`', { remap = true })
    vim.cmd [[ let g:surround_{char2nr('A')} = "`\r`" ]]
  end
}

-------------
-- Keymaps --
-------------
local bo, o, wo, v, fn = vim.bo, vim.o, vim.wo, vim.v, vim.fn
local utils = require('utils')
local map, feedkeys = utils.map, utils.feedkeys

-- Leader --
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
map('n', '<S-Space>', '<Space>')

map('n',        'yp',            'yyp')
map({'n', 'v'}, '<leader>y',     '"+y')
map('n',        '<leader>Y',     '"+y$')
map('n',        '<leader>D',     '"+D')
map({'n', 'v'}, '<leader>p',     '"+p')
map({'n', 'v'}, '<leader>P',     '"+P')
map('!',        '<M-v>',         '<C-r>+')
map({'n', 'v'}, '<C-q>',         ':qa<CR>')
map('n',        '<C-j>',         'o<Esc>')
map('n',        '<C-j>',         'i<CR><Esc>')
map('n',        '<C-k>',         'O<Esc>')
map('n',        'g<C-k>',        'DO<Esc>P_')
map('n',        'gK',             'kjddkPJ<C-y>')
map('n',        '<C-s>',         ':w<CR>', {silent = true})
map({'i', 's'}, '<C-s>',         '<Esc>:w<CR>', {silent = true})
map('v',        '<C-s>',         '<Esc>:w<CR>gv', {silent = true})
map('s',        '<C-h>',         '<BS>')
map('x',        'v',             '$h')
map('n',        '<BS>',          'X')
map('n',        '<M-BS>',        'db')
map({'i', 'c'}, '<M-BS>',        '<C-w>')
map('!',        '<M-p>',         '<C-r>"')
map('s',        '<M-p>',         '<C-g>pgv<C-g>')
map('!',        '<C-f>',         '<Right>')
map('!',        '<M-f>',         '<C-Right>')
map('!',        '<C-b>',         '<Left>')
map('!',        '<M-l>',         '<Right>')
map('!',        '<M-h>',         '<Left>')
map('s',        '<M-l>',         '<Esc><Right>i')
map('s',        '<M-h>',         '<Esc><Left>i')
map('c',        '<C-p>',         '<Up>')
map('c',        '<C-n>',         '<Down>')
map('c',        '<C-q>',         '<Esc>')
map('!',        '<M-b>',         '<C-Left>')
map('!',        '<M-w>',         '<C-Right>')
map('c',        '<C-a>',         '<Home>')
map('n',        '<M-j>',         ':m      .+1<CR>==')
map('n',        '<M-k>',         ':m      .-2<CR>==')
map('x',        '<M-j>',         ":m      '>+1<CR>gv=gv")
map('x',        '<M-k>',         ":m      '<-2<CR>gv=gv")
map('i',        '<M-j>',         '<Esc>:m .+1<CR>==gi')
map('i',        '<M-k>',         '<Esc>:m .-2<CR>==gi')
map('n',        '<C-w>T',        ':tab    split<CR>')
map('n',        '<C-w>C',        ':tabclose<CR>')
map('n',        '<leader>wn',    ':tab    split<CR>')
map('n',        '<leader>wc',    ':tabclose<CR>')
map('n',        '<leader>wo',    ':tabonly<CR>')
map('n',        '<leader>wl',    ':tabnext<CR>')
map('n',         '<leader>wh',  ':tabprevious<CR>')
map('n',        '<Leader><Esc>', '<Nop>')
map('n',        '<leader>i',     ':source ~/.config/nvim/init.lua<CR>')
map('n',        '<leader>I',     ':drop   ~/.config/nvim/init.lua<CR>')
map('n',        '<leader>V',     ':drop   ~/.config/nvim/config.vim<CR>')
map('n',        '<leader>Z',     ':drop   ~/.zshrc<CR>')
map('n',        'gX',            ':exec   "silent !brave %:p &"<CR>')
map('x',        '//',            'omsy/<C-R>"<CR>`s')
map('n',        '/',             'ms/')
map('n',        '*',             'ms*')
map('n',        'g*',            'msg*`s')
map('n',        '<leader>*',     'ms*`s')
map('n',        '<leader>g*',    'msg*`s')
map('n',        '#',             'ms#')
map('n',        'g#',            'msg#`s')
map('n',        '`/',            '`s')
map('n',        'g/',             '/\\<\\><Left><Left>')
map('n',        '<leader>R',     ':%s/<C-R><C-W>//gci<Left><Left><Left><Left>')
map({'n', 'x'}, '<leader>q',     'qqqqq')
map({'n', 'x'}, 'Q',             '@@')
map('n',        'cg*',           '*Ncgn')
map('n',        'dg*',           '*Ndgn')
map('v',        'gcn',           '//Ncgn')
map('v',        'gdn',           '//Ndgn')
map('n',        'g.',            '/\\V\\C<C-R>"<CR>cgn<C-a><Esc>')
map('x',        'g.',            '.')

map('n', '<leader>z', function()
  wo.spell = true
  feedkeys('1z=')
  wo.spell = false
end)
map('n', ']s', function()
  wo.spell = true
  feedkeys(']s')
end)
map('n', '[s', function()
  wo.spell = true
  feedkeys('[s')
end)

-- ;/, always seach forwards/backwards, respectively
map({'n', 'x'}, ';', function()
  if fn.getcharsearch().forward == 1 then
    feedkeys(';')
  else
    feedkeys(',')
  end
end)
map({'n', 'x'}, ',', function()
  if fn.getcharsearch().forward == 1 then
    feedkeys(',')
  else
    feedkeys(';')
  end
end)

map('n', '<leader>K',        ':vertical Man <C-R><C-W><CR>')
map('x', '<leader>K',        'y:vertical Man <C-R>"<CR>')

map({'n', 'v'}, 'g)',        'w)ge')
map({'n', 'v'}, 'g(',        '(ge')
map('o',        'g)',        ':silent normal vg)h<CR>')
map('o',        'g(',        ':silent normal vg(oh<CR>')
map({'n', 'v'}, '<leader>S', ':setlocal spell!<CR>')
map('n',        '<C-W>N',    ':tabe<CR>')

-- Adds previous cursor location to jumplist if count is > 5
local function move_vertically(direction)
  local mark = v.count > 5 and "m'" or ""
  feedkeys(mark .. v.count1 .. direction)
end

map('n', 'k', function() move_vertically('k') end, 'k')
map('n', 'j', function() move_vertically('j') end, 'j')

-- Sets the font size
local function zoom_set(font_size)
  return function()
    if fn.exists('g:goneovim') then
      o.guifont = fn.substitute(
        fn.substitute(o.guifont, ':h\\d\\+', ':h' .. font_size, ''),
        ' ',
        '\\ ',
        'g'
      )
    else
      local font = fn.substitute(o.guifont, ':h\\d\\+', ':h' .. font_size, '')
      vim.cmd('GuiFont! ' .. font)
    end
  end
end

-- Increases the font zise with `amount`
local function zoom(amount)
  return function()
    zoom_set(fn.matchlist(o.guifont, ':h\\(\\d\\+\\)')[2] + amount)()
  end
end

map('n', '<C-=>', zoom(v.count1))
map('n', '<C-+>', zoom(v.count1))
map('n', '<C-->', zoom(-v.count1))
map('n', '<C-0>', zoom_set(11))

map('n', '<C-w><C-n>', '<cmd>vnew<CR>')
map('s', '<BS>', '<BS>a') -- By default <BS> puts you in normal mode
map({'n', 'i', 'v', 's', 'o', 't'}, '<C-m>', '<CR>', { remap = true })
map({'i', 'c'}, '<C-i>', '<Tab>', { remap = true })
map('n', 'g<C-a>', 'v<C-a>', 'Increment number under cursor')
map('n', 'g<C-x>', 'v<C-x>', 'Decrement number under cursor')
map('s', '<C-r>', '<C-g>c<C-r>', 'Insert content of a register')

map('n', '<leader><C-t>', function()
  bo.bufhidden = 'delete'
  feedkeys('<C-t>')
end, 'Delete buffer and pop jump stack')
map('n', '<leader>N', function()
  o.relativenumber = not o.relativenumber
  print('Relative line numbers ' .. (o.relativenumber and 'enabled' or 'disabled'))
end, 'Toggle relative line numbers')
map('n', '<leader>W', function()
  vim.wo.wrap = not vim.wo.wrap
  print('Line wrap ' .. (vim.wo.wrap and 'enabled' or 'disabled'))
end, 'Toggle line wrap')

map('n', '<Esc>', function()
  utils.close_floating_windows()
  if bo.modifiable then
    utils.clear_lsp_references()
  else
    return feedkeys('<C-w>c')
  end
end, 'Close window if not modifiable, otherwise clear LSP references')
map('t', '<Esc>', '<C-\\><C-n>')
map('n', '<C-l>', '<cmd>LuaSnipUnlinkCurrent<CR><C-l>')

map({'n', 'v'}, '<C-y>', '5<C-y>')
map({'n', 'v'}, '<C-e>', '5<C-e>')

-- Packer
map('n', '<leader>ku', '<cmd>PackerUpdate<CR>')
map('n', '<leader>kc', '<cmd>PackerCompile<CR>')
map('n', '<leader>kC', '<cmd>PackerCompile<CR>')
map('n', '<leader>ks', '<cmd>PackerSync<CR>')
map('n', '<leader>kS', '<cmd>PackerStatus<CR>')
map('n', '<leader>ki', '<cmd>PackerInstall<CR>')
map('n', '<leader>kp', '<cmd>PackerProfile<CR>')

vim.api.nvim_create_augroup('CmdWinMaps', {})
vim.api.nvim_create_autocmd('CmdwinEnter', {
  callback = function()
    map('n', '<CR>',  '<CR>',   { buffer = true })
    map('n', '<Esc>', '<C-w>c', { buffer = true })
  end,
  group = 'CmdWinMaps'
})

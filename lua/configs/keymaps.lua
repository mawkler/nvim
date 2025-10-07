-------------
-- Keymaps --
-------------
local bo, o, wo, v, fn = vim.bo, vim.o, vim.wo, vim.v, vim.fn
local utils = require('utils')
local map = utils.map
local feedkeys, feedkeys_count = utils.feedkeys, utils.feedkeys_count
local nx = { 'n', 'x' }

-- Leader --
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
map('n', '<S-Space>', '<Space>')

map({ 'n', 'v' }, '<C-q>',  ':qa<CR>')
map('n',          '<C-j>',  'o<Esc>')
map('n',          '<C-k>',  'O<Esc>')
map('i',          '<C-j>',  '<C-o>o')
map('i',          '<C-k>',  '<C-o>O')
map('n',          'g<C-k>', 'DO<Esc>P_')
map('n',          'gK',     'kjddkPJ<C-y>')
map('n',          '<C-s>',  ':w<CR>',        { silent = true })
map({ 'i', 's' }, '<C-s>',  '<Esc>:w<CR>',   { silent = true })
map('x',          '<C-s>',  '<Esc>:w<CR>gv', { silent = true })

map('x',          'v',      '$h')
map('n',          '<BS>',   'X')
map('n',          '<M-BS>', 'db')
map({ 'i', 'c' }, '<M-BS>', '<C-w>')
map('!',          '<C-f>',  '<Right>')
map('!',          '<M-f>',  '<C-Right>')
map('!',          '<C-b>',  '<Left>')
map('!',          '<M-l>',  '<Right>')
map('!',          '<M-h>',  '<Left>')
map('s',          '<M-l>',  '<Esc><Right>i')
map('s',          '<M-h>',  '<Esc><Left>i')
map('c',          '<C-p>',  '<Up>')
map('c',          '<C-n>',  '<Down>')
map('c',          '<C-q>',  '<Esc>')
map('!',          '<M-b>',  '<C-Left>')
map('!',          '<M-w>',  '<C-Right>')
map('c',          '<C-a>',  '<Home>')
map('n',          '<M-j>',  ':m      .+1<CR>==')
map('n',          '<M-k>',  ':m      .-2<CR>==')
map('x',          '<M-j>',  ":m      '>+1<CR>gv=gv")
map('x',          '<M-k>',  ":m      '<-2<CR>gv=gv")
map('i',          '<M-j>',  '<Esc>:m .+1<CR>==gi')
map('i',          '<M-k>',  '<Esc>:m .-2<CR>==gi')
map('n',          '<C-w>C', ':tabclose<CR>')
map('n',          '<C-c>',  '<Nop>') -- Allow <C-w><C-c>

map('n', '<leader>wn',    ':tab split<CR>')
map('n', '<leader>wc',    ':tabclose<CR>')
map('n', '<leader>wo',    ':tabonly<CR>')
map('n', '<leader><Esc>', '<Nop>')
map('n', '<leader>I',     ':edit ~/.config/nvim/init.lua<CR>')
map('n', '<leader>Z',     ':edit ~/.zshrc<CR>')

map('n', 'gX',         ':exec "silent !brave \'%:p\' &"<CR>')
map('x', '//',         'omsy/<C-R>"<CR>`s')
map('n', '/',          'ms/',                                         { silent = false })
map('n', '*',          'ms*')
map('n', 'g*',         'msg*`s')
map('n', '<leader>*',  'ms*`s')
map('n', '<leader>g*', 'msg*`s')
map('n', '#',          'ms#')
map('n', 'g#',         'msg#`s')
map('n', '`/',         '`s')
map('n', 'g/',         '/\\<\\><Left><Left>')
map('n', '<leader>R',  ':%s/<C-R><C-W>//gci<Left><Left><Left><Left>')
map(nx,  '<leader>q',  'qqqqq')
map(nx,  'Q',          '@@')
map('n', 'cg*',        '*Ncgn')
map('n', 'dg*',        '*Ndgn')
map('x', 'gcn',        '//Ncgn')
map('x', 'gdn',        '//Ndgn')
map('n', 'g.',         '/\\V\\C<C-R>"<CR>cgn<C-a><Esc>')
map('x', 'g.',         '.')

map(nx, '[y', '`[', 'First character of latest yank')
map(nx, ']y', '`]', 'Last character of latest yank')
map(nx, '[v', '`<', 'First character of latest visual select')
map(nx, ']v', '`>', 'Last character of latest visual select')

map('o', '}',     'V}')
map('o', '{',     'V{')
map('i', '<C-;>', '<Esc>m0A;<Esc>`0a')
map('i', '<C-,>', '<Esc>m0A,<Esc>`0a')
map('s', '<C-;>', '<Esc>A;<Esc>gv<C-g>', { remap = false })
map('s', '<C-,>', '<Esc>A,<Esc>gv<C-g>', { remap = false })

map('n', '<leader>K', ':vertical Man <C-R><C-W><CR>')
map('x', '<leader>K', 'y:vertical Man <C-R>"<CR>')

map(nx,  'g)', 'w)ge')
map(nx,  'g(', '(ge')
map('o', 'g)', ':silent normal vg)h<CR>')
map('o', 'g(', ':silent normal vg(oh<CR>')
map(nx,  'sP', ':setlocal spell!<CR>',     'Toggle spell check')

-- Adds previous cursor location to jumplist if count is > 5
local function move_vertically(direction)
  return function()
    local mark = v.count > 5 and "m'" or ''
    feedkeys(mark .. v.count1 .. direction)
  end
end

map('n', 'k', move_vertically('k'), 'k')
map('n', 'j', move_vertically('j'), 'j')
map('n', '-', move_vertically('-'), 'k')
map('n', '+', move_vertically('+'), 'j')

local float_regex = '\\d\\+\\.\\?\\d*'

-- Sets the font size
local function zoom_set(font_size)
  return function()
    o.guifont = fn.substitute(o.guifont, ':h' .. float_regex, ':h' .. font_size, '')
  end
end

-- Increases the font zise with `amount`
local function zoom(amount)
  return function()
    local old_size = fn.matchlist(o.guifont, ':h\\(' .. float_regex .. '\\)')[2]
    zoom_set(old_size + amount)()
  end
end

local all_modes = { 'n', 'i', 'v', 's', 'o', 't' }

map('n', '<C-=>', zoom(v.count1 * 1))
map('n', '<C-+>', zoom(v.count1 * 1))
map('n', '<C-->', zoom(-v.count1 * 1))
map('n', '<C-0>', zoom_set(11))
map('n', '<C-)>', zoom_set(11))

map('n', '<C-w><C-n>', '<cmd>vnew<CR>')
map('n', '<C-w><C-^>', '<C-w>v<C-6>')
map('n', '<C-w>6',     '<C-w>v<C-6>')

map('s',       '<BS>',   '<BS>i') -- By default <BS> puts you in normal mode
map('s',       '<C-h>',  '<BS>i')
map(all_modes, '<C-m>',  '<CR>',        { remap = true })
map('n',       'g<C-a>', 'v<C-a>',      'Increment number under cursor')
map('n',       'g<C-x>', 'v<C-x>',      'Decrement number under cursor')
map('s',       '<C-r>',  '<C-g>c<C-r>', 'Insert content of a register')

map('n', '<leader><C-t>', function()
  bo.bufhidden = 'delete'
  feedkeys('<C-t>')
end, 'Delete buffer and pop jump stack')
map('n', '<leader>N', function()
  o.relativenumber = not o.relativenumber
  vim.notify('Relative line numbers ' .. (o.relativenumber and 'enabled' or 'disabled'))
end, 'Toggle relative line numbers')
map('n', '<leader>W', function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify('Line wrap ' .. (vim.wo.wrap and 'enabled' or 'disabled'))
end, 'Toggle line wrap')

map('n', '<Esc>', function()
  local exists, refjump_hl = pcall(require, 'refjump.highlight')
  if exists then
    refjump_hl.disable()
  end

  if vim.v.hlsearch == 1 then
    vim.cmd.nohlsearch()
  elseif bo.modifiable then
    utils.clear_lsp_references()
  elseif #vim.api.nvim_list_wins() > 1 then
    return feedkeys('<C-w>c')
  end

  vim.cmd.fclose({ bang = true })
end, 'Close window if not modifiable, otherwise clear LSP references')
map('t', '<Esc>', '<C-\\><C-n>')

local function clear_screen()
  -- Dismiss all notifcatcions on screen
  require('notify').dismiss({ pending = true, silent = true })

  -- Clear LuaSnip indicator from status line
  if require('luasnip').in_snippet() then
    require('luasnip').unlink_current()
  end
  feedkeys('<C-l>')
end
map('n', '<C-l>', clear_screen, { silent = true })

map(nx, '<C-y>', '5<C-y>')
map(nx, '<C-e>', '5<C-e>')

vim.api.nvim_create_augroup('CmdWinMaps', {})
vim.api.nvim_create_autocmd('CmdwinEnter', {
  callback = function()
    map('n', '<CR>',  '<CR>',   { buffer = true })
    map('n', '<Esc>', '<C-w>c', { buffer = true })
  end,
  group = 'CmdWinMaps'
})

-------------
-- Luasnip --
-------------

local fn = vim.fn
local feedkeys = require('../utils').feedkeys
local map = require('../utils').map

local luasnip = require('luasnip')
local s = luasnip.snippet
local sn = luasnip.snippet_node
local tn = luasnip.text_node
local i = luasnip.insert_node
local d = luasnip.dynamic_node

luasnip.config.setup { history = true }
luasnip.filetype_extend('all', {'global'})
require('luasnip/loaders/from_vscode').lazy_load {
  paths = {
    '~/.local/share/nvim/site/pack/packer/start/friendly-snippets/',
    '~/.config/nvim/snippets'
  }
}

local function clipboad_oneline_node()
  local clipboard, _ = fn.getreg('+'):gsub('\n', ' ')
  return clipboard
end

local luasnip_clipboard = function()
  return sn(nil, i(1, clipboad_oneline_node()))
end

local luasnip_use = function()
  local repo, _ = clipboad_oneline_node():gsub('.*github.com/([^/]*/[^/]*).*', '%1', 1)
  return sn(nil,  i(1, repo) )
end

luasnip.add_snippets('markdown', {
  s({
    trig = 'link',
    name = 'hyperlink',
    dscr = 'Hyperlink with the content in the clipboard'
  }, {
    tn '[', i(1, 'text'), tn ']',
    tn '(',
    d(2, luasnip_clipboard),
    tn ') ',
  })
})
luasnip.add_snippets('lua', {
  s({
    trig = 'use',
    name = 'Add plugin',
    dscr = 'Add packer.nvim plugin from the clipboard'
  }, {
    tn "use '", d(1, luasnip_use), tn "'",
  })
})

local function right_or_snip_next()
  if luasnip.in_snippet() and luasnip.jumpable(1) then
    luasnip.jump(1)
  elseif fn.mode() == 'i' then
    feedkeys('<Right>')
  end
end

local function left_or_snip_prev()
  if luasnip.in_snippet() and luasnip.jumpable(-1) then
    luasnip.jump(-1)
  elseif fn.mode() == 'i' then
    feedkeys('<Left>')
  end
end


local function toggle_active_choice()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end

map({'i', 's'}, '<M-l>',     right_or_snip_next,   '<Right> or next snippet')
map({'i', 's'}, '<M-h>',     left_or_snip_prev,    '<Left> or previous snippet')
map({'i', 's'}, '<M-space>', toggle_active_choice, 'Toggle active snippet choice')


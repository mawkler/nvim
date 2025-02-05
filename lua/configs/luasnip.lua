-------------
-- LuaSnip --
-------------
return {
  'L3MON4D3/LuaSnip',
  run = 'make install_jsregexp',
  dependencies = 'mireq/luasnip-snippets', -- Collection of snippets
  event = 'InsertEnter',
  config = function()
    local fn            = vim.fn
    local feedkeys, map = require('utils').feedkeys, require('utils').map

    local luasnip             = require('luasnip')
    local snippets_snip_utils = require('luasnip_snippets.common.snip_utils')
    local s, sn               = luasnip.snippet, luasnip.snippet_node
    local t, i, d             = luasnip.text_node, luasnip.insert_node, luasnip.dynamic_node

    luasnip.config.setup({ history = true })
    snippets_snip_utils.setup()

    luasnip.setup({
      load_ft_func = snippets_snip_utils.load_ft_func,
      ft_func = snippets_snip_utils.ft_func,
    })

    luasnip.filetype_extend('all', { 'global' })
    require('luasnip.loaders.from_vscode').load({
      paths = { '~/.config/nvim/snippets' },
    })

    local function clipboard_oneline_node()
      local clipboard, _ = fn.getreg('+'):gsub('\n', ' ')
      return clipboard
    end

    local luasnip_clipboard = function()
      return sn(nil, i(1, clipboard_oneline_node()))
    end

    local plugin_repo_snippet = function()
      local repo, _ = clipboard_oneline_node():gsub('.*github.com/([^/]*/[^/]*).*', '%1', 1)
      return sn(nil, i(1, repo))
    end

    local function uuid()
      local id, _ = vim.fn.system('uuidgen'):gsub('\n', '')
      return id
    end

    luasnip.add_snippets('global', {
      s({
        trig = 'uuid',
        name = 'UUID',
        dscr = 'Generate a unique UUID'
      }, {
        d(1, function() return sn(nil, i(1, uuid())) end)
      })
    })
    luasnip.add_snippets('markdown', {
      s({
        trig = 'link',
        name = 'hyperlink',
        dscr = 'Hyperlink with the content in the clipboard'
      }, {
        t '[', i(1, 'text'), t ']',
        t '(', d(2, luasnip_clipboard), t ') ',
      })
    })
    luasnip.add_snippets('lua', {
      s({
        trig = 'plugin',
        name = 'Add plugin config',
        dscr = 'Add plugin URL from the clipboard'
      }, {
        t { 'return {', "\t'" },
        d(1, plugin_repo_snippet), t "',",
        t { '', '\tconfig = function()', '\t\t' },
        i(2),
        t { '', '\tend', '}' }
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

    local is = { 'i', 's' }

    map(is, '<M-S-l>', right_or_snip_next,   '<Right> or next snippet')
    map(is, '<M-S-h>', left_or_snip_prev,    '<Left> or previous snippet')
    map(is, '<M-.>',   right_or_snip_next,   '<Right> or next snippet')
    map(is, '<M-,>',   left_or_snip_prev,    '<Left> or previous snippet')
    map(is, '<M-t>',   toggle_active_choice, 'Toggle active snippet choice')
    map(is, '<C-y>',   luasnip.expand,       'Expand snippet')
  end
}

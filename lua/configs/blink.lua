-----------
-- Blink --
-----------
local function toggle(cmp)
  if cmp.is_menu_visible() then
    cmp.hide()
  else
    cmp.show()
  end
end

local show_snippets = function(cmp)
  cmp.show({ providers = { 'snippets' } })
end

return {
  'saghen/blink.cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'xzbdmw/colorful-menu.nvim',
    { 'Kaiser-Yang/blink-cmp-git', dependencies = { 'nvim-lua/plenary.nvim' } },
  },
  version = '*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    require('blink-cmp').setup({
      keymap = {
        preset = 'default',
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-i>'] = { 'accept', 'fallback' },
        ['<M-.>'] = { 'snippet_forward', 'fallback' },
        ['<M-,>'] = { 'snippet_backward', 'fallback' },
        ['<C-space>'] = { toggle },
        ['<C-/>'] = { show_snippets, 'fallback' },
        ['<C-y>'] = {}, -- Used to trigger snippets
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'normal',
        kind_icons = require('utils.icons').icons,
      },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'git', 'path', 'snippets', 'buffer', 'lazydev' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
          },
          git = {
            module = 'blink-cmp-git',
            name = 'Git',
            enabled = function()
              local whitelist = { 'gitcommit', 'markdown', 'octo' }
              return vim.tbl_contains(whitelist, vim.bo.filetype)
            end,
          },
        },
      },
      signature = {
        enabled = true,
        trigger = { enabled = true },
      },
      cmdline = {
        keymap = {
          preset = 'default',
          ['<C-j>'] = { 'select_next', 'fallback' },
          ['<C-k>'] = { 'select_prev', 'fallback' },
          ['<C-i>'] = { 'accept', 'fallback' },
        },
        completion = {
          menu = { auto_show = true },
        },
      },
      completion = {
        menu = {
          max_height = 50,
          draw = {
            columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require('colorful-menu').blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require('colorful-menu').blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          update_delay_ms = 50,
        },
      },
    })

    -- Ghost text highlight
    local comment_fg = require('utils.colors').get_highlight('Comment')
    vim.api.nvim_set_hl(0, 'BlinkCmpGhostText', { fg = comment_fg, default = true })
  end,
}

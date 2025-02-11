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
  dependencies = { 'L3MON4D3/LuaSnip', 'xzbdmw/colorful-menu.nvim' },
  version = '*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-i>'] = { 'accept', 'fallback' },
      ['<M-.>'] = { 'snippet_forward', 'fallback' },
      ['<M-,>'] = { 'snippet_backward', 'fallback' },
      ['<C-space>'] = { toggle },
      ['<C-/>'] = { show_snippets, 'fallback' },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'normal',
      kind_icons = require('utils.icons').icons,
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    signature = {
      enabled = true,
      trigger = {
        enabled = true,
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
        update_delay_ms = 0,
      },
    },
  },
}

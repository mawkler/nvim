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

local menu_max_height = 25

-- tiny-cmdline anchors the menu to the bottom border of its popup, so anchor
-- it to the top border (0-indexed) instead when the menu opens above
local function cmdline_anchor()
  local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed bottom border, set by tiny-cmdline
  if vim.api.nvim_get_mode().mode ~= 'c' or pos == nil then return end
  local top = vim.api.nvim_win_get_config(require('vim._core.ui2').wins.cmd).row
  local below = math.min(vim.o.lines - pos[1], menu_max_height)
  local above = math.min(top, menu_max_height)
  if below >= above then return 's', { pos[1] - 1, pos[2] } end
  return 'n', { top, pos[2] }
end

return {
  'saghen/blink.cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'xzbdmw/colorful-menu.nvim',
    'folke/lazydev.nvim',
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
          buffer = {
            max_items = 5,
            min_keyword_length = 3,
            async = true,
          },
          snippets = {
            max_items = 5,
            async = true,
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
          max_height = menu_max_height,
          border = 'none',
          -- LuaLS misparses blink.cmp's `fun(): ("n" | "s")[]` annotation
          ---@diagnostic disable-next-line: assign-type-mismatch
          direction_priority = function()
            local direction = cmdline_anchor()
            return direction and { direction } or { 's', 'n' }
          end,
          cmdline_position = function()
            local _, anchor = cmdline_anchor()
            if anchor then return anchor end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
          end,
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

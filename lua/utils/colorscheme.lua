local colors = require('onedark').get_colors()

local function hex_from_decimal(decimal)
  local hex = string.format('%x', decimal)
  return '#' .. hex
end

--- Gets the foreground color value of `group`.
--- @param group string
--- @return string
local function get_highlight_fg(group)
  local color = vim.api.nvim_get_hl_by_name(group, true).foreground
  return hex_from_decimal(color)
end

--- Assumes that a highlight group for `mode` exists, e.g. NormalMode,
--- VisualMode, InsertMode, etc.
--- @param mode string
--- @return string
local function get_mode_color(mode)
  return get_highlight_fg(mode .. 'mode')
end

--- Disable `@lsp.type.variable` because it overrides Treesitter's highlights
--- for "builtins" such as `vim`
vim.api.nvim_set_hl(0, '@lsp.type.variable', {})

-- Use different highlights for special keys in cmdline vs other windows
vim.opt.winhighlight = 'SpecialKey:SpecialKeyWin'

return {
  colors = colors,
  modes = {
    normal  = colors.green0,
    insert  = colors.blue0,
    visual  = colors.purple0,
    command = colors.red0,
    select  = colors.cyan0,
    replace = colors.red2,
    term    = colors.green0,
  },
  get_highlight_fg = get_highlight_fg,
  get_mode_color = get_mode_color,
}

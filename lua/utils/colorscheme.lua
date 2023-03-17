local colors = require('onedark').get_colors()

--- Gets the foreground color value of `group`.
--- @param group string
--- @return string
local function get_highlight_fg(group)
  return vim.api.nvim_get_hl_by_name(group, true).foreground
end

-- Disable `@lsp.type.variable` because it overrides Treesitter's highlights
-- for "builtins" such as `vim`
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
  -- Names of all colorschemes, to be used by Packer's `after`/`wants`
  colorscheme_names = { 'mawkler/onedark.nvim' },
  get_highlight_fg = get_highlight_fg
}

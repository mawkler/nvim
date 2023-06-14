local function hex_from_decimal(decimal)
  return string.format('#%x', decimal)
end

--- Gets the foreground or background color value of a highlight group. Returns
--- white if - the group doesn't exist.
--- @param group_name string
--- @param part 'fg'|'bg'
--- @return string
local function get_highlight(group_name, part)
  part = part or 'fg'
  local hl = vim.api.nvim_get_hl(0, { name = group_name, link = false })

  if vim.tbl_isempty(hl) or not hl[part] then
    local message = string.format(
      "Highlight group %s doesn't exist or has no %s part",
      group_name,
      part
    )
    vim.notify(message, vim.log.levels.WARN)
    return '#ffffff'
  end
  return hex_from_decimal(hl[part])
end

--- Assumes that a highlight group for `mode` exists, e.g. NormalMode,
--- VisualMode, InsertMode, etc.
--- @param mode string
--- @return string|nil
local function get_mode_color(mode)
  return get_highlight(mode .. 'mode')
end

--- Disable `@lsp.type.variable` because it overrides Treesitter's highlights
--- for "builtins" such as `vim`
vim.api.nvim_set_hl(0, '@lsp.type.variable', {})

-- Use different highlights for special keys in cmdline vs other windows
vim.opt.winhighlight = 'SpecialKey:SpecialKeyWin'

local function get_default_feline_highlights()
  return {
    fg           = '#c8ccd4',
    dark_text    = '#9ba1b0',
    -- line_bg   = get_highlight('Cursorline', 'bg'), -- TODO: use only in fallback
    line_bg      = '#353b45',
    bg           = get_highlight('NvimTreeNormal', 'bg'),
    middle_bg    = get_highlight('NvimTreeNormal', 'bg'),
    separator_bg = get_highlight('Normal', 'bg'),
    snippet      = get_highlight('CmpItemKindSnippet'),
    git_add      = get_highlight('GitSignsAdd'),
    git_change   = get_highlight('GitSignsChange'),
    git_remove   = get_highlight('GitSignsDelete'),
    hint         = get_highlight('LspDiagnosticsHint'),
    warning      = get_highlight('LspDiagnosticsWarning'),
    error        = get_highlight('LspDiagnosticsError'),
    info         = get_highlight('LspDiagnosticsInformation'),
  }
end

local function set_feline_theme(theme_name)
  local feline = require('feline')
  local theme = require('feline.themes')[theme_name]

  feline.vi_mode_colors = require('statusline').mode_colors()

  if theme then
    feline.use_theme(theme_name)
  else
    feline.use_theme(get_default_feline_highlights())
  end
end

local augroup = vim.api.nvim_create_augroup('Colorscheme', {})
vim.api.nvim_create_autocmd('Colorscheme', {
  group = augroup,
  callback = function(event)
    if pcall(require, 'feline') then
      local theme_name = event.match
      set_feline_theme(theme_name)
    end

    vim.g.highlighturl_guifg = get_highlight('@text.uri')
  end,
})

return {
  get_default_feline_highlights = get_default_feline_highlights,
  get_highlight = get_highlight,
  get_mode_color = get_mode_color,
}

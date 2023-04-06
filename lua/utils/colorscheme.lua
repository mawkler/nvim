local function hex_from_decimal(decimal)
  local hex = string.format('%x', decimal)
  return '#' .. hex
end

--- Gets the foreground or background color value of `group`.
--- @param group string
--- @param part 'fg'|'bg'
--- @return string
local function get_highlight(group, part)
  local _part = part == 'bg' and 'background' or 'foreground'
  local color = vim.api.nvim_get_hl_by_name(group, true)[_part]
  return hex_from_decimal(color)
end

--- Assumes that a highlight group for `mode` exists, e.g. NormalMode,
--- VisualMode, InsertMode, etc.
--- @param mode string
--- @return string
local function get_mode_color(mode)
  return get_highlight(mode .. 'mode')
end

--- Disable `@lsp.type.variable` because it overrides Treesitter's highlights
--- for "builtins" such as `vim`
vim.api.nvim_set_hl(0, '@lsp.type.variable', {})

-- Use different highlights for special keys in cmdline vs other windows
vim.opt.winhighlight = 'SpecialKey:SpecialKeyWin'

local function get_feline_highlights()
  return {
    fg = '#c8ccd4',
    dark_text = '#9ba1b0',
    -- line_bg = get_highlight('Cursorline', 'bg'), -- TODO: use only in fallback
    line_bg = '#353b45',
    bg = get_highlight('NvimTreeNormal', 'bg'),
    middle_bg = get_highlight('NvimTreeNormal', 'bg'),
    separator_bg = get_highlight('Normal', 'bg'),
    snippet = get_highlight('CmpItemKindSnippet'),
    git_add = get_highlight('GitSignsAdd'),
    git_change = get_highlight('GitSignsChange'),
    git_remove = get_highlight('GitSignsDelete'),
    hint = get_highlight('LspDiagnosticsHint'),
    warning = get_highlight('LspDiagnosticsWarning'),
    error = get_highlight('LspDiagnosticsError'),
    info = get_highlight('LspDiagnosticsInformation'),
    -- normal_mode = get_mode_color('normal'),
    -- insert_mode = get_mode_color('insert'),
    -- command_mode = get_mode_color('command'),
    -- visual_mode = get_mode_color('visual'),
    -- replace_mode = get_mode_color('replace'),
    -- term_mode = get_mode_color('term'),
    -- select_mode = get_mode_color('select'),
  }
end

local augroup = vim.api.nvim_create_augroup('Colorscheme', {})
vim.api.nvim_create_autocmd('Colorscheme', {
  group = augroup,
  callback = function(event)
    local colorscheme = event.match
    -- TODO: if theme is not recognized, just use a default theme that contains
    -- links onedark's highlights
    require('feline').use_theme(get_feline_highlights())
  end,
})

return {
  colors = {
    feline = {
      middle_bg = get_highlight('NvimTreeNormal', 'bg'),
      separator_bg = get_highlight('Normal', 'bg'),
      snippet = get_highlight('CmpItemKindSnippet'),
      git = {
        add = get_highlight('GitSignsAdd'),
        change = get_highlight('GitSignsChange'),
        delete = get_highlight('GitSignsDelete'),
      },
      diagnostics = {
        hint = get_highlight('LspDiagnosticsHint'),
        warning = get_highlight('LspDiagnosticsWarning'),
        error = get_highlight('LspDiagnosticsError'),
        info = get_highlight('LspDiagnosticsInformation'),
      },
    }
  },
  get_highlight = get_highlight,
  get_mode_color = get_mode_color,
}

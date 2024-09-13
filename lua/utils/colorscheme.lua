local colors = require('utils.colors')

local M = {}

--- Assumes that a highlight group for `mode` exists, e.g. NormalMode,
--- VisualMode, InsertMode, etc.
--- @param mode string
--- @return string | nil
function M.get_mode_color(mode)
  return colors.get_highlight(mode .. 'mode')
end

-- Use different highlights for special keys in cmdline vs other windows
vim.opt.winhighlight = 'SpecialKey:SpecialKeyWin'

function M.get_default_feline_highlights()
  return {
    fg           = '#c8ccd4',
    dark_text    = '#9ba1b0',
    -- line_bg   = get_highlight('Cursorline', 'bg'), -- TODO: use only in fallback
    line_bg      = '#353b45',
    bg           = colors.get_highlight('NvimTreeNormal', 'bg'),
    middle_bg    = colors.get_highlight('NvimTreeNormal', 'bg'),
    separator_bg = colors.get_highlight('Normal', 'bg'),
    snippet      = colors.get_highlight('CmpItemKindSnippet'),
    git_add      = colors.get_highlight('GitSignsAdd'),
    git_change   = colors.get_highlight('GitSignsChange'),
    git_remove   = colors.get_highlight('GitSignsDelete'),
    hint         = colors.get_highlight('LspDiagnosticsHint'),
    warning      = colors.get_highlight('LspDiagnosticsWarning'),
    error        = colors.get_highlight('LspDiagnosticsError'),
    info         = colors.get_highlight('LspDiagnosticsInformation'),
  }
end

local function set_feline_theme(theme_name)
  local feline = require('feline')
  local theme = require('feline.themes')[theme_name]

  feline.vi_mode_colors = require('statusline').mode_colors()

  if theme then
    feline.use_theme(theme_name)
  else
    feline.use_theme(M.get_default_feline_highlights())
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

    vim.g.highlighturl_guifg = colors.get_highlight('@text.uri')
  end,
})

return M

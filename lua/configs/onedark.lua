-------------
-- Onedark --
-------------
return { 'ful1e5/onedark.nvim', config = function()
  local colors = require('onedark.colors').setup()
  local style = require('onedark.types').od.HighlightStyle
  local onedark_utils = require('onedark.util')
  local plugin_setup = require('utils').plugin_setup

  local barbar_bg = '#1d2026'
  local barbar_bg_visible = '#23262d'
  local barbar_fg_gray = '#3b4048'

  plugin_setup('onedark', ({
    hide_end_of_buffer = false,
    dev = true,
    colors = {
      bg_search = colors.bg_visual,
      hint = colors.dev_icons.gray,
      -- bg_float = colors.bg_highlight,
      git = {
        add = colors.green0,
        change = colors.orange1,
        delete = colors.red1
      }
    },
    overrides = function(c)
      return {
        -- General
        Substitute = { link = 'Search' },
        Title = { fg = c.red0, style = style.Bold },
        Folded = { fg = c.fg_dark, bg = c.bg1 },
        FloatBorder = { fg = c.blue0, bg = c.bg_float  },
        Search = { bg = c.bg_search },
        SpecialKey = { fg = c.blue0 },
        SpecialKeyWin = { link = 'Comment' },
        IncSearch = { bg = c.blue0 },
        WinSeparator = { fg = barbar_bg, style = style.Bold  },
        MatchParen = { fg = nil, bg = nil, style = string.format('%s,%s', style.Bold, style.Underline) },
        CursorLineNr = { fg = c.blue0, bg = c.bg_highlight, style = style.Bold },
        MsgArea = { link = 'Normal' },
        SpellBad = { style = style.Undercurl, sp = c.red1 },
        -- Quickfix
        qfLineNr = { fg = c.fg_gutter },
        -- Treesitter
        TSTagDelimiter = { link = 'TSPunctBracket'},
        TSNote = { fg = c.info, style = style.Bold },
        TSWarning = { fg = c.warning, style = style.Bold },
        TSDanger = { fg = c.error, style = style.Bold },
        Todo = { link = 'TSWarning' },
        TSPunctSpecial = { fg = c.red0 },
        -- Markdown/html
        mkdLink = { fg = c.blue0, style = style.Underline },
        htmlBold = { fg = c.orange0, style = style.Bold },
        htmlItalic = { fg = c.purple0, style = style.Italic },
        mkdHeading = { link = 'Title' },
        -- Markdown (Treesitter)
        TSLiteral = { fg = c.green0 },
        TSEmphasis = { fg = c.purple0, style = style.Italic },
        TSStrong = { fg = c.orange0, style = style.Bold },
        -- TypeScript
        typescriptParens = { link = 'TSPunctBracket' },
        -- Git commit
        gitcommitOverflow = { link = 'Error' },
        gitcommitSummary = { link = 'htmlBold' },
        -- QuickScope
        QuickScopePrimary = { fg = c.red0, style = style.Bold },
        QuickScopeSecondary = { fg = c.orange1, style = style.Bold },
        -- NvimTree
        NvimTreeFolderName = { fg = c.blue0 },
        NvimTreeOpenedFolderName = { fg = c.blue0, style = style.Bold },
        NvimTreeOpenedFile = { style = style.Bold },
        NvimTreeGitDirty = { fg = c.orange1 },
        NvimTreeGitNew = { fg = c.green0 },
        NvimTreeGitIgnored = { fg = c.fg_dark },
        -- Telescope
        TelescopeMatching = { fg = c.blue0, style = style.Bold },
        TelescopePromptPrefix = { fg = c.fg0, style = style.Bold },
        -- LSP
        LspReferenceText = { link = 'Search' },
        LspReferenceRead = { link = 'Search' },
        LspReferenceWrite = { link = 'Search' },
        -- Diagnostics
        DiagnosticUnderlineError = { style = style.Underline, sp = c.error },
        DiagnosticUnderlineWarning = { style = style.Underline, sp = c.warning },
        DiagnosticUnderlineHint = { style = style.Underline, sp = c.hint },
        DiagnosticUnderlineInfo = { style = style.Underline, sp = c.info },
        -- nvim-cmp
        CmpItemAbbrDeprecatedDefault = { fg = onedark_utils.darken(c.fg0, 0.8) },
        CmpItemAbbrMatchFuzzy = { fg = c.fg0, style = style.Bold },
        CmpItemKindSnippetDefault = { fg = c.blue0 },
        CmpItemKindTextDefault = { link = 'Normal' },
        -- nvim-lsp-ts-utils
        NvimLspTSUtilsInlineHint = { fg = c.bg_visual }, -- this gets set too late, i.e. after nvim-lsp-ts-utils is loaded. Can be fixed with packer.nvim's `after`
        -- Gitsigns
        GitSignsDeleteLn = { link = 'GitSignsDeleteVirtLn' },
        -- Fidget
        FidgetTitle = { fg = c.blue0, style = style.Bold },
        -- Barbar
        BufferCurrentTarget  = { fg = c.blue0,        bg = c.bg0, style = style.Bold },
        BufferVisible        = { fg = c.fg0,          bg = barbar_bg_visible },
        BufferVisibleSign    = { fg = barbar_fg_gray, bg = barbar_bg_visible },
        BufferVisibleMod     = { fg = c.warning,      bg = barbar_bg_visible },
        BufferVisibleIndex   = { fg = barbar_fg_gray, bg = barbar_bg_visible },
        BufferVisibleTarget  = { fg = c.blue0,        bg = barbar_bg_visible, style = style.Bold  },
        BufferTabpageFill    = { fg = barbar_fg_gray, bg = barbar_bg },
        BufferTabpages       = { fg = c.blue0,        bg = barbar_bg, style = style.Bold },
        BufferInactive       = { fg = '#707070',      bg = barbar_bg },
        BufferInactiveSign   = { fg = barbar_fg_gray, bg = barbar_bg },
        BufferInactiveMod    = { fg = c.warning,      bg = barbar_bg },
        BufferInactiveTarget = { fg = c.blue0,        bg = barbar_bg, style = style.Bold },
        BufferInactiveIndex  = { fg = barbar_fg_gray, bg = barbar_bg },
        BufferModifiedIndex  = { fg = barbar_fg_gray, bg = barbar_bg },
        -- Grammarous
        GrammarousError = { style = style.Undercurl, sp = c.error },
        -- Scrollbar
        Scrollbar = { fg = c.bg_visual },
        -- Leap
        LeapMatch = { fg = c.orange0, style = string.format('%s,%s', style.Bold, style.Underline) },
        LeapLabelPrimary = { fg = c.green0, style = style.Bold },
        LeapLabelSecondary = { fg = c.red0 },
        LeapLabelSelected = { bg = c.bg_visual },
        LeapBackdrop = { fg = c.fg_dark },
        -- Alpha
        AlphaHeader = { fg = c.green0, style = style.Bold }
      }
    end
  }))

  -- Use different highlights for special keys in cmdline vs other windows
  vim.opt.winhighlight = 'SpecialKey:SpecialKeyWin'
end }

-------------
-- Onedark --
-------------
return { 'melkster/onedark.nvim', config = function()
  local colors = require('onedark.colors').setup()
  local style = require('onedark.types').od.HighlightStyle
  local onedark_utils = require('onedark.util')

  local barbar_bg = '#1d2026'
  local barbar_bg_visible = '#23262d'
  local barbar_fg_gray = '#3b4048'

  local cursorline_bg = '#2f343d'

  local treesitter_context_bg = '#252933'

  require('onedark').setup({
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
        CursorLine = { bg = cursorline_bg },
        CursorColumn = { link = 'CursorLine' },
        CursorLineNr = { fg = c.green0, bg = cursorline_bg, style = style.Bold },
        MsgArea = { link = 'Normal' },
        SpellBad = { style = style.Undercurl, sp = c.red1 },
        Todo = { link = '@text.warning' },
        -- Custom highlights
        InlineHint = { fg = c.bg_visual },
        LspCodeLens = { link = 'InlineHint' },
        LspCodeLensSeparator = { link = 'LspCodeLens' },
        -- Quickfix
        qfLineNr = { fg = c.fg_gutter },
        -- Treesitter
        ['@tag.delimiter'] = { link = 'TSPunctBracket' },
        ['@text.note'] = { fg = c.info, style = style.Bold },
        ['@text.warning'] = { fg = c.warning, style = style.Bold },
        ['@text.danger'] = { fg = c.error, style = style.Bold },
        -- Markdown (Treesitter)
        ['@text.literal'] = { fg = c.green0 },
        ['@text.emphasis'] = { fg = c.purple0, style = style.Italic },
        ['@text.strong'] = { fg = c.orange0, style = style.Bold },
        ['@punctuation.special'] = { fg = c.red0 },
        -- Markdown/html
        mkdLink = { fg = c.blue0, style = style.Underline },
        htmlBold = { fg = c.orange0, style = style.Bold },
        htmlItalic = { fg = c.purple0, style = style.Italic },
        mkdHeading = { link = 'Title' },
        -- TypeScript
        typescriptParens = { link = 'TSPunctBracket' },
        -- Git commit
        gitcommitOverflow = { link = 'Error' },
        gitcommitSummary = { link = 'htmlBold' },
        -- QuickScope
        QuickScopePrimary = { fg = c.red0, style = style.Bold },
        QuickScopeSecondary = { fg = c.orange1, style = style.Bold },
        -- Eyeliner
        EyelinerPrimary = { fg = c.red0, style = style.Bold },
        EyelinerSecondary = { fg = c.orange1, style = style.Bold },
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
        CmpItemAbbrMatch      = { fg = c.blue0, style = style.Bold },
        CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
        PmenuSel              = { fg = c.bg1, bg = c.blue0 },
        -- Gitsigns
        GitSignsDeleteLn = { link = 'GitSignsDeleteVirtLn' },
        GitSignsAdd = { fg = colors.green0 },
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
        Scrollbar = { fg = c.bg_visual, bg = c.bg_visual },
        -- Leap
        LeapMatch = { fg = c.orange0, style = string.format('%s,%s', style.Bold, style.Underline) },
        LeapLabelPrimary = { fg = c.green0, style = style.Bold },
        LeapLabelSecondary = { fg = c.red0 },
        LeapLabelSelected = { bg = c.bg_visual },
        LeapBackdrop = { fg = c.fg_dark },
        -- Alpha
        AlphaHeader = { fg = c.green0, style = style.Bold },
        -- Treesitter context
        TreesitterContext = { bg = treesitter_context_bg },
        TreesitterContextLineNumber = { fg = c.fg_gutter, bg = treesitter_context_bg },
      }
    end
  })

  -- NOTE: this disables updating highlight groups for some reason. Try to enable
  -- and see if modicator.nvim works when
  -- https://github.com/neovim/neovim/issues/20069 gets fixed
  -- Use different highlights for special keys in cmdline vs other windows
  -- vim.opt.winhighlight = 'SpecialKey:SpecialKeyWin'
end }

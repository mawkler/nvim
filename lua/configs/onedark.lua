-------------
-- Onedark --
-------------
return {
  'mawkler/onedark.nvim', priority = 999, config = function()
  local colors = require('onedark.colors').setup()
  local style = require('onedark.types').od.HighlightStyle

  local barbar_bg = '#1d2026'
  local barbar_bg_visible = '#23262d'
  local barbar_fg_gray = '#3b4048'
  local cursorline_bg = '#2f343d'
  local treesitter_context_bg = '#252933'

  require('onedark').setup({
    hide_end_of_buffer = false,
    dev = true,
    hot_reload = false,
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
        CurSearch = { link = 'Search' },
        WinSeparator = { fg = barbar_bg, style = style.Bold  },
        MatchParen = { fg = nil, bg = nil, style = string.format('%s,%s', style.Bold, style.Underline) },
        CursorLine = { bg = cursorline_bg },
        CursorColumn = { link = 'CursorLine' },
        CursorLineNr = { fg = c.green0, bg = cursorline_bg, style = style.Bold },
        MsgArea = { link = 'Normal' },
        SpellBad = { style = style.Undercurl, sp = c.red1 },
        Todo = { link = '@text.warning' },
        -- Modes
        NormalMode  = { fg = c.green0,  bg = cursorline_bg, style = style.Bold },
        InsertMode  = { fg = c.blue0,   bg = cursorline_bg, style = style.Bold },
        VisualMode  = { fg = c.purple0,                     style = style.Bold },
        CommandMode = { fg = c.red0,    bg = cursorline_bg, style = style.Bold },
        SelectMode  = { fg = c.cyan0,   bg = cursorline_bg, style = style.Bold },
        ReplaceMode = { fg = c.red2,    bg = cursorline_bg, style = style.Bold },
        TermMode    = { fg = c.green0,  bg = cursorline_bg, style = style.Bold },
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
        ['@lsp.type.comment'] = {}, -- Use Treesitter's highlight instead, which suports TODO, NOTE, etc.
        -- Markdown (Treesitter)
        ['@text.literal'] = { fg = c.green0 },
        ['@text.emphasis'] = { fg = c.purple0, style = style.Italic },
        ['@text.strong'] = { fg = c.orange0, style = style.Bold },
        ['@punctuation.special'] = { fg = c.red0 },
        ['@text.todo.checked.markdown'] = { fg = c.blue1 },
        ['@text.todo.unchecked.markdown'] = { link = '@text.todo.checked.markdown' },
        -- Markdown/html
        mkdLink = { fg = c.blue0, style = style.Underline },
        mkdHeading = { link = 'Title' },
        markdownTag = { fg = c.purple0, style = style.Bold },
        markdownUrl = { link = 'mkdLink' },
        markdownWikiLink = { fg = c.blue0, sylte = style.Bold },
        ['@punctuation.bracket.markdown_inline'] = { link = 'markdownWikiLink' },
        htmlBold = { fg = c.orange0, style = style.Bold },
        htmlItalic = { fg = c.purple0, style = style.Italic },
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
        EyelinerDimmed = { fg = c.fg_dark },
        -- NvimTree
        NvimTreeFolderIcon = { fg = '#8094b4' },
        NvimTreeFolderName = { fg = c.blue0 },
        NvimTreeOpenedFolderName = { fg = c.blue0, style = style.Bold },
        NvimTreeOpenedFile = { style = style.Bold },
        NvimTreeGitDirty = { fg = c.orange1 },
        NvimTreeGitNew = { fg = c.green0 },
        NvimTreeGitIgnored = { fg = c.fg_dark },
        -- Telescope
        TelescopeMatching = { fg = c.blue0, style = style.Bold },
        TelescopePromptPrefix = { fg = c.fg0, style = style.Bold },
        TelescopePathSeparator = { fg = c.fg_dark },
        -- LSP
        LspReferenceText = { link = 'Search' },
        LspReferenceRead = { link = 'Search' },
        LspReferenceWrite = { link = 'Search' },
        -- Diagnostics
        DiagnosticUnderlineError = { style = style.Underline, sp = c.error },
        DiagnosticUnderlineWarn = { style = style.Underline, sp = c.warning },
        DiagnosticUnderlineHint = { style = style.Underline, sp = c.hint },
        DiagnosticUnderlineInfo = { style = style.Underline, sp = c.info },
        -- nvim-cmp
        PmenuSel              = { fg = c.bg1, bg = c.blue0 },
        CmpItemAbbrMatch      = { fg = c.blue0, style = style.Bold },
        CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
        CmpItemKindFile       = { link = 'NvimTreeFolderIcon' },
        CmpItemKindFolder     = { link = 'CmpItemKindFile' },
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
        BufferTabPagesSep    = { link = 'BufferTabpages' },
        BufferInactive       = { fg = '#707070',      bg = barbar_bg },
        BufferInactiveSign   = { fg = barbar_fg_gray, bg = barbar_bg },
        BufferInactiveMod    = { fg = c.warning,      bg = barbar_bg },
        BufferInactiveTarget = { fg = c.blue0,        bg = barbar_bg, style = style.Bold },
        BufferInactiveIndex  = { fg = barbar_fg_gray, bg = barbar_bg },
        BufferModifiedIndex  = { fg = barbar_fg_gray, bg = barbar_bg },
        -- Grammarous
        GrammarousError = { style = style.Undercurl, sp = c.error },
        -- Scrollbar
        Scrollbar = { fg = c.bg_visual, bg = nil },
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
        -- Mini indentscope
        MiniIndentScopeSymbol = { fg = '#39536c', style = style.Bold },
        -- Nvim-Tree
        NvimTreeIndentMarker = { link = 'IblIndent' },
        -- Crates
        CratesNvimVersion = { fg = c.fg_dark },
        CratesNvimLoading = { link = 'CratesNvimVersion' },
        -- Fidget
        FidgetNormal = { fg = c.fg_dark },
        -- Neotest
        NeotestFile = { fg = c.blue0 },
        NeotestDir = { link = 'NvimTreeFolderIcon' },
        NeotestAdapterName = { link = 'Title' },
        NeotestFailed = { fg = c.red0 },
        NeotestPassed = { fg = c.green0 },
        NeotestRunning = { fg = c.orange0 },
        NeotestWatching = { fg = c.orange1 },
        NeotestSkipped = { fg = c.fg_dark },
        NeotestUnknown = { link = 'NeotestSkipped' },
        NeotestMarked = { fg = c.purple0 },
        NeotestFocused = { style = style.Bold },
      }
    end
  })
end }

local gl = require('galaxyline')
local gls = gl.section

gl.short_line_list = {
  'LuaTree', 'vista', 'dbui', 'startify', 'term', 'nerdtree', 'fugitive', 'fugitiveblame', 'plug'
}

local function GetHiVal(name, layer)
  layer = layer or 'fg'
  return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(name)), layer .. '#')
end

local colorscheme = require('base16-colorscheme').colorschemes['onedark']

local colors = {
  bg = colorscheme.base00,
  line_bg = colorscheme.base01,
  fg = colorscheme.base07,
  fg_green = colorscheme.base0B,

  yellow = colorscheme.base0A,
  cyan = colorscheme.base0C,
  darkblue = colorscheme.base04,
  green = colorscheme.base0B,
  orange = colorscheme.base09,
  purple = colorscheme.base06,
  magenta = colorscheme.base08,
  blue = colorscheme.base0D,
  red = colorscheme.base0F,

  diff_add = GetHiVal('DiffAdd'),
  diff_change = GetHiVal('DiffChange'),
  diff_delete = GetHiVal('DiffDelete')
}

local function get_mode_color()
  local mode_color = {
    n      = colors.green,
    i      = colors.blue,
    v      = colors.magenta,
    [''] = colors.blue,
    V      = colors.blue,
    c      = colors.red,
    no     = colors.magenta,
    s      = colors.orange,
    S      = colors.orange,
    [''] = colors.orange,
    ic     = colors.yellow,
    R      = colors.purple,
    Rv     = colors.purple,
    cv     = colors.red,
    ce     = colors.red,
    ['r?'] = colors.cyan,
    ['!']  = colors.green,
    t      = colors.green,
    ['r']  = colors.red,
    rm     = colors.red,
  }
  return mode_color[vim.fn.mode()]
end

local function has_file_type()
  local f_type = vim.bo.filetype
  if not f_type or f_type == '' then return false end
  return true
end

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then return true end
  return false
end

-- TODO: consdier switching to feline.nvim

-- Left side of the statusline
table.insert(gls.left, {
  FirstElement = {
    provider = function()
      return '▋'
    end,
    highlight = {colors.blue, get_mode_color}
  }
})

table.insert(gls.left, {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local alias = {
        n      = 'NORMAL',
        i      = 'INSERT',
        c      = 'COMMAND',
        V      = 'VISUAL',
        [''] = 'VISUAL',
        v      = 'VISUAL',
        ['r?'] = ':CONFIRM',
        rm     = '--MORE',
        R      = 'REPLACE',
        Rv     = 'VIRTUAL',
        s      = 'SELECT',
        S      = 'SELECT',
        ['r']  = 'HIT-ENTER',
        [''] = 'SELECT',
        t      = 'TERMINAL',
        ['!']  = 'SHELL'
      }
      local vim_mode = vim.fn.mode()
      -- vim.api.nvim_command('hi GalaxyViMode guifg=' .. get_mode_color())
      return alias[vim_mode] .. '   '
    end,
    highlight = { colors.line_bg, vim.fn.mode(), 'bold' } -- highlight seems to only be set once
  }
})

table.insert(gls.left, {
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.line_bg}
  }
})

table.insert(gls.left, {
  FileName = {
    provider = {'FileName'},
    condition = buffer_not_empty,
    highlight = {colors.fg, colors.line_bg, 'bold'}
  }
})

table.insert(gls.left, {
  GitIcon = {
    provider = function() return '  ' end,
    condition = require('galaxyline.condition').check_git_workspace,
    highlight = {colors.orange, colors.line_bg}
  }
})

table.insert(gls.left, {
  GitBranch = {
    provider = 'GitBranch',
    condition = require('galaxyline.condition').check_git_workspace,
    highlight = {'#8FBCBB', colors.line_bg, 'bold'},
    separator = ' ', -- Need for some reason for DiffAdd, etc.
    separator_highlight = {'#8FBCBB', colors.line_bg, 'bold'}
  }
})

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then return true end
  return false
end

table.insert(gls.left, {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.diff_add, colors.line_bg}
  }
})

table.insert(gls.left, {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = '柳',
    highlight = {colors.diff_change, colors.line_bg}
  }
})

table.insert(gls.left, {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.diff_delete, colors.line_bg}
  }
})

table.insert(gls.left, {
  LeftEnd = {
    provider = function() return '' end,
    highlight = {colors.line_bg, colors.bg},
  }
})

table.insert(gls.left, {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red, colors.bg}
  }
})

table.insert(gls.left, {
  Space = {
    provider = function() return ' ' end
  }
})

table.insert(gls.left, {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow, colors.bg}
  }
})

-- Right side of the statusline
table.insert(gls.right, {
  RightEnd = {
    provider = function() return '█' end,
    highlight = {colors.line_bg, colors.bg},
  }
})

table.insert(gls.right, {
  FileFormat = {
    provider = 'FileFormat',
    highlight = {colors.fg, colors.line_bg, 'bold'}
  }
})

table.insert(gls.right, {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {colors.blue, colors.line_bg},
    highlight = {colors.fg, colors.line_bg}
  }
})

table.insert(gls.right, {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {colors.line_bg, colors.line_bg},
    highlight = {colors.cyan, colors.line_bg, 'bold'}
  }
})

-- Short statusline for special filetypes like nvim-tree
table.insert(gls.short_line_left, {
  BufferType = {
    provider = 'FileTypeName',
    separator = '',
    condition = has_file_type,
    separator_highlight = {colors.line_bg, colors.bg},
    highlight = {colors.fg, colors.line_bg}
  }
})

table.insert(gls.short_line_right, {
  BufferIcon = {
    provider = 'BufferIcon',
    separator = '',
    condition = has_file_type,
    separator_highlight = {colors.line_bg, colors.bg},
    highlight = {colors.fg, colors.line_bg}
  }
})

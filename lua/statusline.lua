local b, bo, fn = vim.b, vim.bo, vim.fn

local vi_mode = require('feline.providers.vi_mode')
local lsp = require('feline.providers.lsp')

local function GetHiVal(name, layer)
  layer = layer or 'fg'
  return fn.synIDattr(fn.synIDtrans(fn.hlID(name)), layer .. '#')
end

local colorscheme = require('base16-colorscheme').colorschemes['onedark']

local colors = {
  bg          = colorscheme.base00, -- #282c34
  line_bg     = colorscheme.base01, -- #353b45
  fg          = colorscheme.base07, -- #c8ccd4
  fg_green    = colorscheme.base0B,

  yellow      = colorscheme.base0A,
  cyan        = colorscheme.base0C,
  darkblue    = colorscheme.base04,
  green       = colorscheme.base0B,
  orange      = colorscheme.base09,
  purple      = colorscheme.base0E,
  magenta     = colorscheme.base08,
  blue        = colorscheme.base0D,
  red         = colorscheme.base0F,
  gray        = colorscheme.base05,

  diff_add    = GetHiVal('DiffAdd'),
  diff_change = GetHiVal('DiffChange'),
  diff_delete = GetHiVal('DiffDelete')
}

local mode_colors = {
  NORMAL        = colors.green,
  OP            = colors.green,
  INSERT        = colors.blue,
  COMMAND       = colors.red,
  VISUAL        = colors.purple,
  BLOCK         = colors.purple,
  REPLACE       = colors.magenta,
  ['V-REPLACE'] = colors.red,
  ENTER         = colors.orange,
  MORE          = colors.orange,
  SELECT        = colors.cyan,
  SHELL         = colors.green,
  TERM          = colors.green,
  NONE          = colors.gray
}

local properties = {
  force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {}
  }
}

local components = {
  left = {
    active = {},
    inactive = {}
  },
  mid = {
    active = {},
    inactive = {}
  },
  right = {
    active = {},
    inactive = {}
  }
}

properties.force_inactive.filetypes = {
  'NvimTree',
  'vista',
  'dbui',
  'startify',
  'term',
  'nerdtree',
  'fugitive',
  'fugitiveblame',
  'plug',
  'NvimTree',
  'dbui',
  'packer',
  'startify',
}

local left_sep  = { str = '█',   hl = { fg = 'line_bg' } }
local right_sep = { str = '█ ',  hl = { fg = 'line_bg' } }
local full_sep  = { str = '█ █', hl = { fg = 'line_bg' } }

local function has_file_type()
  local f_type = vim.bo.filetype
  if not f_type or f_type == '' then return false end
  return true
end

local buffer_not_empty = function()
  if fn.empty(fn.expand('%:t')) ~= 1 then return true end
  return false
end

local function get_icon_full()
  local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
  if has_devicons then
    local icon, iconhl = devicons.get_icon(fn.expand('%:t'), fn.expand('%:e'))
    if icon ~= nil then
      return icon, vim.fn.synIDattr(vim.fn.hlID(iconhl), 'fg')
    end
  end
end

local function get_icon()
  return select(1, get_icon_full()) .. ' '
end

local function get_icon_hl()
  return select(2, get_icon_full())
end

local function file_osinfo()
  local os = vim.bo.fileformat
  local icon
  if os == 'unix' then
    icon = ' '
  elseif os == 'mac' then
    icon = ' '
  else
    icon = ' '
  end
  return icon .. os
end

local function in_git_repo() return b.gitsigns_status_dict end

-- Left side of the statusline

table.insert(components.left.active, {
  provider = 'vi_mode',
  hl = function()
    return {
      -- name = vi_mode.get_mode_highlight_name(),
      fg = 'bg',
      bg = vi_mode.get_mode_color(),
      style = 'bold'
    }
  end,
  left_sep = '█',
  right_sep = '█',
  icon = ''
})

table.insert(components.right.active, {
  provider = 'git_diff_added',
  hl = { fg = 'green' }
})

table.insert(components.right.active, {
  provider = 'git_diff_changed',
  hl = { fg = 'orange' }
})

table.insert(components.right.active, {
  provider = 'git_diff_removed',
  hl = { fg = 'red' },
  right_sep = ''
})

table.insert(components.right.active, {
  provider = 'git_branch',
  right_sep = ' ',
  enabled = in_git_repo
  -- icon = '  '
})

local function wide_enough()
  local squeeze_width = fn.winwidth(0) / 2
  if squeeze_width > 40 then return true end
  return false
end

table.insert(components.left.active, {
  provider = 'diagnostic_errors',
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('Error')
  end,
  hl = { fg = 'red' },
})

table.insert(components.left.active, {
    provider = 'diagnostic_warnings',
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('Warning')
  end,
    hl = { fg = 'orange' }
})

table.insert(components.left.active, {
  provider = 'diagnostic_hints',
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('Hint')
  end,
  hl = { fg = 'cyan' }
})

table.insert(components.left.active, {
  provider = 'diagnostic_info',
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('Information')
  end,
  hl = { fg = 'gray' }
})

table.insert(components.right.active, {
  provider = get_icon,
  enabled = has_file_type,
  left_sep = left_sep,
  hl = function() return { fg = get_icon_hl(), bg = 'line_bg' } end
})

table.insert(components.right.active, {
  provider = function() return bo.filetype end,
  enabled = has_file_type,
  right_sep = right_sep,
  hl = function() return {bg = 'line_bg'} end
})

table.insert(components.right.active, {
  provider = file_osinfo,
  hl = { bg = 'line_bg' },
  left_sep = left_sep,
  right_sep = right_sep,
})

table.insert(components.right.active, {
  provider = 'file_encoding',
  hl = { bg = 'line_bg' },
  left_sep = left_sep,
  right_sep = right_sep,
})

table.insert(components.right.active, {
  provider = 'position',
  left_sep = function() return { str = '█',  hl = { fg = vi_mode.get_mode_color() } } end,
  right_sep = function() return { str = '█',  hl = { fg = vi_mode.get_mode_color() } } end,
  hl = function() return {fg = 'line_bg', bg = vi_mode.get_mode_color(), style = 'bold'} end
})

-- Statusline for special inactive windows

table.insert(components.left.inactive, {
  provider = 'FileTypeName',
  right_sep = '',
  -- condition = has_file_type,
  -- separator_hi = {
  --   fg = colors.line_bg,
  --   bg = colors.bg,
  -- },
  hl = {bg = 'line_bg'}
})

-- table.insert(gls.short_line_right, {
--   BufferIcon = {
--     provider = 'BufferIcon',
--     separator = '',
--     condition = has_file_type,
--     separator_highlight = {colors.line_bg, colors.bg},
--     highlight = {colors.fg, colors.line_bg}
--   }
-- })

-- table.insert(components.right.active, {
--   provider = '▊',
--   hl = function()
--     return {fg = vi_mode.get_mode_color()}
--   end
-- })

require('feline').setup {
  default_fg     = colors.fg,
  default_bg     = colors.bg,
  colors         = colors,
  components     = components,
  properties     = properties,
  vi_mode_colors = mode_colors
}

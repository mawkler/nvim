local b, bo, fn = vim.b, vim.bo, vim.fn

local mode = require('feline.providers.vi_mode')
local lsp = require('feline.providers.lsp')
local gps = require('nvim-gps')
local lsp_status = require('lsp-status')

require('nvim-gps').setup({ separator = '  ' })

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
  darkgray    = '#9ba1b0',

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
  LINES         = colors.purple,
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

local components = {
  active = {{}, {}, {}},
  inactive = {{}, {}},
}

local inactive_filetypes = {
  'NvimTree',
  'vista',
  'dbui',
  'term',
  'nerdtree',
  'fugitive',
  'fugitiveblame',
  'plug',
  'dbui',
  'packer',
}

local left_sep  = { str = ' ',   hl = { fg = 'line_bg' } }
local right_sep = { str = '',  hl = { fg = 'line_bg' } }
local full_sep  = { str = ' ', hl = { fg = 'line_bg' } }

local function has_file_type()
  local f_type = vim.bo.filetype
  if not f_type or f_type == '' then return false end
  return true
end

local function get_working_dir()
  return fn.fnamemodify(fn.getcwd(), ':p:~')
end

local function get_working_dir_short()
  return fn.pathshorten(fn.fnamemodify(fn.getcwd(), ':~'))
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
  local icon = select(1, get_icon_full()) or ''
  return icon .. ' '
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

local function wide_enough()
  local squeeze_width = fn.winwidth(0) / 2
  if squeeze_width > 40 then return true end
  return false
end

local function has_inactive_filetype()
  local filetype = vim.bo.filetype
  for _, ft in pairs(inactive_filetypes) do
    if ft == filetype then
      return true
    end
    return false
  end
end

local function lsp_progress_available()
  local status = lsp_status.status_progress()
  return status ~= '' and status ~= nil and status ~= {}
end

-- Sections

local active_left = components.active[1]
local active_mid = components.active[2]
local active_right = components.active[3]

local inactive_left = components.inactive[1]
local inactive_right = components.inactive[2]

-- Left section --

table.insert(active_left, {
  provider = 'vi_mode',
  hl = function()
    return {
      fg = 'bg',
      bg = mode.get_mode_color(),
      style = 'bold'
    }
  end,
  left_sep = '█',
  right_sep = '█',
  icon = ''
})

-- Readonly indicator
table.insert(active_left, {
  provider = ' ',
  hl = { bg = 'line_bg' },
  enabled = function() return bo.readonly and bo.buftype ~= 'help' end,
})

-- Current working directory
table.insert(active_left, {
  provider = function()
    if wide_enough() then
      return get_working_dir()
    else
      return get_working_dir_short()
    end
  end,
  hl = function() return { fg = mode.get_mode_color(), bg = 'line_bg' } end,
  left_sep = '██',
  right_sep = '█',
  icon = ' '
})

table.insert(active_left, {
  provider = 'lsp_client_names',
  hl = {fg = 'darkgray'},
  enabled = function() return next(vim.lsp.buf_get_clients()) ~= nil end,
  icon = '  '
})

table.insert(active_left, {
  provider = 'diagnostic_errors',
  hl = { fg = GetHiVal('LspDiagnosticsDefaultError') },
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('Error')
  end
})

table.insert(active_left, {
  provider = 'diagnostic_warnings',
  hl = { fg = GetHiVal('LspDiagnosticsDefaultWarning') },
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('Warning')
  end
})

table.insert(active_left, {
  provider = 'diagnostic_info',
  hl = { fg = GetHiVal('LspDiagnosticsDefaultInformation') },
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('Information')
  end
})

table.insert(active_left, {
  provider = 'diagnostic_hints',
  hl = { fg = GetHiVal('LspDiagnosticsDefaultHint') },
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('Hint')
  end
})

-- Middle section --

table.insert(active_mid, {
  provider = gps.get_location,
  hl = { fg = 'darkgray' },
  enabled = function()
    return gps.is_available() and not lsp_progress_available()
  end
})

lsp_status.register_progress()

table.insert(active_mid, {
  provider = lsp_status.status_progress,
  hl = { fg = 'darkgray' },
})

-- Right section --

table.insert(active_right, {
  provider = 'git_diff_added',
  hl = { fg = 'green' }
})

table.insert(active_right, {
  provider = 'git_diff_changed',
  hl = { fg = 'orange' }
})

table.insert(active_right, {
  provider = 'git_diff_removed',
  hl = { fg = 'red' },
  right_sep = ''
})

table.insert(active_right, {
  provider = 'git_branch',
  right_sep = ' ',
  enabled = 'git_info_exists',
  icon = {
    str = '  ',
    hl = { fg = '#f34f29' },
  }
})

table.insert(active_right, {
  provider = get_icon,
  left_sep = left_sep,
  hl = function() return { fg = get_icon_hl(), bg = 'line_bg' } end,
  enabled = has_file_type
})

table.insert(active_right, {
  provider = function() return bo.filetype end,
  right_sep = right_sep,
  hl = function() return { bg = 'line_bg' } end,
  enabled = has_file_type
})

table.insert(active_right, {
  provider = file_osinfo,
  hl = { bg = 'line_bg' },
  left_sep = left_sep,
  right_sep = right_sep,
  enabled = function() return wide_enough() end
})

table.insert(active_right, {
  provider = 'file_encoding',
  hl = { bg = 'line_bg' },
  left_sep = left_sep,
  right_sep = right_sep,
  enabled = function() return wide_enough() end,
})

-- Clock
table.insert(active_right, {
  provider = function() return fn.strftime('%H:%M') end,
  hl = { bg = 'line_bg' },
  left_sep = left_sep,
  right_sep = right_sep,
  icon = function() return {
    str = ' ',
    hl = {
      fg = mode.get_mode_color(),
      bg = 'line_bg'
    }
  } end
})

-- Cursor line and column
table.insert(active_right, {
  provider = function()
    return string.format('%2d:%-2d', fn.line('.'), fn.col('.'))
  end,
  left_sep = function()
    return { str = ' ', hl = { fg = mode.get_mode_color() } }
  end,
  right_sep = function()
    return { str = '█', hl = { fg = mode.get_mode_color() } }
  end,
  hl = function()
    return { fg = 'line_bg', bg = mode.get_mode_color(), style = 'bold' }
  end,
  icon = ' '
})

-- Inactive windows

table.insert(inactive_left, {
  provider = 'file_info',
  right_sep = '',
  type = 'relative',
  hl = { bg = 'line_bg' },
  icon = '',
  file_readonly_icon = ' '
})

table.insert(inactive_right, {
  provider = get_icon,
  left_sep = '',
  hl = function() return { fg = get_icon_hl(), bg = 'line_bg' } end,
  enabled = function()
    return has_file_type() and not has_inactive_filetype()
  end
})

table.insert(inactive_right, {
  provider = function() return bo.filetype end,
  right_sep = '█',
  hl = function() return { bg = 'line_bg' } end,
  enabled = function()
    return has_file_type() and not has_inactive_filetype()
  end
})

require('feline').setup {
  colors         = colors,
  components     = components,
  vi_mode_colors = mode_colors,
  force_inactive = {
    filetypes = inactive_filetypes,
    buftypes = {},
    bufnames = {},
  }
}

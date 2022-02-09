local bo, fn = vim.bo, vim.fn

local mode = require('feline.providers.vi_mode')
local lsp = require('feline.providers.lsp')
local gps = require('nvim-gps')
local lsp_status = require('lsp-status')

require('nvim-gps').setup({ separator = '  ', depth = 1 })

local function GetHiVal(name, layer)
  layer = layer or 'fg'
  return fn.synIDattr(fn.synIDtrans(fn.hlID(name)), layer .. '#')
end

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
  'dapui_watches',
  'dapui_stacks',
  'dapui_breakpoints',
  'dapui_scopes',
}

local left_sep  = { str = ' ',   hl = { fg = 'line_bg' } }
local right_sep = { str = '',  hl = { fg = 'line_bg' } }
-- local full_sep  = { str = ' ', hl = { fg = 'line_bg' } }

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

local function get_icon(padding)
  local icon = select(1, get_icon_full()) or ''
  if not padding then
    return icon
  else
    return icon .. ' '
  end
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
  return fn.winwidth(0) > 100
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
  icon = '',
  priority = 10,
})

-- Readonly indicator
table.insert(active_left, {
  provider = ' ',
  hl = { bg = 'line_bg' },
  enabled = function() return bo.readonly and bo.buftype ~= 'help' end,
  truncate_hide = true,
  priority = 7
})

-- Current working directory
table.insert(active_left, {
  provider = get_working_dir,
  short_provider = get_working_dir_short,
  hl = function() return { fg = mode.get_mode_color(), bg = 'line_bg' } end,
  left_sep = '█',
  right_sep = '█',
  icon = ' ',
  truncate_hide = true,
  priority = 9
})

table.insert(active_left, {
  provider = 'lsp_client_names',
  hl = {fg = 'darkgray'},
  enabled = function() return next(vim.lsp.buf_get_clients()) ~= nil end,
  icon = '  ',
  truncate_hide = true,
  priority = -1,
})

table.insert(active_left, {
  provider = 'diagnostic_errors',
  hl = { fg = GetHiVal('LspDiagnosticsDefaultError') },
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('ERROR')
  end
})

table.insert(active_left, {
  provider = 'diagnostic_warnings',
  hl = { fg = GetHiVal('LspDiagnosticsDefaultWarning') },
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('WARN')
  end
})

table.insert(active_left, {
  provider = 'diagnostic_info',
  hl = { fg = GetHiVal('LspDiagnosticsDefaultInformation') },
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('INFO')
  end
})

table.insert(active_left, {
  provider = 'diagnostic_hints',
  hl = { fg = GetHiVal('LspDiagnosticsDefaultHint') },
  enabled = function()
    return wide_enough() and lsp.diagnostics_exist('HINT')
  end
})

-- Middle section --

table.insert(active_mid, {
  provider = gps.get_location,
  hl = { fg = 'darkgray' },
  enabled = function()
    return gps.is_available() and not lsp_progress_available() and wide_enough()
  end,
  truncate_hide = true,
  priority = -1
})

lsp_status.register_progress()

table.insert(active_mid, {
  provider = lsp_status.status_progress,
  hl = { fg = 'darkgray' },
  truncate_hide = true,
  priority = 5
})

-- Right section --

table.insert(active_right, {
  provider = 'git_diff_added',
  hl = { fg = 'green' },
  truncate_hide = true
})

table.insert(active_right, {
  provider = 'git_diff_changed',
  hl = { fg = 'orange' },
  truncate_hide = true
})

table.insert(active_right, {
  provider = 'git_diff_removed',
  hl = { fg = 'red' },
  right_sep = '',
  truncate_hide = true
})

table.insert(active_right, {
  provider = 'git_branch',
  right_sep = ' ',
  enabled = 'git_info_exists',
  icon = {
    str = '  ',
    hl = { fg = '#f34f29' },
  },
  truncate_hide = true,
  priority = 2
})

table.insert(active_right, {
  provider = function() return ' ' .. bo.filetype end,
  left_sep = {
    str = ' ',
    hl = { fg = 'line_bg' },
    always_visible = true
  },
  right_sep = {
    str = '',
    hl = { fg = 'line_bg' },
    always_visible = true
  },
  hl = { bg = 'line_bg' },
  enabled = has_file_type,
  icon = function()
    return {
      str = get_icon(),
      hl = {
        fg = get_icon_hl(),
        bg = 'line_bg',
      },
      always_visible = true,
    }
  end,
  truncate_hide = true,
  priority = 1
})

table.insert(active_right, {
  provider = file_osinfo,
  hl = { bg = 'line_bg' },
  left_sep = left_sep,
  right_sep = right_sep,
  truncate_hide = true,
  priority = -1
})

table.insert(active_right, {
  provider = 'file_encoding',
  hl = { bg = 'line_bg' },
  left_sep = left_sep,
  right_sep = right_sep,
  truncate_hide = true,
  priority = -1
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
  } end,
  truncate_hide = true
})

-- Cursor line and column
table.insert(active_right, {
  provider = function()
    return string.format('%2d:%-2d', fn.line('.'), fn.col('.'))
  end,
  short_provider = function()
    return string.format('%d:%-d', fn.line('.'), fn.col('.'))
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
  icon = ' ',
  priority = 9,
})

-- Inactive windows

table.insert(inactive_left, {
  provider = {
    name = 'file_info',
    opts = {
      type = 'relative',
      file_readonly_icon = ' '
    }
  },
  right_sep = '',
  hl = { bg = 'line_bg' },
  icon = '',
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

local function setup(config)
  if not config or not config.theme then
    error('No config and/or theme provided')
  else
    local theme = config.theme
    if config.modifications then
      theme = vim.tbl_extend('force', theme, config.modifications)
    end
    local mode_colors = {
      NORMAL        = 'green',
      OP            = 'green',
      INSERT        = 'blue',
      COMMAND       = 'red2',
      VISUAL        = 'purple',
      LINES         = 'purple',
      BLOCK         = 'purple',
      REPLACE       = 'red',
      ['V-REPLACE'] = 'magenta',
      ENTER         = 'orange',
      MORE          = 'orange',
      SELECT        = 'cyan',
      SHELL         = 'green',
      TERM          = 'green',
      NONE          = 'gray'
    }

    require('feline').setup {
      theme = theme,
      components = components,
      vi_mode_colors = mode_colors,
      force_inactive = {
        filetypes = inactive_filetypes,
        buftypes = {},
        bufnames = {},
      }
    }
  end
end

return { setup = setup }

local bo, fn = vim.bo, vim.fn
local mode_color = require('feline.providers.vi_mode').get_mode_color
local luasnip = require('luasnip')

local components = { active = { {}, {}, {} } }

local modes = {
  ['n']    = 'NORMAL',
  ['no']   = '  OP  ',
  ['nov']  = '  OP  ',
  ['noV']  = '  OP  ',
  ['no'] = '  OP  ',
  ['niI']  = 'NORMAL',
  ['niR']  = 'NORMAL',
  ['niV']  = 'NORMAL',
  ['v']    = 'VISUAL',
  ['V']    = 'LINES ',
  ['']   = 'BLOCK ',
  ['s']    = 'SELECT',
  ['S']    = 'SELECT',
  ['']   = 'BLOCK ',
  ['i']    = 'INSERT',
  ['ic']   = 'INSERT',
  ['ix']   = 'INSERT',
  ['R']    = 'REPLACE',
  ['Rc']   = 'REPLACE',
  ['Rv']   = 'V-REPLACE',
  ['Rx']   = 'REPLACE',
  ['c']    = 'COMMAND',
  ['cv']   = 'COMMAND',
  ['ce']   = 'COMMAND',
  ['r']    = 'ENTER ',
  ['rm']   = ' MORE ',
  ['r?']   = 'CONFIRM',
  ['!']    = 'SHELL ',
  ['t']    = ' TERM ',
  ['nt']   = ' TERM ',
  ['null'] = ' NONE ',
}

-- Separators

local separator_hl = { fg = 'line_bg', bg = 'separator_bg' }
local left_sect = {
  left_sep = { str = ' ', hl = separator_hl },
  right_sep = { str = '', hl = separator_hl },
}
local right_sect = {
  left_sep  = { str = ' ', hl = separator_hl },
  right_sep = { str = '',  hl = separator_hl },
}

-- Help functions

local function has_file_type()
  local f_type = vim.bo.filetype
  if not f_type or f_type == '' then return false end
  return true
end

local function get_working_dir(shorten)
  if shorten == true then
    return fn.pathshorten(fn.fnamemodify(fn.getcwd(), ':~'))
  else
    return fn.fnamemodify(fn.getcwd(), ':p:~')
  end
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

-- Sections
local active_left = components.active[1]
local active_mid = components.active[2]
local active_right = components.active[3]

------------------
-- Left section --
------------------

-- Vim mode
table.insert(active_left, {
  provider = function()
    return ' ' .. modes[vim.api.nvim_get_mode().mode] .. ' '
  end,
  hl = function()
    return { fg = 'middle_bg', bg = mode_color(), style = 'bold' }
  end,
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
  short_provider = function () return get_working_dir(true) end,
  hl = function() return { fg = mode_color(), bg = 'line_bg' } end,
  left_sep = '█',
  right_sep = { str = '',  hl = { fg = 'line_bg', bg = 'separator_bg' } },
  icon = ' ',
  truncate_hide = true,
  priority = 9
})

-- Search count
table.insert(active_left, {
  provider = function()
    if vim.v.hlsearch == 0 then return '' end
    local res = vim.fn.searchcount({ maxcount = 999, timeout = 250 })
    if res.total == 0 then return 'not found' end
    return string.format('%d/%d', res.current, math.min(res.total, res.maxcount))
  end,
  icon = {
    str = ' ',
    hl = function() return { fg = mode_color() } end,
  },
  hl = { bg = 'line_bg' },
  left_sep = left_sect.left_sep,
  right_sep = left_sect.right_sep,
})

-- Macro recording
table.insert(active_left, {
  provider = function() return vim.fn.reg_recording() end,
  enabled = function() return vim.o.cmdheight == 0 end,
  icon = {
    str = ' ',
    hl = function() return { fg = mode_color() } end,
  },
  hl = { bg = 'line_bg' },
  left_sep = left_sect.left_sep,
  right_sep = left_sect.right_sep,
})

table.insert(active_left, {
  provider = ' ',
  hl = { fg = 'middle_bg', bg = 'separator_bg' },
})

local function lsp_servers()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  local client_names = vim.tbl_map(function(client)
    return client.name
  end, clients)

  return table.concat(client_names, ' | ')
end

-- LSP server
table.insert(active_left, {
  provider = lsp_servers,
  left_sep = ' ',
  riht_sep = ' ',
  hl = { fg = 'dark_text' },
  enabled = function() return next(vim.lsp.get_active_clients()) ~= nil end,
  icon = function() return {
    str = ' ',
    hl = { fg = mode_color() }
  }
  end,
  truncate_hide = true,
  priority = -1,
})

table.insert(active_left, {
  provider = 'diagnostic_errors',
  hl = { fg = 'error' },
})

table.insert(active_left, {
  provider = 'diagnostic_warnings',
  hl = { fg = 'warning' },
})

table.insert(active_left, {
  provider = 'diagnostic_info',
  hl = { fg = 'info' },
})

table.insert(active_left, {
  provider = 'diagnostic_hints',
  hl = { fg = 'hint' },
})

--------------------
-- Middle section --
--------------------

-- Snippet indicator
table.insert(active_mid, {
  provider = 'snippet',
  hl = { fg = 'dark_text' },
  enabled = luasnip.in_snippet,
  icon = {
    str =' ',
    hl = { fg = 'snippet' }
  },
})

-------------------
-- Right section --
-------------------

table.insert(active_right, {
  provider = 'git_diff_added',
  hl = { fg = 'git_add' },
  truncate_hide = true
})

table.insert(active_right, {
  provider = 'git_diff_changed',
  icon = '  ',
  hl = { fg = 'git_change' },
  truncate_hide = true
})

table.insert(active_right, {
  provider = 'git_diff_removed',
  hl = { fg = 'git_remove' },
  right_sep = '',
  truncate_hide = true
})

-- Git branch
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
  provider = '',
  hl = { fg = 'middle_bg', bg = 'separator_bg' },
})

-- Filetype
table.insert(active_right, {
  provider = function() return ' ' .. bo.filetype end,
  left_sep = right_sect.left_sep,
  right_sep = right_sect.right_sep,
  hl = { bg = 'line_bg' },
  enabled = has_file_type,
  icon = function()
    return {
      str = get_icon(),
      hl = { fg = get_icon_hl(), bg = 'line_bg' },
      always_visible = true,
    }
  end,
  truncate_hide = true,
  priority = 1
})

-- File OS info
table.insert(active_right, {
  provider = file_osinfo,
  hl = { bg = 'line_bg' },
  left_sep = right_sect.left_sep,
  right_sep = right_sect.right_sep,
  truncate_hide = true,
  priority = -1,
})

-- File encoding
table.insert(active_right, {
  provider = 'file_encoding',
  hl = { bg = 'line_bg' },
  left_sep = right_sect.left_sep,
  right_sep = right_sect.right_sep,
  truncate_hide = true,
  priority = -1,
  enabled = function()
    return bo.fenc ~= 'utf-8'
  end,
})

-- Copilot
table.insert(active_right, {
  provider = 'ﮧ ',
  hl = function() return { fg = mode_color(), bg = 'line_bg' } end,
  left_sep = right_sect.left_sep,
  right_sep = right_sect.right_sep,
  enabled = function()
    return fn.exists('*copilot#Enabled') == 1 and fn['copilot#Enabled']() == 1
  end,
  truncate_hide = true
})

-- Clock
table.insert(active_right, {
  provider = function() return fn.strftime('%H:%M') end,
  hl = { bg = 'line_bg' },
  left_sep = right_sect.left_sep,
  right_sep = right_sect.right_sep,
  icon = function() return {
    str = ' ',
    hl = {
      fg = mode_color(),
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
    return { str = ' ', hl = { fg = mode_color(), bg = 'separator_bg' } }
  end,
  right_sep = function()
    return { str = '█', hl = { fg = mode_color(), bg = 'separator_bg' } }
  end,
  hl = function()
    return { fg = 'line_bg', bg = mode_color(), style = 'bold' }
  end,
  icon = ' ',
  priority = 9,
})

-----------
-- Setup --
-----------

-- fg:           text foreground on regular components
-- line_bg:      background of regular statusline components
-- middle_bg:    background of middle section
-- separator_bg: space between components (bg of Normal)
-- dark_text:    text on dark background
-- error:        error color
-- warning:      warning color
-- info:         info color
-- hint:         hint color
-- snippet:      snippet icon color
-- git_add:      git add color
-- git_change:   git change color
-- git_remove:   git remove color
-- shell_mode:   shell mode color
-- enter_mode:   enter mode color
-- more_mode:    more mode color
-- select_mode:  select mode color
-- normal_mode:  normal mode color
-- insert_mode:  insert mode color
-- command_mode: command mode color
-- visual_mode:  visual mode color
-- replace_mode: replace mode color
-- term_mode:    term mode color
local function setup(config)
  local mode_colors = {
    NORMAL        = config.theme.normal_mode,
    OP            = config.theme.normal_mode,
    INSERT        = config.theme.insert_mode,
    COMMAND       = config.theme.command_mode,
    VISUAL        = config.theme.visual_mode,
    LINES         = config.theme.visual_mode,
    BLOCK         = config.theme.visual_mode,
    REPLACE       = config.theme.replace_mode,
    TERM          = config.theme.term_mode,
    ['V-REPLACE'] = config.theme.replace_mode,
    SELECT        = config.theme.select_mode,
    ENTER         = 'skyblue',
    MORE          = 'skyblue',
    SHELL         = 'skyblue',
    NONE          = 'skyblue',
  }

  if not config or not config.theme then
    error('Statusline: no theme provided')
  else
    config.theme.bg = config.theme.middle_bg
    require('feline').setup({
      theme = config.theme,
      components = components,
      vi_mode_colors = mode_colors,
      force_inactive = {}
    })
  end
end

return { setup = setup }

local cmd, fn, call = vim.cmd, vim.fn, vim.call
local o, g, b, bo = vim.o, vim.g, vim.b, vim.bo
local api = vim.api

local function t(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

local function error(message)
  api.nvim_echo({{message, 'Error'}}, false, {})
end

-- Should be loaded before any other plugin
-- Remove once https://github.com/neovim/neovim/pull/15436 gets merged
require('impatient')

-------------------
-- LSP Installer --
-------------------
local function make_opts()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    capabilities = capabilities, -- enable snippet support
    on_attach = function()
      require('lsp_signature').on_attach({
        hi_parameter = 'String',
        handler_opts = {
          border = 'rounded',
        },
        hint_enable = false
      })
    end
  }
end

-- Typescript config
local typescript_settings = {
  init_options = require('nvim-lsp-ts-utils').init_options,
  on_attach = function(client, bufnr)
    local ts_utils = require('nvim-lsp-ts-utils')
    ts_utils.setup({
      auto_inlay_hints = false,
      inlay_hints_highlight = 'CopilotSuggestion'
    })
    ts_utils.setup_client(client)

    local opts = { silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', ':TSLspRenameFile<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':TSLspImportAll<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', ':TSLspToggleInlayHints<CR>', opts)
  end,
}

-- Lua config
local lua_settings = require('lua-dev').setup({
  lspconfig = {
    settings = {
      Lua = {
        diagnostics = {
          globals = {'use'}, -- For when i eventually switch to packer
        },
      },
    }
  }
})

-- YAML config
local yaml_settings = {
  yaml = {
    schemaStore = {
      url = 'https://www.schemastore.org/api/json/catalog.json',
      enable = true,
    }
  }
}

-- Zsh/Bash config
local bash_settings = {
  filetypes = {'sh', 'zsh'}
}

require('nvim-lsp-installer').on_server_ready(function(server)
  local opts = make_opts()
  if server.name == 'sumneko_lua' then
    opts = lua_settings
  elseif server.name == 'yaml' then
    opts.settings = yaml_settings
  elseif server.name == 'bashls' then
    opts = bash_settings
  elseif server.name == 'tsserver' then
    opts = typescript_settings
  end
  server:setup(opts)
  cmd 'do User LspAttachBuffers'
end)

-------------
-- LSPKind --
-------------
local lspkind = require('lspkind')
lspkind.init {
  symbol_map = {
    Class     = '',
    Interface = '',
    Module    = '',
    Enum      = '',
    Text      = '',
    Struct    = ''
  }
}

---------
-- Cmp --
---------
o.completeopt = 'menuone,noselect'
local cmp = require('cmp')
local mapping = cmp.mapping
local disabled = cmp.config.disable
local insert = { behavior = cmp.SelectBehavior.Insert }

local function cmp_map(rhs, modes)
  if (modes == nil) then
    modes = {'i', 'c'}
  else if (type(modes) ~= 'table')
    then modes = {modes} end
  end
  return cmp.mapping(rhs, modes)
end

local function toggle_complete()
  return function()
    if cmp.visible() then
      cmp.close()
    else
      cmp.complete()
    end
  end
end

local function complete()
  return function ()
    local copilot_keys = fn['copilot#Accept']('')
    if cmp.visible() then
      cmp.mapping.confirm({select = true})()
    elseif call 'vsnip#available' == 1 then
      return api.nvim_feedkeys(t '<Plug>(vsnip-expand)', 'i', true)
    elseif copilot_keys ~= '' then
      api.nvim_feedkeys(copilot_keys, 'i', true)
    else
      cmp.complete()
    end
  end
end

local function visible_buffers()
  local bufs = {}
  for _, win in ipairs(api.nvim_list_wins()) do
    bufs[api.nvim_win_get_buf(win)] = true
  end
  return vim.tbl_keys(bufs)
end

local function join(tbl1, tbl2)
  local tbl3 = {}
  for _, item in ipairs(tbl1) do
    table.insert(tbl3, item)
  end
  for _, item in ipairs(tbl2) do
    table.insert(tbl3, item)
  end
  return tbl3
end

cmp.PreselectMode = true

local sources = {
  { name = 'vsnip' },
  { name = 'nvim_lsp' },
  { name = 'path' },
  {
    name = 'buffer',
    option = {
      get_bufnrs = visible_buffers, -- Suggest words from all visible buffers
    },
  }
}
---@diagnostic disable-next-line: unused-local
local markdown_sources = join(sources, {
  { name = 'cmp_tabnine' }
})

cmp.setup({
  snippet = {
    expand = function(args)
      fn['vsnip#anonymous'](args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp_map(mapping.select_next_item(insert)),
    ['<C-k>'] = cmp_map(mapping.select_prev_item(insert)),
    ['<C-b>'] = cmp_map(mapping.scroll_docs(-4)),
    ['<C-f>'] = cmp_map(mapping.scroll_docs(4)),
    ['<C-Space>'] = cmp_map(toggle_complete(), {'i', 'c', 's'}),
    -- TODO: <Tab> in select mode should trigger cmp.complete()
    ['<Tab>'] = cmp_map(complete()),
    ['<C-y>'] = disabled,
    ['<C-n>'] = disabled,
    ['<C-p>'] = disabled,
  },
  sources = cmp.config.sources(sources),
  formatting = {
    format = lspkind.cmp_format()
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  }
})

-- Tabnine
cmd [[
  autocmd FileType markdown,text,tex,gitcommit
  \ lua require('cmp').setup.buffer {
  \   sources = markdown_sources,
  \ }
]]

-- Use buffer source for `/` (searching)
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for `:`
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' }
  })
})

-------------
-- Tabnine --
-------------
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
  max_num_results = 5;
  ignored_file_types = {};
})

-----------------
-- ColorScheme --
-----------------
local colors = require('onedark.colors').setup()
require('onedark').setup {
  colors = {
    fg_cursor_linenumber = 'blue',
    fg_search = colors.fg,
    bg_search = colors.bg_visual,
    fg_gutter = colors.yelow,
    hint = colors.syntax.comment,
    git = {
      add = colors.green,
      change = colors.orange,
      delete = colors.red
    }
  }
}

-------------
-- LSPSaga --
-------------
require('lspsaga').init_lsp_saga {
  rename_action_keys = {
    quit = {'<Esc>'},
  },
  code_action_prompt = {
    enable = false,
  },
  code_action_keys = {
    quit = '<Esc>'
  },
  rename_prompt_prefix = 'Rename ➤',
}

--------------
-- Mappings --
--------------
local function map(modes, lhs, rhs, opts)
  if (type(modes) ~= 'table') then modes = {modes} end

  for _, mode in pairs(modes) do
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_set_keymap(mode, lhs, rhs, options)
  end
end

function _G.right_or_snip_next()
  if fn['vsnip#jumpable'](1) == 1 then
    return t '<Plug>(vsnip-jump-next)'
  elseif fn.mode() == 'i' then
    return t '<Right>'
  else
    return ''
  end
end

function _G.left_or_snip_prev()
  if fn['vsnip#jumpable'](-1) == 1 then
    return t '<Plug>(vsnip-jump-prev)'
  elseif fn.mode() == 'i' then
    return t '<Left>'
  else return ''
  end
end

-- Snippets
map({'i', 's'}, '<M-l>', 'v:lua.right_or_snip_next()', {noremap = false, expr = true})
map({'i', 's'}, '<M-h>', 'v:lua.left_or_snip_prev()', {noremap = false, expr = true})
map({'i', 's'}, '<C-n>', '<Plug>(vsnip-jump-next)', {noremap = false})
map({'i', 's'}, '<C-p>', '<Plug>(vsnip-jump-prev)', {noremap = false})

-- LSP and diagnostics
map('n',        'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>')
-- map('n',        'gh',        '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
map('n',        'gh',        '<cmd> lua vim.lsp.buf.hover()<CR>')
-- map('n',        'gH',        '<cmd>lua require("lspsaga.diagnostic").show_cursor_diagnostics()<CR>')
map('n',        'gH',        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>')
map('n',        '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>')
map('n',        'gD',        '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n',        '1gD',       '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n',        'gs',        '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>')
map({'n', 'x'}, '<leader>r', '<cmd>lua require("lspsaga.rename").rename()<CR>')
map('n',        'gR',        '<cmd>lua vim.lsp.buf.references({includeDeclaration = false})<CR>')
map('n',        'g0',        '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n',        'gW',        '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
-- map({'n', 'x'}, 'gA',        '<cmd>lua require("lspsaga.codeaction").code_action()<CR>')
map({'n', 'x'}, '<leader>a',        '<cmd>Telescope lsp_code_actions<cr>')
-- map('n',        '[e',        '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>')
map('n',        '[e',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
-- map('n',        ']e',        '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>')
map('n',        ']e',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n',        ']E',        '<cmd>lua vim.lsp.diagnostic.goto_next({severity = {min = vim.diagnostic.severity.INFO}})<CR>')
map('n',        '[E',        '<cmd>lua vim.lsp.diagnostic.goto_prev({severity = {min = vim.diagnostic.severity.INFO}})<CR>')
map('n',        '<leader>f', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>')

-- Sets `bufhidden = delete` if buffer was jumped to
function _G.quickfix_jump(command)
  if b.buffer_jumped_to then
    bo.bufhidden = 'delete'
  end
  -- cmd(command)
  local successful, err_message = pcall(cmd, command)
  if successful then
    b.buffer_jumped_to = true
  else
    error(err_message)
  end
end

map('n', ']q', ':lua quickfix_jump("cnext")<CR>')
map('n', '[q', ':lua quickfix_jump("cprev")<CR>')
map('n', ']Q', ':cbelow<CR>')
map('n', '[Q', ':cabove<CR>')
map('n', ']l', ':lbelow<CR>')
map('n', '[l', ':labove<CR>')

-------------
-- LSPKind --
-------------
require('lspkind').init {
  symbol_map = {
    Class     = '',
    Interface = '',
    Module    = '',
    Enum      = '',
    Text      = '',
    Struct    = ''
  }
}

---------------
-- Telescope --
---------------
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>']   = 'move_selection_next',
        ['<C-k>']   = 'move_selection_previous',
        ['<Esc>']   = 'close',
        ['<S-Esc>'] = function() cmd 'stopinsert' end,
        ['<C-u>']   = false
      }
    },
    layout_config = { width = 0.9, preview_width = 0.58 },
    selection_caret = '▶ ',
    prompt_prefix = '   ',
  }
}

require('telescope').load_extension('zoxide')
require('telescope').load_extension('project')

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values

function _G.telescope_cd(dir)
  if dir == nil then dir = '.' end
  local opts = {cwd = dir}

  -- TODO:
  -- require('plenary.scandir').scan_dir(vim.loop.cwd(), {
  --   hidden = true,
  --   add_dirs = true,
  --   depth = 1,
  -- })
  pickers.new(opts, {
    prompt_title = 'Change Directory',
    finder = finders.new_oneshot_job({
      'fd',
      '-t',
      'd',
      '--hidden',
      '--ignore-file',
      fn.expand('$HOME/') .. '.agignore'
    }, opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        print(selection)
        if selection ~= nil then
          actions.close(prompt_bufnr)
          api.nvim_command('cd ' .. dir .. '/' .. selection[1])
        end
      end)
      return true
    end,
  }):find()
end
map('n', 'cd', '<cmd>lua telescope_cd()<CR>')
map('n', 'cD', '<cmd>lua telescope_cd("~")<CR>')
---------------
-- Nvim-tree --
---------------
local tree_cb = require('nvim-tree.config').nvim_tree_callback

g.nvim_tree_indent_markers = 1
g.nvim_tree_highlight_opened_files = 2
g.nvim_tree_special_files = {}
g.nvim_tree_icons = {
  default = '' ,
}

require('nvim-tree').setup {
  diagnostics = {
    enable = true
  },
  disable_netrw = false,
  update_cwd = true,
  git = {
    ignore = true,
  },
  show_icons = {
    git = true,
    folders = true,
    files = true,
  },
  view = {
    width = 40,
    mappings = {
      list = {
        { key = 'l', cb = tree_cb('edit') },
        { key = 'h', cb = tree_cb('close_node') }
      }
    }
  }
}
map('n', '<leader>`', ':NvimTreeToggle<CR>', {silent = true})
map('n', '<leader>~', ':NvimTreeFindFile<CR>', {silent = true})
cmd 'hi! link NvimTreeIndentMarker IndentBlanklineChar'

---------------
-- Autopairs --
---------------
-- Auto insert `()` after completing a function or method
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({
  map_char = { tex = '' },
}))

local rule = require('nvim-autopairs.rule')
local autopairs = require('nvim-autopairs')

autopairs.setup()
autopairs.add_rules {
  rule('$', '$', 'tex'),
  rule('*', '*', 'markdown'),
}

_G.autopairs_cr = autopairs.autopairs_cr
_G.autopairs_bs = autopairs.autopairs_bs
map('i', '<CR>', 'v:lua.autopairs_cr()', {expr = true})
map('i', '<C-h>', 'v:lua.autopairs_bs()', {expr = true})

---------------
-- Formatter --
---------------
local prettier_config = {
  function()
    return {
      exe = 'prettier',
      args = { '--stdin-filepath', api.nvim_buf_get_name(0) },
      stdin = true
    }
  end
}

require('formatter').setup {
  logging = false,
  filetype = {
    javascript = prettier_config,
    typescript = prettier_config,
    typescriptreact = prettier_config,
    yaml = prettier_config,
    json = prettier_config,
    markdown = {
      function()
        return {
          exe = 'prettier',
          args = {'--stdin-filepath', api.nvim_buf_get_name(0)},
          stdin = true
        }
      end
    },
    python = {
      function()
        return {
          exe = 'autopep8',
          args = {'-i'},
          stdin = false
        }
      end
    }
  }
}

function _G.toggle_format_on_write()
  if b.format_on_write == false then
    b.format_on_write = true
    print 'Format on write enabled'
  else
    b.format_on_write = false
    print 'Format on write disabled'
  end
end

b.format_on_write = true
map('n', '<F2>', ':lua toggle_format_on_write()<CR>', {silent = true})

api.nvim_exec([[
  augroup FormatOnWrite
    autocmd!
    autocmd BufWritePost *.js,*.json,*.md,*.py,*.ts,*.tsx,*.yml,*.yaml lua format_and_write()
  augroup END
]], true)

function _G.format_and_write()
  if fn.exists('b:format_on_write') == 0 or b.format_on_write then
    cmd 'FormatWrite'
  end
end

-----------------------
-- Nvim-web-devicons --
-----------------------
require('nvim-web-devicons').set_icon {
  md = {
    icon = '',
    color = '#519aba',
    name = 'Markdown'
  },
  tex = {
    icon = '',
    color = '#3D6117',
    name = 'Tex'
  }
}

----------------
-- Treesitter --
----------------
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    disable = {'latex', 'vim'},
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        ['aF'] = '@function.outer',
        ['iF'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- Whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[]'] = '@class.outer',
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ['>,'] = '@parameter.inner',
      },
      swap_previous = {
        ['<,'] = '@parameter.inner',
      },
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
}

-- Disable treesitter from highlighting errors (LSP does that anyway)
cmd 'highlight! link TSError Normal'

---------------
-- Neoscroll --
---------------
require('neoscroll').setup()

----------------
-- Diagnostics --
----------------

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
  }
)

local function sign_define(name, symbol)
  fn.sign_define(name, {
    text   = symbol,
    texthl = name,
  })
end

local function GetHiVal(name, layer)
  layer = layer or 'fg'
  return fn.synIDattr(fn.synIDtrans(fn.hlID(name)), layer .. '#')
end

if fn.has('nvim-0.6') then
  sign_define('DiagnosticSignError', '')
  sign_define('DiagnosticSignWarn',  '')
  sign_define('DiagnosticSignHint',  '')
  sign_define('DiagnosticSignInfo',  '')

  cmd 'hi  link DiagnosticWarning DiffChange'
  cmd 'hi! link DiagnosticHint Comment'
else
  sign_define('LspDiagnosticsSignError',       '')
  sign_define('LspDiagnosticsSignWarning',     '')
  sign_define('LspDiagnosticsSignHint',        '')
  sign_define('LspDiagnosticsSignInformation', '')

  cmd 'hi link LspDiagnosticsDefaultWarning DiffChange'
  cmd 'hi link LspDiagnosticsDefaultHint Comment'
end

local function make_diagnoistic_underlined(diagnostic)
  cmd('hi DiagnosticUnderline' .. diagnostic .. ' gui=underline guisp='
    .. GetHiVal('LspDiagnosticsDefault' .. diagnostic))
end

make_diagnoistic_underlined('Error')
make_diagnoistic_underlined('Warning')
make_diagnoistic_underlined('Hint')
make_diagnoistic_underlined('Information')

----------------
-- Statusline --
----------------
-- require('floatline').setup()
require('statusline').setup({
  colorscheme = colors,
  modifications = {
    fg = '#c8ccd4',
    line_bg = '#353b45',
    darkgray = '#9ba1b0'
  }
})

----------------
-- DAP --
----------------
require('dap-config')

--------------
-- Gitsigns --
--------------
require('gitsigns').setup {
  signs = {
    add          = {text = '┃', hl = 'String'},
    change       = {text = '┃', hl = 'Boolean'},
    changedelete = {text = '┃', hl = 'Boolean'},
    delete       = {text = '▁', hl = 'Error'},
    topdelete    = {text = '▔', hl = 'Error'},
  },
  keymaps = {
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ['n <leader>ss'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>su'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>sr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>ss'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['v <leader>sr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>sR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>sp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
  },
  attach_to_untracked = false
}
-- Workaround for bug where change highlight switches for some reason
cmd 'hi! link GitGutterChange DiffChange'

---------------
-- Lastplace --
---------------
require('nvim-lastplace').setup()

---------------
-- Dial.nvim --
---------------
local dial = require('dial')

dial.config.searchlist.normal = {
  'number#decimal',
  'number#hex',
  'number#binary',
  'date#[%Y/%m/%d]',
  'date#[%H:%M]',
  'markup#markdown#header',
}

-- Custom augends
local function add_cyclic_augend(name, strlist)
  local augend_key = 'custom#' .. name
  dial.augends[augend_key] = dial.common.enum_cyclic {
    name    = name,
    strlist = strlist
  }
  table.insert(dial.config.searchlist.normal, augend_key)
end

add_cyclic_augend('boolean', {'true', 'false'})
add_cyclic_augend('BOOLEAN', {'TRUE', 'FALSE'})
add_cyclic_augend('logical', {'and', 'or'})
add_cyclic_augend('number', {
  'one',   'two',   'three', 'four', 'five',   'six',
  'seven', 'eight', 'nine',  'ten',  'eleven', 'twelve'
})
add_cyclic_augend('nummer', {
  'en', 'ett', 'två', 'tre', 'fyra', 'fem', 'sex',
  'sju', 'åtta', 'nio', 'tio', 'elva', 'tolv'
})
add_cyclic_augend('access modifier', {'private', 'public'})

map({'n', 'v'}, '<C-a>',  '<Plug>(dial-increment)',            {noremap = false})
map({'n', 'v'}, '<C-x>',  '<Plug>(dial-decrement)',            {noremap = false})
map('v',        'g<C-a>', '<Plug>(dial-increment-additional)', {noremap = false})
map('v',        'g<C-x>', '<Plug>(dial-decrement-additional)', {noremap = false})

----------------
-- Kommentary --
----------------
g.kommentary_create_default_mappings = false

local kommentary = require('kommentary.config')
kommentary.setup()
kommentary.configure_language('default', {
  prefer_single_line_comments = true
})
kommentary.configure_language('typescriptreact', {
  single_line_comment_string = 'auto',
  multi_line_comment_strings = 'auto',
  hook_function = function()
    require('ts_context_commentstring.internal').update_commentstring()
  end,
})

map('n', 'cmm',  '<Plug>kommentary_line_default',   {noremap = false})
map('n', 'cm',   '<Plug>kommentary_motion_default', {noremap = false})
map('n', '<CR>', '<Plug>kommentary_line_default',   {noremap = false})
map('x', '<CR>', '<Plug>kommentary_visual_default', {noremap = false})

-- Restores <CR> mapping in command-line window
cmd 'autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>'

map('n',        '<leader>cmm', '<Plug>kommentary_line_increase',   {noremap = false})
map({'n', 'x'}, '<leader>cm',  '<Plug>kommentary_motion_increase', {noremap = false})
map('n',        '<leader>cuu', '<Plug>kommentary_line_decrease',   {noremap = false})
map({'n', 'x'}, '<leader>cu',  '<Plug>kommentary_motion_decrease', {noremap = false})

map({'n', 'x'}, '<leader>cy', 'yy<Plug>kommentary_line_increase',  {noremap = false})
map('n',
  '<leader>cA',
  ':lua require("ts_context_commentstring.internal").update_commentstring()<CR>:execute "norm! A " . substitute(&commentstring, "%s", "", "")<CR>A',
  {silent = true}
)
-- TODO: add <leader>C or cM mapping for commenting everything to the right of the cursor

---------------
-- Rest.nvim --
---------------
require('rest-nvim').setup()

function _G.http_request()
  if api.nvim_win_get_width(api.nvim_get_current_win()) < 80 then
    cmd('wincmd s')
  else
    cmd('wincmd v')
  end
  cmd('edit ~/.config/nvim/http | set filetype=http | set buftype=')
end

cmd 'command! Http call v:lua.http_request()'

api.nvim_exec([[
  augroup RestNvim
    autocmd!
    autocmd FileType http map  <buffer> <CR>  <Plug>RestNvim:w<CR>
    autocmd FileType http nmap <buffer> <Esc> <cmd>BufferClose<CR>:wincmd c<CR>
  augroup END
]], true)

----------------------
-- Refactoring.nvim --
--------------------
local refactoring = require('refactoring')
refactoring.setup({})

-- Telescope refactoring helper
local function refactor(prompt_bufnr)
  local content = require('telescope.actions.state').get_selected_entry(
    prompt_bufnr
  )
  require('telescope.actions').close(prompt_bufnr)
  require('refactoring').refactor(content.value)
end

-- NOTE: M is a global object
-- for the sake of simplicity in this example
-- you can extract this function and the helper above
-- and then require the file and call the extracted function
-- in the mappings below
M = {}
M.refactors = function()
  local opts = require('telescope.themes').get_cursor() -- set personal telescope options
  require('telescope.pickers').new(opts, {
    prompt_title = 'refactors',
    finder = require('telescope.finders').new_table({
      results = require('refactoring').get_refactors(),
    }),
    sorter = require('telescope.config').values.generic_sorter(opts),
    attach_mappings = function(_, mapping)
      mapping('i', '<CR>', refactor)
      mapping('n', '<CR>', refactor)
      return true
    end
  }):find()
end

api.nvim_set_keymap('v',
  'gRe',
  '<Esc><Cmd>lua require("refactoring").refactor("Extract Function")<CR>',
  { silent = true }
)
api.nvim_set_keymap('v',
  'gRf',
  '<Esc><Cmd>lua require("refactoring").refactor("Extract Function To File")<CR>',
  { silent = true }
)
api.nvim_set_keymap('v',
  '<Leader>R',
  '<Esc><Cmd>lua M.refactors()<CR>',
  { noremap = true }
)

--------------------
-- Indent-o-matic --
--------------------
require('indent-o-matic').setup{}

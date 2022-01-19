local cmd, fn, call = vim.cmd, vim.fn, vim.call
local o, g, b, bo = vim.o, vim.g, vim.b, vim.bo
local api, lsp = vim.api, vim.lsp

local function t(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

local function map(modes, lhs, rhs, opts)
  -- TODO: change so that opts is a table of strings
  if (type(modes) ~= 'table') then modes = {modes} end

  local keymap
  if opts ~= nil and opts.buffer then
    keymap = function(m, l, r, op)
      return api.nvim_buf_set_keymap(0, m, l, r, op)
    end
    opts.buffer = nil
  else
    keymap = api.nvim_set_keymap
  end

  for _, mode in pairs(modes) do
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    keymap(mode, lhs, rhs, options)
  end
end

local function feedkeys(keys, mode)
  if mode == nil then mode = 'i' end
  return api.nvim_feedkeys(t(keys), mode, true)
end

local function error(message)
  api.nvim_echo({{message, 'Error'}}, false, {})
end

-- Should be loaded before any other plugin
-- Remove once https://github.com/neovim/neovim/pull/15436 gets merged
require('impatient')

-- Lua autocmds
local autocmd = require('autocmd-lua')

-------------------
-- LSP Installer --
-------------------
local function make_opts(snippets)
  if snippets == nil then snippets = true end
  local capabilities = lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = snippets
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
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',        ':TSLspRenameFile<CR>',       opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>A', ':TSLspImportAll<CR>',        opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI',        ':TSLspToggleInlayHints<CR>', opts)
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
    opts = make_opts(false)
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

----------------
-- LSP Config --
----------------
lsp.handlers['textDocument/hover'] = lsp.with(
  lsp.handlers.hover,
  { border = 'single' }
)

lsp.handlers['textDocument/signatureHelp'] = lsp.with(
  lsp.handlers.signature_help,
  { border = 'single' }
)

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
      return feedkeys('<Plug>(vsnip-expand)')
    elseif copilot_keys ~= '' then
      feedkeys(copilot_keys)
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
  { name = 'nvim_lua' },
  { name = 'path' },
  {
    name = 'buffer',
    option = {
      get_bufnrs = visible_buffers, -- Suggest words from all visible buffers
    },
  }
}

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
autocmd.augroup {
  'TabNine',
  {{ 'FileType', {
    ['markdown,text,tex,gitcommit'] = function()
      cmp.setup.buffer {
        sources = cmp.config.sources(join({{ name = 'cmp_tabnine' }}, sources))
      }
    end
  }}}
}

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

-------------
-- Copilot --
-------------
map('i', '<C-l>', 'copilot#Accept("")', {expr = true})
g.copilot_assume_mapped = true
g.copilot_filetypes = { TelescopePrompt = false }

-----------------
-- ColorScheme --
-----------------
local colors = require('onedark.colors').setup()
require('onedark').setup {
  hide_end_of_buffer = false,
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
map('n',        'gh',        '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n',        'gH',        '<cmd>lua vim.diagnostic.open_float(nil, {border = "single"})<CR>')
map('n',        '<leader>e', '<cmd>lua vim.diagnostic.open_float(nil, {border = "single"})<CR>')
map('n',        '[e',        '<cmd>lua vim.diagnostic.goto_prev({float = { border = "single" }})<CR>')
map('n',        ']e',        '<cmd>lua vim.diagnostic.goto_next({float = { border = "single" }})<CR>')
map('n',        ']E',        '<cmd>lua vim.diagnostic.goto_next({severity = {min = vim.diagnostic.severity.INFO}, float = { border = "single" }})<CR>')
map('n',        '[E',        '<cmd>lua vim.diagnostic.goto_prev({severity = {min = vim.diagnostic.severity.INFO}, float = { border = "single" }})<CR>')
map('n',        'gD',        '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n',        '1gD',       '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n',        'gs',        '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map({'n', 'x'}, '<leader>r', '<cmd>lua require("lspsaga.rename").rename()<CR>')
map({'n', 'x'}, '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>')
map('n',        'gR',        '<cmd>lua vim.lsp.buf.references({includeDeclaration = false})<CR>')
map('n',        'g0',        '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n',        'gW',        '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')

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

function _G.grep_string()
  vim.ui.input({prompt = 'Grep > '}, function(value)
    if value ~= nil then
      require('telescope.builtin').grep_string({search = value})
    end
  end)
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
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
        ['<C-p>'] = 'cycle_history_prev',
        ['<C-n>'] = 'cycle_history_next',
        ['<C-q>'] = 'close',
        ['<M-a>'] = 'toggle_all',
        ['<M-q>'] = 'send_to_qflist',
        ['<C-s>'] = 'file_vsplit',
        ['<C-a>'] = function() feedkeys('<Home>') end,
        ['<C-e>'] = function() feedkeys('<End>') end,
        ['<C-u>'] = false
      },
      n = {
        ['<C-q>'] = 'close',
      }
    },
    layout_config = {
      width = 0.9,
      horizontal = {
        preview_width = 80
      }
    },
    selection_caret = '▶ ',
    path_display = { 'truncate' },
    prompt_prefix = '   ',
    file_ignore_patterns = {
      '%.git/', 'node_modules/', '%.npm/', '__pycache__/', '%[Cc]ache/',
      '%.dropbox/', '%.dropbox_trashed/', '%.local/share/Trash/', '%.local/',
      '%.py[c]', '%.sw.?', '~$', '%.tags', '%.gemtags', '%.csv$', '%.tsv$',
      '%.tmp', '%.plist$', '%.pdf$', '%.jpg$', '%.JPG$', '%.jpeg$', '%.png$',
      '%.class$', '%.pdb$', '%.dll$', '%.dat$'
    }
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown({
        preview_width = nil,
      }),
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    bookmarks = {
      selected_browser = 'brave',
      url_open_command = 'xdg-open &>/dev/null',
    }
  }
}

function _G.telescope_markdowns()
  require('telescope.builtin').find_files({
    search_dirs = { '$MARKDOWNS' },
    prompt_title = 'Markdowns',
    path_display = function(_, path)
      return path:gsub(vim.fn.expand('$MARKDOWNS'), '')
    end,
  })
end

function _G.telescope_config()
  require('telescope.builtin').find_files({
    search_dirs = { '~/.config/nvim/' },
    prompt_title = 'Neovim config',
    path_display = { 'truncate' },
    hidden = true,
  })
end

function _G.telescope_cd(dir)
  if dir == nil then dir = '.' end
  local opts = {cwd = dir}
  local ignore_file = fn.expand('$HOME/') .. '.agignore'

  pickers.new(opts, {
    prompt_title = 'Change Directory',
    finder = finders.new_oneshot_job(
      { 'fd', '-t', 'd', '--hidden', '--ignore-file', ignore_file },
      opts
    ),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        if selection ~= nil then
          actions.close(prompt_bufnr)
          -- TODO: allow using tcd on <C-t>
          api.nvim_command('cd ' .. dir .. '/' .. selection[1])
        end
      end)
      return true
    end,
  }):find()
end

map('n', '<C-p>',      '<cmd>Telescope find_files<CR>')
map('n', '<leader>f',  '<cmd>lua grep_string()<CR>')
map('n', '<leader>F',  '<cmd>Telescope live_grep<CR>')
map('n', '<leader>bb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>m',  '<cmd>Telescope frecency<CR>')
map('n', '<leader>h',  '<cmd>Telescope help_tags<CR>')
map('n', '<leader>tt', '<cmd>Telescope<CR>')
map('n', '<leader>th', '<cmd>Telescope highlights<CR>')
map('n', '<leader>ts', '<cmd>Telescope lsp_document_symbols<CR>')
map('n', '<leader>tS', '<cmd>Telescope lsp_workspace_symbols<CR>')
map('n', '<leader>tr', '<cmd>Telescope resume<CR>')
map('n', '<leader>tf', '<cmd>lua require("telescope.builtin").find_files({hidden = true})<CR>')
map('n', '<leader>tc', '<cmd>Telescope cheat fd<CR>')

map('n', 'cd', '<cmd>lua telescope_cd()<CR>')
map('n', 'cD', '<cmd>lua telescope_cd("~")<CR>')
map('n', 'cz', '<cmd>Telescope zoxide list<CR>')
map('n', '<leader>B', '<cmd>Telescope bookmarks<CR>')
map('n', '<leader>M', '<cmd>lua telescope_markdowns()<CR>')
map('n', '<leader>N', '<cmd>lua telescope_config()<CR>')

require('telescope').load_extension('zoxide')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('fzf')
require('telescope').load_extension('bookmarks')
require('telescope').load_extension('frecency')
require('telescope').load_extension('cheat')

---------
-- nui --
---------
local popup = {
  position = { row = '40%', col = '50%' },
  size = { width = '30%' },
  border = { style = 'rounded', highlight = 'FloatBorder' },
  win_options = { winhighlight = 'Normal:Normal' }
}

vim.ui.input = function(opts, on_submit)
  local input = require('nui.input')(
    popup, { prompt = opts.prompt, default_value = '', on_submit = on_submit }
  )
  input:mount()
  input:map('i', '<Esc>', input.input_props.on_close, { noremap = true })
  input:map('i', '<C-c>', input.input_props.on_close, { noremap = true })
  input:map('i', '<C-q>', input.input_props.on_close, { noremap = true })
end

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
    ignore = false,
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

autocmd.augroup {
  'NvimTreeRefresh',
  {{ 'BufEnter', {
    ['NvimTree'] = require('nvim-tree.lib').refresh_tree
  }}}
}

map('n', '<leader>`', ':NvimTreeToggle<CR>')
map('n', '<leader>~', ':NvimTreeFindFile<CR>')
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
map('n', '<F2>', ':lua toggle_format_on_write()<CR>')

autocmd.augroup {
  'FormatOnWrite',
  {{ 'BufWritePost', {
    ['*.js,*.json,*.md,*.py,*.ts,*.tsx,*.yml,*.yaml'] = function()
      format_and_write()
    end
  }}}
}

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
require('neoscroll').setup {
  easing_function = 'cubic',
}

local scroll_speed = 140

require('neoscroll.config').set_mappings {
  ['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', scroll_speed}},
  ['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', scroll_speed}},
  ['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', scroll_speed}},
  ['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', scroll_speed}},
  ['zt']    = {'zt', {scroll_speed}, 'sine'},
  ['zz']    = {'zz', {scroll_speed}, 'sine'},
  ['zb']    = {'zb', {scroll_speed}, 'sine'},
}

----------------
-- Diagnostics --
----------------

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
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
  theme = colors,
  modifications = {
    fg = '#c8ccd4',
    line_bg = '#353b45',
    darkgray = '#9ba1b0'
  }
})

---------
-- DAP --
---------
require('dap-config')

----------------------
-- Indent blankline --
----------------------
require('indent_blankline').setup {
  char = '▏',
  show_first_indent_level = false,
  buftype_exclude = {'fzf', 'help'},
  filetype_exclude = {
    'markdown',
    'startify',
    'sagahover',
    'NvimTree',
    'lsp-installer',
  }
}

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
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line({full = true, ignore_whitespace = true})<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require("gitsigns").select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require("gitsigns").select_hunk()<CR>'
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

map('n', 'cmm',  '<Plug>kommentary_line_default',   { noremap = false })
map('n', 'cm',   '<Plug>kommentary_motion_default', { noremap = false })
map('n', '<CR>', '<Plug>kommentary_line_default',   { noremap = false })
map('x', '<CR>', '<Plug>kommentary_visual_default', { noremap = false })

function _G.escape()
  if bo.modifiable then
    cmd 'nohlsearch'
  else
    return feedkeys('<C-w>c', 'n')
  end
end

map('n', '<Esc>', '<cmd>lua escape()<CR>', { noremap = false })
map('t', '<Esc>', '<C-\\><C-n>')
autocmd.augroup {
  'mappings',
  {
    { 'CmdwinEnter', {
      ['*'] = function()
        map('n', '<CR>',  '<CR>',   { buffer = true })
        map('n', '<Esc>', '<C-w>c', { buffer = true })
      end
    }}
  }
}

map('n',        '<leader>cmm', '<Plug>kommentary_line_increase',   {noremap = false})
map({'n', 'x'}, '<leader>cm',  '<Plug>kommentary_motion_increase', {noremap = false})
map('n',        '<leader>cuu', '<Plug>kommentary_line_decrease',   {noremap = false})
map({'n', 'x'}, '<leader>cu',  '<Plug>kommentary_motion_decrease', {noremap = false})
map({'n', 'x'}, '<leader>cy', 'yy<Plug>kommentary_line_increase',  {noremap = false})
map('n',
  '<leader>cA',
  ':lua require("ts_context_commentstring.internal").update_commentstring()<CR>:execute "norm! A " . substitute(&commentstring, "%s", "", "")<CR>A'
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

autocmd.augroup {
  'RestNvim',
  {{ 'FileType', {
    ['http'] = function()
      map('n', '<CR>', '<Plug>RestNvim:w<CR>', { buffer = true, noremap = false })
      map('n', '<Esc>', '<cmd>BufferClose<CR>:wincmd c<CR>', { buffer = true })
    end
  }}}
}

----------------------
-- Refactoring.nvim --
----------------------
local refactoring = require('refactoring')
refactoring.setup({})

-- Telescope refactoring helper
local function refactor(prompt_bufnr)
  local content = action_state.get_selected_entry(
    prompt_bufnr
  )
  actions.close(prompt_bufnr)
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
  pickers.new(opts, {
    prompt_title = 'refactors',
    finder = finders.new_table({
      results = require('refactoring').get_refactors(),
    }),
    sorter = conf.generic_sorter(opts),
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
require('indent-o-matic').setup {}

--------------
-- Miniyank --
--------------
map({'n', 'x'}, 'p',     '<Plug>(miniyank-autoput)',   { noremap = false })
map({'n', 'x'}, 'P',     '<Plug>(miniyank-autoPut)',   { noremap = false })
map({'n', 'x'}, '<M-p>', '<Plug>(miniyank-cycle)',     { noremap = false })
map({'n', 'x'}, '<M-P>', '<Plug>(miniyank-cycleback)', { noremap = false })

---------------------
-- General config --
---------------------
-- Highlight text object on yank
autocmd.augroup {
  'HighlightYank',
  {{ 'TextYankPost', {
    ['*'] = function()
      vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 350 })
    end
  }}
  }
}

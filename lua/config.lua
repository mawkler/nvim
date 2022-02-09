local cmd, fn, call = vim.cmd, vim.fn, vim.call
local opt, g, b, bo = vim.o, vim.g, vim.b, vim.bo
local api, lsp, diagnostic = vim.api, vim.lsp, vim.diagnostic

local function t(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

local function map(modes, lhs, rhs, opts)
  if type(opts) == 'string' then
    opts = { desc = opts }
  end
  vim.keymap.set(modes, lhs, rhs, opts)
end

local function feedkeys(keys, mode)
  if mode == nil then mode = 'i' end
  return api.nvim_feedkeys(t(keys), mode, true)
end

local function error(message)
  api.nvim_echo({{ message, 'Error' }}, false, {})
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

-- Typescript LSP config
local typescript_settings = {
  init_options = require('nvim-lsp-ts-utils').init_options,
  on_attach = function(client)
    local ts_utils = require('nvim-lsp-ts-utils')
    ts_utils.setup({
      update_imports_on_move = true,
      inlay_hints_highlight = 'NvimLspTSUtilsInlineHint'
    })
    ts_utils.setup_client(client)

    local opts = { buffer = true }
    map('n', '<leader>lo', '<cmd>TSLspOrganize<CR>', opts)
    map('n', '<leader>lr', '<cmd>TSLspRenameFile<CR>', opts)
    map('n', '<leader>li', '<cmd>TSLspImportAll<CR>', opts)
    map('n', '<leader>lI', '<cmd>TSLspImportCurrent<CR>', opts)
    map('n', '<leader>lh', '<cmd>TSLspToggleInlayHints<CR>', opts)
  end,
}

-- Lua LSP config
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

-- YAML LSP config
local yaml_settings = {
  yaml = {
    schemaStore = {
      url = 'https://www.schemastore.org/api/json/catalog.json',
      enable = true,
    }
  }
}

-- Zsh/Bash LSP config
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

require('trouble').setup {
  auto_preview = false,
  use_diagnostic_signs = true,
  auto_close = true,
  action_keys = {
    close = {'q', '<C-q>', '<C-c>'},
    cancel = '<esc>',
    refresh = 'R',
    jump = {'<Space>'},
    open_split = {'<c-s>'},
    open_vsplit = {'<c-v>'},
    open_tab = {'<c-t>'},
    jump_close = {'<CR>'},
    toggle_mode = 'm',
    toggle_preview = 'P',
    hover = {'gh'},
    preview = 'p',
    close_folds = {'h', 'zM', 'zm'},
    open_folds = {'l', 'zR', 'zr'},
    toggle_fold = {'zA', 'za'},
    previous = 'k',
    next = 'j'
  },
}
map('n', '<leader>E', '<cmd>TroubleToggle<CR>')

---------
-- Cmp --
---------
opt.completeopt = 'menuone,noselect'
local cmp = require('cmp')
local cmp_mapping = cmp.mapping
local cmp_disabled = cmp.config.disable
local cmp_insert = { behavior = cmp.SelectBehavior.Insert }

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
  { name = 'nvim_lsp_signature_help' },
  { name = 'path',
    option = {
      trailing_slash = true
    }
  },
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
    ['<C-j>'] = cmp_map(cmp_mapping.select_next_item(cmp_insert)),
    ['<C-k>'] = cmp_map(cmp_mapping.select_prev_item(cmp_insert)),
    ['<C-b>'] = cmp_map(cmp_mapping.scroll_docs(-4)),
    ['<C-f>'] = cmp_map(cmp_mapping.scroll_docs(4)),
    ['<C-Space>'] = cmp_map(toggle_complete(), {'i', 'c', 's'}),
    ['<Tab>'] = cmp_map(complete()),
    ['<C-y>'] = cmp_disabled,
    ['<C-n>'] = cmp_disabled,
    ['<C-p>'] = cmp_disabled,
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
map('i', '<C-f>', 'copilot#Accept("")', {expr = true})
g.copilot_assume_mapped = true
g.copilot_filetypes = { TelescopePrompt = false, DressingInput = false }

-----------------
-- ColorScheme --
-----------------
local colors = require('onedark.colors').setup()
require('onedark').setup {
  hide_end_of_buffer = false,
  colors = {
    bg_search = colors.bg_visual,
    hint = colors.dev_icons.gray,
    git = {
      add = colors.green0,
      change = colors.orange1,
      delete = colors.red1
    },
  },
  overrides = function(c)
    return {
      Substitute = {link = 'Search'},
      Title = { fg = c.red0, style = 'bold' },
      mkdHeading = { link = 'Title' },
      mkdLink = { fg = c.blue0, style = 'underline' },
      NvimTreeFolderName = { fg = c.blue0 },
      NvimTreeOpenedFolderName = { fg = c.blue0, style = 'bold' },

      DiagnosticUnderlineError = { style = 'underline', sp = c.error },
      DiagnosticUnderlineWarning = { style = 'underline', sp = c.warning },
      DiagnosticUnderlineHint = { style = 'underline', sp = c.hint },
      DiagnosticUnderlineInfo = { style = 'underline', sp = c.info }
    }
  end
}

--------------
-- Mappings --
--------------
local function right_or_snip_next()
  if fn['vsnip#jumpable'](1) == 1 then
    feedkeys('<Plug>(vsnip-jump-next)')
  elseif fn.mode() == 'i' then
    feedkeys('<Right>')
  end
end

local function left_or_snip_prev()
  if fn['vsnip#jumpable'](-1) == 1 then
    feedkeys('<Plug>(vsnip-jump-prev)')
  elseif fn.mode() == 'i' then
    feedkeys('<Left>')
  end
end

-- Snippets
map({'i', 's'}, '<M-l>', right_or_snip_next, '<Right> or next snippet')
map({'i', 's'}, '<M-h>', left_or_snip_prev, '<Left> or previous snippet')
map({'i', 's'}, '<C-n>', '<Plug>(vsnip-jump-next)')
map({'i', 's'}, '<C-p>', '<Plug>(vsnip-jump-prev)')

local INFO = vim.diagnostic.severity.INFO
local error_opts = {severity = { min = INFO }, float = { border = 'single' }}
local info_opts = {severity = { max = INFO }, float = { border = 'single' }}
local with_border = {float = { border = 'single' }}

-- LSP and diagnostics
map('n',        'gd',        lsp.buf.definition, 'vim.lsp.buf.definition')
map('n',        'gi',        lsp.buf.implementation, 'vim.lsp.buf.implementation')
map('n',        'gD',        lsp.buf.type_definition, 'vim.lsp.buf.type_definition')
map('n',        'gh',        lsp.buf.hover, 'vim.lsp.buf.hover')
map('n',        'gs',        lsp.buf.signature_help, 'vim.lsp.buf.signature_help')
map('i',        '<M-s>',     lsp.buf.signature_help, 'vim.lsp.buf.signature_help')
map('n',        'gR',        function() return lsp.buf.references({includeDeclaration = false}) end, 'vim.lsp.buf.references')
map({'n', 'x'}, '<leader>r', lsp.buf.rename, 'vim.lsp.buf.rename')
map({'n', 'x'}, '<leader>a', lsp.buf.code_action, 'vim.lsp.buf.code_action')
map('n',        '<leader>e', function() return diagnostic.open_float({border = 'single'}) end, 'diagnostic.open_float')
map('n',        ']e',        function() return diagnostic.goto_next(error_opts) end, 'diagnostic.goto_next')
map('n',        '[e',        function() return diagnostic.goto_prev(error_opts) end, 'Previous error')
map('n',        '[h',        function() return diagnostic.goto_prev(info_opts) end, 'Previous info')
map('n',        ']h',        function() return diagnostic.goto_next(info_opts) end, 'Next info')
map('n',        ']d',        function() return diagnostic.goto_next(with_border) end, 'Next diagnostic')
map('n',        '[d',        function() return diagnostic.goto_prev(with_border) end, 'Previous diagnostic')
map('n',        '<C-w>gd',   '<C-w>vgd', {desc = 'LSP go to definition in window split', remap = true})
map('n',        '<C-w>gD',   '<C-w>vgD', {desc = 'LSP go to type definition in window split', remap = true})

-- Sets `bufhidden = delete` if buffer was jumped to
local function quickfix_jump(command)
  if b.buffer_jumped_to then
    bo.bufhidden = 'delete'
  end

  local successful, err_message = pcall(cmd, command)
  if successful then
    b.buffer_jumped_to = true
  else
    error(err_message)
  end
end

local function grep_string()
  vim.ui.input({prompt = 'Grep string'}, function(value)
    if value ~= nil then
      require('telescope.builtin').grep_string({search = value})
    end
  end)
end

map('n', ']q', function() return quickfix_jump('cnext') end, 'Next quickfix item')
map('n', '[q', function() return quickfix_jump('cprev') end, 'Previous quickfix item')
map('n', ']Q', '<cmd>cbelow<CR>')
map('n', '[Q', '<cmd>cabove<CR>')
map('n', ']l', '<cmd>lbelow<CR>')
map('n', '[l', '<cmd>labove<CR>')

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
local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

-- Allows editing multiple files with multi selection
local custom_action = {}
function custom_action._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local num_selections = #picker:get_multi_selection()
    if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
    end
    actions.send_selected_to_qflist(prompt_bufnr)
    vim.cmd('cfdo ' .. open_cmd)
end
function custom_action.multi_selection_open_vsplit(prompt_bufnr)
    custom_action._multiopen(prompt_bufnr, 'vsplit')
end
function custom_action.multi_selection_open_split(prompt_bufnr)
    custom_action._multiopen(prompt_bufnr, 'split')
end
function custom_action.multi_selection_open_tab(prompt_bufnr)
    custom_action._multiopen(prompt_bufnr, 'tabe')
end
function custom_action.multi_selection_open(prompt_bufnr)
    custom_action._multiopen(prompt_bufnr, 'edit')
end

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
        ['<C-p>'] = 'cycle_history_prev',
        ['<C-n>'] = 'cycle_history_next',
        ['<C-b>'] = 'preview_scrolling_up',
        ['<C-f>'] = 'preview_scrolling_down',
        ['<C-q>'] = 'close',
        ['<M-a>'] = 'toggle_all',
        ['<M-q>'] = 'smart_send_to_qflist',
        ['<M-Q>'] = 'smart_add_to_qflist',
        ['<M-l>'] = 'smart_send_to_loclist',
        ['<M-L>'] = 'smart_add_to_loclist',
        ['<M-y>'] = 'open_qflist',
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
    multi_icon = '',
    path_display = { 'truncate' },
    prompt_prefix = '   ',
    no_ignore = true,
    file_ignore_patterns = {
      '%.git/', 'node_modules/', '%.npm/', '__pycache__/', '%[Cc]ache/',
      '%.dropbox/', '%.dropbox_trashed/', '%.local/share/Trash/', '%.local/',
      '%.py[c]', '%.sw.?', '~$', '%.tags', '%.gemtags', '%.csv$', '%.tsv$',
      '%.tmp', '%.plist$', '%.pdf$', '%.jpg$', '%.JPG$', '%.jpeg$', '%.png$',
      '%.class$', '%.pdb$', '%.dll$', '%.dat$'
    }
  },
  pickers = {
    find_files = {
      mappings = {
        i = {
          ['<CR>'] = custom_action.multi_selection_open,
          ['<C-v>'] = custom_action.multi_selection_open_vsplit,
          ['<C-s>'] = custom_action.multi_selection_open_split,
          ['<C-t>'] = custom_action.multi_selection_open_tab,
        }
      }
    }
  },
  extensions = {
    bookmarks = {
      selected_browser = 'brave',
      url_open_command = 'xdg-open &>/dev/null',
    }
  }
}

function _G.telescope_markdowns()
  builtin.find_files({
    search_dirs = { '$MARKDOWNS' },
    prompt_title = 'Markdowns',
    path_display = function(_, path)
      return path:gsub(vim.fn.expand('$MARKDOWNS'), '')
    end,
  })
end

function _G.telescope_config()
  builtin.find_files({
    search_dirs = { '$HOME/.config/nvim/' },
    prompt_title = 'Neovim config',
    file_ignore_patterns = {
      '.config/nvim/packages/', '.config/nvim/sessions/'
    },
    no_ignore = true,
    hidden = true,
    path_display = function(_, path)
      -- TODO: refactor this truncation function call
      return path:gsub(vim.fn.expand('$HOME/.config/nvim/'), '')
    end,
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
    attach_mappings = function(prompt_bufnr, attach_map)
      -- These two mappings fix issue with custom actions
      attach_map('n', '<CR>', 'select_default')
      attach_map('i', '<CR>', 'select_default')
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

map('n', '<C-p>',      function() return builtin.find_files({hidden = true}) end, 'Find files')
map('n', '<leader>f',  grep_string, 'Grep string')
map('n', '<leader>F',  builtin.live_grep, 'Live grep')
map('n', '<leader>B', builtin.buffers, 'Open buffers')
map('n', '<leader>m',  telescope.extensions.frecency.frecency, 'Recently used files')
map('n', '<leader>h',  builtin.help_tags, 'Help tags')
map('n', '<leader>tt', builtin.builtin, 'Builtin telescope commands')
map('n', '<leader>th', builtin.highlights, 'Highlights')
map('n', '<leader>tm', builtin.keymaps, 'Keymaps')
map('n', '<leader>ts', builtin.lsp_document_symbols, 'LSP document symbols')
map('n', '<leader>tS', builtin.lsp_workspace_symbols, 'LSP workspace symbols')
map('n', '<leader>tr', builtin.resume, 'Resume latest telescope session')
map('n', '<leader>tg', builtin.git_files, 'Find git files')

map('n', 'cd',         telescope_cd, 'Change directory')
map('n', 'cD',         function() return telescope_cd("~") end, 'cd from home directory')
map('n', '<M-z>',      telescope.extensions.zoxide.list, 'Change directory with zoxide')
map('n', '<leader>tb', telescope.extensions.bookmarks.bookmarks, 'Bookmarks')
map('n', '<leader>tc', function() return telescope.extensions.cheat.fd({}) end, 'Cheat.sh')
map('n', '<leader>M',  telescope_markdowns, 'Markdowns')
map('n', '<leader>N',  telescope_config, 'Neovim config')

telescope.load_extension('zoxide')
telescope.load_extension('fzf')
telescope.load_extension('bookmarks')
telescope.load_extension('frecency')
telescope.load_extension('cheat')

--------------
-- Dressing --
--------------
require('dressing').setup {
  select = {
    telescope = {
      theme = 'dropdown'
    }
  },
  input = {
    insert_only = false,
    default_prompt = ' ' -- Doesn't seem to work
  }
}

autocmd.augroup {
  'DressingMappings',
  {{ 'Filetype', {
    DressingInput = function()
      map('i', '<C-j>', '<Down>', { buffer=true, remap=true })
      map('i', '<C-k>', '<Up>', { buffer=true, remap=true })
    end
  }}}
}

---------------
-- Nvim-tree --
---------------
g.nvim_tree_indent_markers = 1
g.nvim_tree_highlight_opened_files = 2
g.nvim_tree_special_files = {}
g.nvim_tree_git_hl = 1
g.nvim_tree_icons = {
  default = '' ,
  git = {
    ignored   = '',
    untracked = '',
    unstaged  = '',
    staged    = '',
    unmerged  = '',
    renamed   = '',
    deleted   = '',
  }
}

local tree_cb = require('nvim-tree.config').nvim_tree_callback
local nvim_tree = require('nvim-tree')

nvim_tree.setup {
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
        { key = 'h', cb = tree_cb('close_node') },
        { key = '>', cb = tree_cb('cd') },
        { key = '<', cb = tree_cb('dir_up') },
        { key = 'd', cb = tree_cb('trash') },
        { key = 'D', cb = tree_cb('remove') },
        { key = '<C-r>', cb = tree_cb('refresh') },
        { key = 'R', cb = tree_cb('full_rename') },
        { key = '<Space>', cb = tree_cb('preview') },
        { key = '<C-s>', cb = tree_cb('split') },
      }
    }
  }
}

autocmd.augroup {
  'NvimTreeRefresh',
  {{ 'BufEnter', {
    NvimTree = nvim_tree.refresh_tree
  }}}
}

map('n', '<leader>`', nvim_tree.toggle, 'Toggle file tree')
map('n', '<leader>~', function() return nvim_tree.find_file(true) end, 'Show current file in file tree')
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

autopairs.setup {
  map_c_h = true
}
autopairs.add_rules {
  rule('$', '$', 'tex'),
  rule('*', '*', 'markdown'),
}

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
map('n', '<F2>', toggle_format_on_write, 'Toggle autoformatting on write')

autocmd.augroup {
  'FormatOnWrite',
  {{ 'BufWritePost', {
    ['*.js,*.json,*.md,*.py,*.ts,*.tsx,*.yml,*.yaml'] = function()
      format_and_write()
    end
  }}}
}

function _G.format_and_write()
  if b.format_on_write ~= false then
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

sign_define('DiagnosticSignError', '')
sign_define('DiagnosticSignWarn',  '')
sign_define('DiagnosticSignHint',  '')
sign_define('DiagnosticSignInfo',  '')

----------------
-- Statusline --
----------------
-- require('floatline').setup()
require('statusline').setup({
  theme = colors,
  modifications = {
    bg = colors.bg0,
    fg = '#c8ccd4',
    line_bg = '#353b45',
    darkgray = '#9ba1b0',
    green = colors.green0,
    blue = colors.blue0,
    orange = colors.orange0,
    purple = colors.purple0,
    red = colors.red0,
    cyan = colors.cyan0,
  }
})

------------
-- Fidget --
------------
require('fidget').setup {
  text = {
    spinner = 'dots',
    done = ''
  }
}

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
    ['x ih'] = ':<C-U>lua require("gitsigns").select_hunk()<CR>',
    ['o ah'] = ':<C-U>lua require("gitsigns").select_hunk()<CR>',
    ['x ah'] = ':<C-U>lua require("gitsigns").select_hunk()<CR>'
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

map({'n', 'v'}, '<C-a>',  '<Plug>(dial-increment)')
map({'n', 'v'}, '<C-x>',  '<Plug>(dial-decrement)')
map('v',        'g<C-a>', '<Plug>(dial-increment-additional)')
map('v',        'g<C-x>', '<Plug>(dial-decrement-additional)')

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

map('n', 'cmm',  '<Plug>kommentary_line_default')
map('n', 'cm',   '<Plug>kommentary_motion_default')
map('n', '<CR>', '<Plug>kommentary_line_default')
map('x', '<CR>', '<Plug>kommentary_visual_default')

function _G.escape()
  if bo.modifiable then
    cmd 'nohlsearch'
  else
    return feedkeys('<C-w>c', 'n')
  end
end

map('n', '<Esc>', escape, 'Close window if not modifiable, otherwise :set nohlsearch')
map('t', '<Esc>', '<C-\\><C-n>')
autocmd.augroup {
  'mappings',
  {{ 'CmdwinEnter', {
    ['*'] = function()
      map('n', '<CR>',  '<CR>',   { buffer = true })
      map('n', '<Esc>', '<C-w>c', { buffer = true })
    end
  }}}
}

local function commentary_append()
  require("ts_context_commentstring.internal").update_commentstring()
  vim.api.nvim_input('A ' .. vim.fn.substitute(opt.commentstring, '%s', '', ''))
end

map('n',        '<leader>cmm', '<Plug>kommentary_line_increase')
map({'n', 'x'}, '<leader>cm',  '<Plug>kommentary_motion_increase')
map('n',        '<leader>cuu', '<Plug>kommentary_line_decrease')
map({'n', 'x'}, '<leader>cu',  '<Plug>kommentary_motion_decrease')
map({'n', 'x'}, '<leader>cy', 'yy<Plug>kommentary_line_increase')
map('n', '<leader>ca', commentary_append, 'Append comment')
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
    http = function()
      map('n', '<CR>', '<Plug>RestNvim:w<CR>', { buffer = true })
      map('n', '<Esc>', '<cmd>BufferClose<CR><cmd>wincmd c<CR>', { buffer = true })
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
map({'n', 'x'}, 'p',     '<Plug>(miniyank-autoput)')
map({'n', 'x'}, 'P',     '<Plug>(miniyank-autoPut)')
map({'n', 'x'}, '<M-p>', '<Plug>(miniyank-cycle)')
map({'n', 'x'}, '<M-P>', '<Plug>(miniyank-cycleback)')

--------------------
-- Stabilize.nvim --
--------------------
require('stabilize').setup()

--------------
-- Diffview --
--------------
local dv_callback = require'diffview.config'.diffview_callback
require('diffview').setup {
  enhanced_diff_hl = false,
  file_panel = {
    width = 40
  },
  file_history_panel = {
    height = 15,
  },
  key_bindings = {
    view = {
      ['<C-j>'] = dv_callback('select_next_entry'),
      ['<C-k>'] = dv_callback('select_prev_entry'),
      ['<C-s>'] = dv_callback('goto_file_split'),
      ['<C-t>'] = dv_callback('goto_file_tab'),
      ['~']     = dv_callback('focus_files'),
      ['`']     = dv_callback('toggle_files'),
      ['H']     = dv_callback('toggle_files'),
    },
    file_panel = {
      ['<Space>'] = dv_callback('select_entry'),
      ['<C-j>']   = dv_callback('select_next_entry'),
      ['<C-k>']   = dv_callback('select_prev_entry'),
      ['<CR>']    = dv_callback('goto_file'),
      ['<C-t>']   = dv_callback('goto_file_tab'),
      ['<Esc>']   = dv_callback('toggle_files')
    },
    file_history_panel = {
      ['!']       = dv_callback('options'),
      ['<CR>']    = dv_callback('open_in_diffview'),
      ['<Space>'] = dv_callback('select_entry'),
      ['<C-j>']   = dv_callback('select_next_entry'),
      ['<C-k>']   = dv_callback('select_prev_entry'),
      ['gf']      = dv_callback('goto_file'),
      ['<C-s>']   = dv_callback('goto_file_split'),
      ['<C-t>']   = dv_callback('goto_file_tab'),
      ['~']       = dv_callback('focus_files'),
      ['H']       = dv_callback('toggle_files')
    },
    option_panel = {
      ['<CR>'] = dv_callback('select')
    }
  }
}

map('n', '<leader>gD', '<cmd>DiffviewOpen<CR>')
map('n', '<leader>gh', '<cmd>DiffviewFileHistory<CR>')
map('n', '<C-c>', function()
  if opt.diff then
    cmd 'tabclose'
  else
    cmd 'DiffviewClose'
  end
end, 'Close diff view')

----------------
-- Lightspeed --
----------------
g.lightspeed_no_default_keymaps = true
require('lightspeed').setup {
  exit_after_idle_msecs = { labeled = 1000 }
}

map({'n', 'o'}, 'zj', '<Plug>Lightspeed_s',  'Lightspeed jump downwards')
map({'n', 'o'}, 'zk', '<Plug>Lightspeed_S',  'Lightspeed jump upwards')
map('o',        'zJ', '<Plug>Lightspeed_x',  'Lightspeed jump downwards (inclusive op)')
map('o',        'zK', '<Plug>Lightspeed_X',  'Lightspeed jump upwards (inclusive op)')
map('n',        'zJ', '<Plug>Lightspeed_gs', 'Lightspeed jump to window above/right')
map('n',        'zK', '<Plug>Lightspeed_gS', 'Lightspeed jump to window below/left')

-- Move default zj/zk bindings to ]z/[z
map('n', ']z', 'zj', 'Jump to next fold using ]z instead of zj')
map('n', '[z', 'zk', 'Jump to previous fold using [z instead of zk')

---------------------
-- General config --
---------------------
map('n', '<leader><C-t>', function()
  bo.bufhidden = 'delete' feedkeys('<C-t>', 'n')
end, 'Delete buffer and pop jump stack')
-- Highlight text object on yank
autocmd.augroup {
  'HighlightYank',
  {{ 'TextYankPost', {
    ['*'] = function()
      vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 350 })
    end
  }}}
}

-- TypeScript specific --
autocmd.augroup {
  'TypeScript',
  {{ 'BufWritePre', {
    ['*.ts,*.tsx'] = function()
      if b.format_on_write ~= false then
        cmd 'TSLspOrganize'
        cmd 'TSLspImportAll'
      end
    end
  }}}
}

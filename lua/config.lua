local cmd, call, fn = vim.cmd, vim.call, vim.fn
local o, g, b = vim.o, vim.g, vim.b
local api = vim.api

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

-- Lua config
local lua_settings = require('lua-dev').setup().settings

-- YAML config
local yaml_settings = {
  yaml = {
    schemaStore = {
      url = 'https://www.schemastore.org/api/json/catalog.json',
      enable = true,
    }
  }
}

require('nvim-lsp-installer').on_server_ready(function(server)
  local opts = make_opts()
  -- print(vim.inspect(server.name))
  if server.name == 'sumneko_lua' then
    opts.settings = lua_settings
  elseif server.name == 'yaml' then
    opts.settings = yaml_settings
  end
  server:setup(opts)
  vim.cmd 'do User LspAttachBuffers'
end)

--------------
 -- lua-dev --
--------------
local luadev = require("lua-dev").setup({})
require('lspconfig').sumneko_lua.setup(luadev)

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
-- require('compe').setup {
--   preselect = 'always',
--   source = {
--     path     = true,
--     calc     = true,
--     nvim_lsp = true,
--     nvim_lua = true,
--     buffer   = {kind = '﬘'},
--     vsnip    = {kind = ' Snippet'},
--     tabnine  = {
--       filetypes = {'markdown', 'text', 'tex', 'gitcommit'},
--       priority = 20,
--     }
--   }
-- }

local function t(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

function _G.tab_complete()
  if fn.pumvisible() == 1 then
    return call 'compe#confirm'
  elseif call 'vsnip#available' == 1 then
    return t '<Plug>(vsnip-expand-or-jump)'
  else
    return t '<C-t>'
  end
end

function _G.s_tab_complete()
  if fn['vsnip#jumpable'](-1) == 1 then
    return t '<Plug>(vsnip-jump-prev)'
  else
    return t '<C-d>'
  end
end

-- Setup nvim-cmp.
local cmp = require('cmp')

local function toggle_complete()
  return function()
    if cmp.visible() then
      cmp.mapping.close()()
    else
      cmp.mapping.complete()()
    end
  end
end

local function complete()
  return function ()
    if cmp.visible() then
      cmp.mapping.confirm({select = true})()
    else
      api.nvim_feedkeys(fn['copilot#Accept'](), 'i', true)
    end
  end
end

cmp.PreselectMode = true

local disabled = cmp.config.disable
local insert = { behavior = cmp.SelectBehavior.Insert }

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(insert), {'i', 'c'}),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(insert), {'i', 'c'}),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ['<C-Space>'] = cmp.mapping(toggle_complete(), {'i', 'c', 's'}),
    ['<Tab>'] = cmp.mapping(complete(), { 'i', 'c' }),
    ['<C-y>'] = disabled,
    ['<C-n>'] = disabled,
    ['<C-p>'] = disabled,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    -- { name = 'cmp_tabnine' },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format()
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    })
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

-- Snippets
map({'i', 's'}, '<M-l>', '<Plug>(vsnip-jump-next)', { noremap = false})
map({'i', 's'}, '<M-h>', '<Plug>(vsnip-jump-prev)', { noremap = false})
map({'i', 's'}, '<C-n>', '<Plug>(vsnip-jump-next)', { noremap = false})
map({'i', 's'}, '<C-p>', '<Plug>(vsnip-jump-prev)', { noremap = false})

-- LSP and diagnostics
map('n',        'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>')
-- map('n',        'gh',        '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
map('n',        'gh',        '<cmd> lua vim.lsp.buf.hover()<cr>')
-- map('n',        'gH',        '<cmd>lua require("lspsaga.diagnostic").show_cursor_diagnostics()<CR>')
map('n',        'gH',        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>')
map('n',        'gD',        '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n',        '1gD',       '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n',        'gs',        '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>')
map({'n', 'x'}, '<leader>r', '<cmd>lua require("lspsaga.rename").rename()<CR>')
map('n',        'gR',        '<cmd>lua vim.lsp.buf.references()<CR>')
map('n',        'g0',        '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n',        'gW',        '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
-- map({'n', 'x'}, 'gA',        '<cmd>lua require("lspsaga.codeaction").code_action()<CR>')
map({'n', 'x'}, 'gA',        '<cmd>lua vim.lsp.buf.code_action()<cr>')
-- map('n',        '[e',        '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>')
map('n',        '[e',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
-- map('n',        ']e',        '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>')
map('n',        ']e',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n',        '<leader>f', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>')

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
    }
  }
}

---------------
-- Nvim-tree --
---------------
local tree_cb = require('nvim-tree.config').nvim_tree_callback

g.nvim_tree_indent_markers = 1
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
  gitignore = false,
  show_icons = {
    git = true,
    folders = true,
    files = true,
  },
  view = {
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
vim.cmd('highlight! link TSError Normal')

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
    ['v <leader>ss'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>su'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>sr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
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
local refactoring = require("refactoring")
refactoring.setup({})

-- Telescope refactoring helper
local function refactor(prompt_bufnr)
  local content = require("telescope.actions.state").get_selected_entry(
    prompt_bufnr
  )
  require("telescope.actions").close(prompt_bufnr)
  require("refactoring").refactor(content.value)
end

-- NOTE: M is a global object
-- for the sake of simplicity in this example
-- you can extract this function and the helper above
-- and then require the file and call the extracted function
-- in the mappings below
M = {}
M.refactors = function()
  local opts = require("telescope.themes").get_cursor() -- set personal telescope options
  require("telescope.pickers").new(opts, {
    prompt_title = "refactors",
    finder = require("telescope.finders").new_table({
      results = require("refactoring").get_refactors(),
    }),
    sorter = require("telescope.config").values.generic_sorter(opts),
    attach_mappings = function(_, mapping)
      mapping("i", "<CR>", refactor)
      mapping("n", "<CR>", refactor)
      return true
    end
  }):find()
end

vim.api.nvim_set_keymap('v',
  'gRe',
  '<Esc><Cmd>lua require("refactoring").refactor("Extract Function")<CR>',
  { silent = true }
)
vim.api.nvim_set_keymap('v',
  'gRf',
  '<Esc><Cmd>lua require("refactoring").refactor("Extract Function To File")<CR>',
  { silent = true }
)
vim.api.nvim_set_keymap('v',
  '<Leader>R',
  '<Esc><Cmd>lua M.refactors()<CR>',
  { noremap = true }
)


--------------------
-- Indent-o-matic --
--------------------
require('indent-o-matic').setup{}

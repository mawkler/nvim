local cmd, call, fn = vim.cmd, vim.call, vim.fn
local o, g, b = vim.o, vim.g, vim.b
local api = vim.api

----------------
-- LSPInstall --
----------------
require('lspinstall').setup()

-- Config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    capabilities = capabilities, -- enable snippet support
    on_attach = function()
      require('lsp_signature').on_attach({
        hi_parameter = 'String',
          handler_opts = {
            border = 'single'   -- double, single, shadow, none
          },
      })
    end
  }
end

-- Lua config
local lua_settings = {
  Lua = {
    diagnostics = {
      globals = {'vim'} -- Make the LSP recognize the `vim` global
    }
  }
}

local servers = require('lspinstall').installed_servers()
for _, server in pairs(servers) do
  local config = make_config()
  if server == 'lua' then
    config.settings = lua_settings
  end
  require('lspconfig')[server].setup(config)
end

-----------
-- Compe --
-----------
o.completeopt = 'menuone,noselect'
require('compe').setup {
  preselect = 'always',
  source = {
    path     = true,
    calc     = true,
    nvim_lsp = true,
    nvim_lua = true,
    buffer   = {kind = '﬘'},
    vsnip    = {kind = ' Snippet'},
    tabnine  = {
      filetypes = {'markdown', 'text', 'tex', 'gitcommit'},
      priority = 20,
    }
  }
}

require('nvim-autopairs.completion.compe').setup {
  map_complete = true -- Auto insert `()` after completing a function or method
}

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

function _G.toggle_complete()
  if fn.pumvisible() == 1 then
    return call 'compe#close'
  else
    return call 'compe#complete'
  end
end

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

-- Completion
map({'i', 's'}, '<Tab>',     'v:lua.tab_complete()',        {expr = true, noremap = false})
map({'i', 's'}, '<S-Tab>',   'v:lua.s_tab_complete()',      {expr = true, noremap = false})
map('i',        '<C-Space>', 'v:lua.toggle_complete()',     {expr = true})
map('i',        '<C-y>',     'compe#scroll({"delta": -2})', {expr = true})
map('i',        '<C-e>',     'compe#scroll({"delta": +2})', {expr = true})
map('i',        '<C-l>',     '<Plug>(vsnip-jump-next)',     {noremap = false})

-- LSP and diagnostics
map('n',        'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n',        'gh',        '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
map('n',        'gD',        '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n',        '1gD',       '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n',        'gs',        '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>')
map({'n', 'x'}, 'gr',        '<cmd>lua require("lspsaga.rename").rename()<CR>')
map('n',        'gR',        '<cmd>lua vim.lsp.buf.references()<CR>')
map('n',        'g0',        '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n',        'gW',        '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map({'n', 'x'}, 'gA',        '<cmd>lua require("lspsaga.codeaction").code_action()<CR>')
map('n',        '[e',        '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>')
map('n',        ']e',        '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>')
map('n',        '<leader>f', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>')

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
    }
  }
}

---------------
-- Nvim-tree --
---------------
local tree_cb = require('nvim-tree.config').nvim_tree_callback
g.nvim_tree_bindings = {
  {key = 'l', cb = tree_cb('edit')},
  {key = 'h', cb = tree_cb('close_node')}
}
g.nvim_tree_disable_netrw = false

---------------
-- Autopairs --
---------------
local rule = require('nvim-autopairs.rule')
local n_pairs = require('nvim-autopairs')

n_pairs.setup()
n_pairs.add_rules {
  rule('$', '$', 'tex'),
  rule('*', '*', 'markdown'),
}

_G.autopairs_cr = n_pairs.autopairs_cr
map('i', '<CR>', 'v:lua.autopairs_cr()', {expr = true})

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
  if b.format_on_write == 0 then
    b.format_on_write = 1
    print 'Format on write enabled'
  else
    b.format_on_write = 0
    print 'Format on write disabled'
  end
end

b.format_on_write = 1
map('n', '<F2>', ':lua toggle_format_on_write()<CR>', {})

api.nvim_exec([[
  augroup FormatOnWrite
    autocmd!
    autocmd BufWritePost *.js,*.json,*.md,*.py,*.ts,*.yml,*.yaml if !exists('b:format_on_write') || b:format_on_write | FormatWrite | endif
  augroup END
]], true)

----------------
-- Statusline --
----------------
require('statusline')

-----------------------
-- Nvim-web-devicons --
-----------------------
require('nvim-web-devicons').setup {
  override = {
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
  },
  default = true
}

----------------
-- Treesitter --
----------------
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    disable = {'latex'},
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
    enable = true
  }
}

---------------
-- Neoscroll --
---------------
require('neoscroll').setup()

----------------
-- Diagnostic --
----------------
local function sign_define(name, symbol)
  fn.sign_define(name, {
    text   = symbol,
    texthl = name,
    linehl = name,
    numhl  = name
  })
end

sign_define('LspDiagnosticsSignError',       '')
sign_define('LspDiagnosticsSignWarning',     '')
sign_define('LspDiagnosticsSignHint',        '')
sign_define('LspDiagnosticsSignInformation', '')

cmd 'hi link LspDiagnosticsSignWarning DiffChange'

--------------
-- Gitsigns --
--------------
require('gitsigns').setup {
  signs = {
    add          = {text = '┃'},
    change       = {text = '┃', hl = 'DiffChange'},
    delete       = {text = '▁'},
    topdelete    = {text = '▔'},
    changedelete = {text = '┃'}
  }
}

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
  ':execute "norm! A " . substitute(&commentstring, "%s", " ", "")<CR>A',
  {silent = true}
)
-- TODO: add <leader>C mapping for commenting everything to the right of the cursor

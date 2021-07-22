local cmd = vim.cmd

-- LSPInstall --
require('lspinstall').setup()

-- Config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    capabilities = capabilities -- enable snippet support
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
  require'lspconfig'[server].setup(config)
end

-- Compe --
vim.o.completeopt = 'menuone,noselect'
require('compe').setup {
  preselect = 'always',
  source = {
    path     = true,
    calc     = true,
    nvim_lsp = true,
    nvim_lua = true,
    buffer   = {kind = '﬘'},
    vsnip    = {kind = '﬌ Snippet'},
    tabnine  = {
      filetypes = {'markdown', 'text', 'tex'},
      priority = 20,
    }
  }
}

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.tab_complete()
  if vim.fn.pumvisible() == 1 then
    return vim.fn['compe#confirm']()
  elseif vim.fn['vsnip#available'] then
    return t '<Plug>(vsnip-expand-or-jump)'
  else
    return t '<C-t>'
  end
end

function _G.s_tab_complete()
  if vim.fn['vsnip#jumpable(-1)'] then
    return t '<Plug>(vsnip-jump-prev)'
  else
    return t '<C-d>'
  end
end

function _G.toggle_complete()
  if vim.fn.pumvisible() == 1 then
    return vim.fn['compe#close']()
  else
    return vim.fn['compe#complete']()
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

-- Mappings --
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Completion
map('i', '<Tab>',     'v:lua.tab_complete()',        {expr = true, noremap = false})
map('s', '<Tab>',     'v:lua.tab_complete()',        {expr = true, noremap = false})
map('i', '<S-Tab>',   'v:lua.s_tab_complete()',      {expr = true, noremap = false})
map('s', '<S-Tab>',   'v:lua.s_tab_complete()',      {expr = true, noremap = false})
map('i', '<C-Space>', 'v:lua.toggle_complete()',     {expr = true})
map('i', '<C-y>',     'compe#scroll({"delta": -2})', {expr = true})
map('i', '<C-e>',     'compe#scroll({"delta": +2})', {expr = true})
map('i', '<C-l>',     '<Plug>(vsnip-jump-next)',     {noremap = false})

-- LSP and diagnostics
map('n', 'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gh',        '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
map('n', 'gD',        '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '1gD',       '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', 'gs',        '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>')
map('n', 'gr',        '<cmd>lua require("lspsaga.rename").rename()<CR>')
map('x', 'gr',        '<cmd>lua require("lspsaga.rename").rename()<CR>')
map('n', 'gR',        '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'g0',        '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n', 'gW',        '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map('n', 'ga',        '<cmd>lua require("lspsaga.codeaction").code_action()<CR>')
map('x', 'ga',        ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>')
map('n', '[e',        '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>')
map('n', ']e',        '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>')
map('n', '<leader>f', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>')

-- lspkind --
require('lspkind').init {
  symbol_map = {
    Class = '',
    Interface = '',
    Module = '',
    Enum = '',
    Text = '',
    Struct = ''
  }
}

-- Telescope --
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

-- nvim-tree --
local tree_cb = require('nvim-tree.config').nvim_tree_callback
vim.g.nvim_tree_bindings = {
  {key = 'l', cb = tree_cb('edit')},
  {key = 'h', cb = tree_cb('close_node')}
}

-- Disable cursor in nvim-tree
require('nvim-tree.view').View.winopts.cursorline = true

_G.nvimTreeEnter = function()
  cmd 'highlight! Cursor blend=100'
  vim.opt.guicursor = {'n:Cursor/lCursor', 'v-c-sm:block', 'i-ci-ve:ver25', 'r-cr-o:hor2'}
end

_G.nvimTreeLeave = function()
  cmd 'highlight! Cursor blend=NONE'
  vim.opt.guicursor = {'n-v-c-sm:block', 'i-ci-ve:ver25', 'r-cr-o:hor20'}
end

cmd 'autocmd WinEnter,BufWinEnter NvimTree lua nvimTreeEnter()'
cmd 'autocmd BufLeave,WinClosed NvimTree lua nvimTreeLeave()'

-- Autopairs --
local rule = require('nvim-autopairs.rule')
local n_pairs = require('nvim-autopairs')

n_pairs.setup()
n_pairs.add_rules {
  rule('$', '$', 'tex'),
  rule('*', '*', 'markdown'),
}

_G.autopairs_cr = n_pairs.autopairs_cr
map('i', '<CR>', 'v:lua.autopairs_cr()', {expr = true})

-- Formatter --
require('formatter').setup {
  logging = false,
  filetype = {
    javascript = {
      function()
        return {
          exe = 'prettier',
          args = {
            '--stdin-filepath', vim.api.nvim_buf_get_name(0), '--single-quote'
          },
          stdin = true
        }
      end
    },
    markdown = {
      function()
        return {
          exe = 'prettier',
          args = {'--stdin-filepath', vim.api.nvim_buf_get_name(0)},
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
  if vim.b.format_on_write == 0 then
    vim.b.format_on_write = 1
    print 'Format on write enabled'
  else
    vim.b.format_on_write = 0
    print 'Format on write disabled'
  end
end

vim.b.format_on_write = 1
map('n', '<F2>', ':lua toggle_format_on_write()<CR>', {})

vim.api.nvim_exec([[
  augroup FormatOnWrite
    autocmd!
    autocmd BufWritePost *.js,*.md,*.py if !exists('b:format_on_write') || b:format_on_write | FormatWrite | endif
  augroup END
]], true)

-- Statusline --
require('statusline')

-- Nvim-web-devicons --
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

-- Treesitter --
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
      set_jumps = true, -- whether to set jumps in the jumplist
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
  }
}

-- Neoscroll --
require('neoscroll').setup()

-- Diagnostic --
local function sign_define(name, symbol)
  vim.fn.sign_define(name, {
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

-- Gitsigns --
require('gitsigns').setup {
  signs = {
    add          = {text = '┃'},
    change       = {text = '┃', hl = 'DiffChange'},
    delete       = {text = '▁'},
    topdelete    = {text = '▔'},
    changedelete = {text = '┃'}
  }
}

---------
-- Cmp --
---------
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'onsails/lspkind-nvim',                -- Completion menu icons
    'saadparwaiz1/cmp_luasnip' ,           -- Snippets
    'hrsh7th/cmp-nvim-lsp',                -- LSP completion
    'hrsh7th/cmp-buffer',                  -- Buffer completion
    'hrsh7th/cmp-path',                    -- Path completion
    'hrsh7th/cmp-cmdline',                 -- Command-line completion
    'hrsh7th/cmp-nvim-lua',                -- Nvim builtins completion
    'hrsh7th/cmp-nvim-lsp-signature-help', -- Signature
    'hrsh7th/cmp-emoji',                   -- Emojis
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    local visible_buffers = require('utils').visible_buffers

    local nvim_cmp = require('cmp')
    local luasnip = require('luasnip')
    local cmp_disabled = nvim_cmp.config.disable
    local cmp_insert = { behavior = nvim_cmp.SelectBehavior.Insert }
    local lspkind = require('lspkind')

    vim.opt.completeopt = 'menuone,noselect'

    local function cmp_map(rhs, modes)
      if (modes == nil) then
        modes = {'i', 'c'}
      else if (type(modes) ~= 'table')
        then modes = {modes} end
      end
      return nvim_cmp.mapping(rhs, modes)
    end

    local function toggle_complete()
      return function()
        if nvim_cmp.visible() then
          nvim_cmp.close()
        else
          nvim_cmp.complete()
        end
      end
    end

    local function complete()
      if nvim_cmp.visible() then
        nvim_cmp.mapping.confirm({select = true})()
      elseif luasnip.expandable() then
        luasnip.expand()
      else
        nvim_cmp.complete()
      end
    end

    local function cmdline_complete()
      if nvim_cmp.visible() then
        nvim_cmp.mapping.confirm({select = true})()
      else
        nvim_cmp.complete()
      end
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

    nvim_cmp.PreselectMode = true

    local sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip', max_item_count = 5 },
      { name = 'nvim_lua' },
      { name = 'path', option = { trailing_slash = true } },
      { name = 'buffer',
        max_item_count = 3,
        keyword_length = 2,
        option = {
          get_bufnrs = visible_buffers, -- Suggest words from all visible buffers
        },
      }
    }
    if not noice_is_loaded() then
      -- Noice has its own signature help
      table.insert(sources, { name = 'nvim_lsp_signature_help' })
    end

    -- LSPKind
    lspkind.init({
      symbol_map = require('utils.icons').icons
    })

    -- Places icon to the left, with margin
    local function cmp_formatting()
      return function(entry, vim_item)
        local format_opts = { mode = 'symbol_text', maxwidth = 50 }
        local kind = lspkind.cmp_format(format_opts)(entry, vim_item)
        local strings = vim.split(kind.kind, '%s', { trimempty = true })

        kind.kind = strings[1] or ''
        kind.menu = '  ' .. (strings[2] or '')

        return kind
      end
    end

    nvim_cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<C-j>'] = cmp_map(nvim_cmp.mapping.select_next_item(cmp_insert)),
        ['<C-k>'] = cmp_map(nvim_cmp.mapping.select_prev_item(cmp_insert)),
        ['<C-b>'] = cmp_map(nvim_cmp.mapping.scroll_docs(-4)),
        ['<C-f>'] = cmp_map(nvim_cmp.mapping.scroll_docs(4)),
        ['<C-Space>'] = cmp_map(toggle_complete(), {'i', 'c', 's'}),
        ['<Tab>'] = nvim_cmp.mapping({
          i = complete,
          c = cmdline_complete,
        }),
        ['<C-y>'] = cmp_disabled,
        ['<C-n>'] = cmp_disabled,
        ['<C-p>'] = cmp_disabled,
      },
      sources = nvim_cmp.config.sources(sources),
      window = {
        completion = {
          col_offset = -2, -- To fit lspkind icon
          side_padding = 1, -- One character margin
        },
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = cmp_formatting(),
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      }
    })

    vim.api.nvim_create_augroup('TabNine', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown', 'text', 'tex', 'gitcommit' },
      callback = function()
        nvim_cmp.setup.buffer({
          sources = nvim_cmp.config.sources(join({{ name = 'cmp_tabnine' }}, sources))
        })
      end,
      group = 'TabNine'
    })

    local enable_cmp_emoji = function()
      nvim_cmp.setup.buffer({
        sources = nvim_cmp.config.sources(join({{ name = 'emoji' }}, sources))
      })
    end

    vim.api.nvim_create_augroup('CmpEmoji', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown', 'text', 'gitcommit' },
      group = 'CmpEmoji',
      callback = enable_cmp_emoji,
    })
    enable_cmp_emoji()

    -- Use buffer source for `/` (searching)
    nvim_cmp.setup.cmdline('/', {
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for `:`
    nvim_cmp.setup.cmdline(':', {
      sources = nvim_cmp.config.sources {
        { name = 'path' },
        { name = 'cmdline' }
      }
    })
  end
}

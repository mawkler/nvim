---------
-- Cmp --
---------
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',                    -- Snippets
    'onsails/lspkind-nvim',                -- Completion menu icons
    'saadparwaiz1/cmp_luasnip' ,           -- Snippets
    'hrsh7th/cmp-nvim-lsp',                -- LSP completion
    'hrsh7th/cmp-buffer',                  -- Buffer completion
    'hrsh7th/cmp-path',                    -- Path completion
    'hrsh7th/cmp-cmdline',                 -- Command-line completion
    'hrsh7th/cmp-nvim-lua',                -- Nvim builtins completion
    'hrsh7th/cmp-nvim-lsp-signature-help', -- Signature
    'zjp-CN/nvim-cmp-lsp-rs',              -- Better rust sorting
    -- 'tzachar/cmp-tabnine'                  -- TabNine
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    local visible_buffers = require('utils').visible_buffers
    local noice_is_loaded = require('utils').noice_is_loaded

    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local cmp_disabled = cmp.config.disable
    local cmp_insert = { behavior = cmp.SelectBehavior.Insert }
    local lspkind = require('lspkind')

    vim.opt.completeopt = 'menuone,noselect'

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
      if cmp.visible() then
        cmp.mapping.confirm({select = true})()
      elseif luasnip.expandable() then
        luasnip.expand()
      else
        cmp.complete()
      end
    end

    local function cmdline_complete()
      if cmp.visible() then
        cmp.mapping.confirm({select = true})()
      else
        cmp.complete()
      end
    end

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
          keyword_pattern = [[\k\+]], -- Support non-ASCII characters
        },
      }
    }
    if not noice_is_loaded() then
      -- Noice has its own signature help
      table.insert(sources, { name = 'nvim_lsp_signature_help' })
    end

    local config_sources = cmp.config.sources(sources)

    -- LSPKind
    lspkind.init({
      symbol_map = require('utils.icons').icons
    })

    -- Better Rust sorting
    local comparators = require('cmp_lsp_rs').comparators
    for _, source in ipairs(config_sources) do
      require('cmp_lsp_rs').filter_out.entry_filter(source)
    end

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

    cmp.PreselectMode = true

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<C-j>'] = cmp_map(cmp.mapping.select_next_item(cmp_insert)),
        ['<C-k>'] = cmp_map(cmp.mapping.select_prev_item(cmp_insert)),
        ['<C-b>'] = cmp_map(cmp.mapping.scroll_docs(-4)),
        ['<C-f>'] = cmp_map(cmp.mapping.scroll_docs(4)),
        ['<C-Space>'] = cmp_map(toggle_complete(), {'i', 'c', 's'}),
        ['<Tab>'] = cmp.mapping({
          i = complete,
          c = cmdline_complete,
        }),
        ['<C-y>'] = cmp_disabled,
        ['<C-n>'] = cmp_disabled,
        ['<C-p>'] = cmp_disabled,
      },
      sources = config_sources,
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
      },
      sorting = {
        comparators = {
          comparators.inscope_inherent_import,
          comparators.sort_by_label_but_underscore_last,
        }
      }
    })

    -- Use buffer source for `/` (searching)
    cmp.setup.cmdline('/', {
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for `:`
    cmp.setup.cmdline(':', {
      sources = cmp.config.sources(
        {
          { name = 'path' }
        },
        {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            },
          },
        }
      )
    })
  end
}

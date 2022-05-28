---------
-- Cmp --
---------
return {
  'hrsh7th/nvim-cmp',
  event = {'InsertEnter', 'CmdlineEnter'},
  config = function()
    local visible_buffers = require('../utils').visible_buffers
    local autocmd = require('../utils').autocmd

    local nvim_cmp = require('cmp')
    local luasnip = require('luasnip')
    local cmp_disabled = nvim_cmp.config.disable
    local cmp_insert = { behavior = nvim_cmp.SelectBehavior.Insert }

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
      { name = 'nvim_lsp_signature_help' },
      { name = 'path', option = { trailing_slash = true } },
      { name = 'buffer',
        max_item_count = 3,
        keyword_length = 2,
        option = {
          get_bufnrs = visible_buffers, -- Suggest words from all visible buffers
        },
      }
    }

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
      formatting = {
        format = require('lspkind').cmp_format()
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      }
    })

    vim.api.nvim_create_augroup('TabNine', {})
    autocmd('FileType', {
      pattern = { 'markdown', 'text', 'tex', 'gitcommit' },
      callback = function()
        nvim_cmp.setup.buffer({
          sources = nvim_cmp.config.sources(join({{ name = 'cmp_tabnine' }}, sources))
        })
      end,
      group = 'TabNine'
    })

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

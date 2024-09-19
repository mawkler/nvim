--------------
-- Barbecue --
--------------
return {
  'utilyre/barbecue.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  config = function()
    local get_highlight = require('utils.colors').get_highlight

    -- Disable for when using multiple LSP servers per buffer
    vim.g.navic_silence = true

    -- Use context highlights based on Treesitter highlights
    local treesitter_contexts = {
      'property',
      'constructor',
      'function',
      'variable',
      'constant',
      'string',
      'number',
      'boolean',
      'operator',
    }

    -- Contexts that don't exist as Treesitter highlights
    local custom_contexts = {
      context_class = '@type',
      context_enum = '@lsp.type.enumMember',
      context_enum_member = '@lsp.type.enumMember',
      context_interface = '@lsp.type.interface',
      context_object = '@type',
      context_key = '@property',
      context_struct = '@lsp.type.struct',
      context_type_parameter = '@lsp.type.typeParameter',
      context_namespace = '@lsp.type.namespace',
      context_method = '@lsp.type.method',
      context_field = '@variable.member',
    }

    local function treesitter_context_highlights()
      local highlights = {}
      for _, name in pairs(treesitter_contexts) do
        local highlight = get_highlight('@' .. name)
        highlights['context_' .. name] = { fg = highlight }
      end
      return highlights
    end

    local function custom_context_highlights()
      return vim.tbl_map(function(context)
        return { fg = get_highlight(context) }
      end, custom_contexts)
    end

    local options = {
      normal = { fg = get_highlight('Comment') },
      basename = { fg = get_highlight('Normal'), bold = true },
    }

    local theme = vim.tbl_extend(
      'error',
      options,
      treesitter_context_highlights(),
      custom_context_highlights()
    )

    -- Setup --
    require('barbecue').setup({
      kinds = require('utils.icons').icons,
      theme = theme,
      exclude_filetypes = { 'markdown', 'toggleterm', 'rest_nvim_result' },
    })
  end
}

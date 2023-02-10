--------------
-- Barbecue --
--------------
return { 'utilyre/barbecue.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'SmiteshP/nvim-navic',
    'kyazdani42/nvim-web-devicons',
  },
  -- event = 'LspAttach', -- Throws error when null-ls attaches for some reason
  -- Temporary fix for https://github.com/utilyre/barbecue.nvim/issues/61
  branch = 'fix/E36',
  config = function()
    local colors = require('utils.colorscheme').colors
    local get_highlight_fg = require('utils.colorscheme').get_highlight_fg

    -- Use context highlights based on Treesitter highlights
    local treesitter_contexts = {
      'namespace',
      'method',
      'property',
      'field',
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
      context_enum = '@type',
      context_enum_member = '@type',
      context_interace = '@type',
      context_object = '@type',
      context_key = '@property',
      context_struct = '@property',
      context_type_parameter = '@type',
    }

    local function treesitter_context_highlights()
      local highlights = {}
      for _, name in pairs(treesitter_contexts) do
        local highlight = get_highlight_fg('@' .. name)
        highlights['context_' .. name] = { fg = highlight }
      end
      return highlights
    end

    local function custom_context_highlights()
      return vim.tbl_map(function(context)
        return { fg = get_highlight_fg(context) }
      end, custom_contexts)
    end

    local options = {
      normal = { fg = colors.fg_dark },
      basename = { fg = colors.fg0, bold = false },
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
    })
  end
}

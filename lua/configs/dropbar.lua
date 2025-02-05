return {
  'Bekaboo/dropbar.nvim',
  dependencies = { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  config = function()
    local api = require('dropbar.api')
    local dropbar_icons = require('dropbar.configs').opts.icons.kinds

    local function hl_exists(name)
      local hl = vim.api.nvim_get_hl(0, { name = name })
      return not vim.tbl_isempty(hl)
    end

    -- Use lspkind-nvim's highlights
    local symbols = {
      'Array', 'Boolean', 'BreakStatement', 'Call', 'CaseStatement', 'Class',
      'Constant', 'Constructor', 'ContinueStatement', 'Declaration', 'Delete',
      'DoStatement', 'ElseStatement', 'Element', 'Enum', 'EnumMember', 'Event',
      'Field', 'File', 'Folder', 'ForStatement', 'Function', 'Identifier',
      'IfStatement', 'Interface', 'Keyword', 'List', 'Macro', 'Method',
      'Module', 'Namespace', 'Null', 'Number', 'Object', 'Operator', 'Package',
      'Pair', 'Property', 'Reference', 'Repeat', 'RuleSet', 'Scope',
      'Specifier', 'Statement', 'String', 'Struct', 'SwitchStatement', 'Table',
      'Terminal', 'Type', 'TypeParameter', 'Unit', 'Value', 'Variable',
      'WhileStatement',
    }

    for _, symbol in pairs(symbols) do
      local cmp_kind_hl = 'CmpItemKind' .. symbol
      local dropbar_hl = 'DropBarIconKind' .. symbol

      if hl_exists(cmp_kind_hl) then
        vim.api.nvim_set_hl(0, dropbar_hl, { link = cmp_kind_hl })
      end
    end

    -- Link Markdown headers to `@markup.heading.x.markdown`
    for i = 1, 6 do
      local marker_hl_name = ('DropBarIconKindH%dMarker'):format(i)
      local markdown_hl_name = ('DropBarIconKindMarkdownH%d'):format(i)
      local link_to_hl = ('@markup.heading.%d.markdown'):format(i)

      vim.api.nvim_set_hl(0, marker_hl_name,   { link = link_to_hl })
      vim.api.nvim_set_hl(0, markdown_hl_name, { link = link_to_hl })
    end

    local function append_space(icons)
      return vim.tbl_map(function(icon)
        return icon .. ' '
      end, icons)
    end

    require('dropbar').setup({
      icons = {
        kinds = {
          dir_icon = function(_)
            -- Use nvim-tree's folder icon highlight
            return dropbar_icons.symbols.Folder, 'NvimTreeFolderIcon'
          end,
          symbols = append_space(require('utils.icons').icons),
        },
        ui = {
          bar = {
            separator = '  ', -- Slightly thinner separator
          }
        }
      },
    })

    vim.keymap.set('n', '<Leader>bb', api.pick,                { desc = 'Pick symbols in winbar' })
    vim.keymap.set('n', '<Leader>b]', api.goto_context_start,  { desc = 'Go to start of current context' })
    vim.keymap.set('n', '<Leader>b[', api.select_next_context, { desc = 'Select next context' })
  end
}

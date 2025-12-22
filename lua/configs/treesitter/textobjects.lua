----------------------------
-- Treesitter textobjects --
----------------------------
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  lazy = false,
  enabled = not vim.g.vscode,
  config = function()
    local keymaps = require('configs.treesitter.keymaps')

    local function include_surrounding_whitespace(selection)
      local included_queries = { '@function', '@class', '@parameter', '@block' }
      local selection_query = selection.query_string

      return vim.iter(included_queries)
          :any(function(query) return selection_query == query .. '.outer' end)
    end

    require('nvim-treesitter-textobjects').setup({
      select = {
        include_surrounding_whitespace = include_surrounding_whitespace,
        enable = true,
        lookahead = true, -- Automatically jump forward to textobject
      },
      move = { set_jumps = true }, -- Add jumps to jumplist
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = require('configs.treesitter.parsers'),
      callback = function(event)
        local disabled_parsers = { 'markdown', 'txt', 'tex', 'html' }
        if vim.tbl_contains(disabled_parsers, event.match) then
          return
        end

        for textobject, query in pairs(keymaps.keymaps) do
          keymaps.create_keymaps(textobject, query)
        end

        -- Special keymaps
        for textobject, query in pairs(keymaps.special_keymaps) do
          keymaps.set_textobject_select_mapping(textobject, query)
        end

        -- Prints the syntax highlighting values under cursor
        vim.keymap.set('n', '<leader>H', '<cmd>Inspect<CR>')
      end,
    })
  end,
}

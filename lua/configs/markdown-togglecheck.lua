--------------------------
-- Markdown Togglecheck --
--------------------------
return {
  'nfrid/markdown-togglecheck',
  dependencies = { 'nfrid/treesitter-utils', 'tpope/vim-repeat' },
  ft = { 'markdown' },
  config = function()
    local map = require('utils').map

    local filetypes = { 'markdown', 'text', 'latex' }

    require('markdown-togglecheck').setup()

    local function toggle_with_repeat()
      vim.go.operatorfunc = "v:lua.require'markdown-togglecheck'.toggle"
      return 'g@l'
    end

    local function create_mappings()
      map('n', '<leader>x', toggle_with_repeat,   { expr = true, buffer = true, desc = 'Toggle checkbox' })
      map('x', '<leader>x', ":'<,'>norm 1 x<cr>", { buffer = true, desc = 'Toggle checkboxes' })
    end

    local augroup = vim.api.nvim_create_augroup('Togglecheck', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      group = augroup,
      callback = create_mappings
    })

    -- Create mappings for current buffer when this plugin gets lazy loaded
    create_mappings()
  end
}

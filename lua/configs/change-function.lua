---------------------
-- Change function --
---------------------
return {
  'SleepySwords/change-function.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    local change_function = require('change-function')

    change_function.setup({
      mappings = {
        move_down = '<M-j>',
        move_up = '<M-k>',
      },
    })

    vim.keymap.set('n', 'cA', change_function.change_function_via_lsp_references)
  end
}

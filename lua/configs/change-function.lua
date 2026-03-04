---------------------
-- Change function --
---------------------
local function lsp_change_function()
  require('change-function').change_function_via_lsp_references()
end

return {
  'SleepySwords/change-function.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  keys = {
    { 'cA', lsp_change_function, mode = 'n' }
  },
  config = function()
    local change_function = require('change-function')

    change_function.setup({
      mappings = {
        move_down = '<M-j>',
        move_up = '<M-k>',
      },
    })
  end
}

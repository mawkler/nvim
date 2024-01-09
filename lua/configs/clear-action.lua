------------------
-- Clear action --
------------------
return {
  'luckasRanarison/clear-action.nvim',
  event = 'LspAttach',
  opts = {
    mappings = {
      code_action = '<leader>a',
    },
    signs = {
      icons = {
        quickfix = '襁',
        refactor = '',
        source = '',
        combined = '',
      },
    },
    popup = {
      hide_cursor = true,
    },
  }
}

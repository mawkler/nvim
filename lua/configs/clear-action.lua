------------------
-- Clear action --
------------------
return {
  'luckasRanarison/clear-action.nvim',
  event = 'LspAttach',
  opts = {
    silent = true, -- solves the issue with multiple language clients?
    mappings = {
      code_action = '<leader>a',
    },
    signs = {
      icons = {
        quickfix = '襁',
        refactor = '',
        source = ' ',
        combined = '',
      },
    },
    popup = {
      hide_cursor = true,
    },
  }
}

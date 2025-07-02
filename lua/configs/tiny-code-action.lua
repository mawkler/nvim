----------------------
-- Tiny Code Action --
----------------------

local function code_action()
  require('tiny-code-action').code_action({})
end

return {
  'rachartier/tiny-code-action.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    { '<leader>a', code_action, mode = { 'n', 'x' }, desc = 'Code action' },
  },
  config = function()
    require('tiny-code-action').setup({
      picker = {
        'buffer',
        opts = {
          hotkeys = true,
          hotkeys_mode = 'text_diff_based',
          winborder = 'rounded',
        },
      },
      backend = 'delta',
      backend_opts = {
        delta = {
          header_lines_to_remove = 7,
          args = { '--features=no-line-numbers' },
        }
      },
    })

    local augroup = vim.api.nvim_create_augroup('TinyCodeActionCustom', {})

    vim.api.nvim_create_autocmd('User', {
      pattern = {
        'TinyCodeActionWindowEnterMain',
        'TinyCodeActionWindowEnterPreview',
      },
      group = augroup,
      callback = function(event)
        vim.o.concealcursor = 'nvic'
        vim.keymap.set('n', '<Esc>', 'q', { remap = true, buffer = event.buf })
      end,
    })
  end
}

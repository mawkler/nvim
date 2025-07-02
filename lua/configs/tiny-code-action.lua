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
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'TinyCodeActionWindowEnterMain',
      callback = function()
        vim.o.concealcursor = 'nvic'
      end,
    })
  end
}

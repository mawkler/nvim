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
          position = 'cursor',
          winborder = 'rounded',
          conceallevel = 2,
          keymaps = {
            close = '<Esc>',
          },
          custom_keys = {
            { pattern = 'Add `#%[derive%]`',                     key = 'd' },
            { pattern = 'Change visibility to pub',              key = 'p' },
            { pattern = 'Consider making this binding mutable:', key = 'm' },
            { pattern = 'Extract into%.%.%.',                    key = 'x' },
            { pattern = 'Extract into function',                 key = 'f' },
            { pattern = 'Extract into variable',                 key = 'v' },
            { pattern = 'Extract into static',                   key = 's' },
            { pattern = 'Extract into constant',                 key = 'c' },
            { pattern = 'Fill match arms',                       key = 'm' },
            { pattern = 'Generate `new`',                        key = 'n' },
            { pattern = 'Generate impl for',                     key = 'i' },
            { pattern = 'Generate trait impl for',               key = 't' },
            { pattern = 'Remove all unused imports',             key = 'R' },
            { pattern = 'Implement default members',             key = 'im' },
          },
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
      group = augroup,
      pattern = 'TinyCodeActionWindowEnterMain',
      callback = function(event)
        vim.o.concealcursor = 'nvic'
        vim.o.cursorline = true
        vim.keymap.set('n', '<Space>', '<CR>', { remap = true, buffer = event.buf, nowait = true })
      end,
    })
  end
}

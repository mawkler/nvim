----------------
-- FastAction --
----------------
return {
  'Chaitanyabsprip/fastaction.nvim',
  keys = {
    { '<leader>a', function() require('fastaction').code_action() end, mode = { 'n', 'x' }, desc = 'LSP code action' },
  },
  opts = {
    dismiss_keys = { '<C-c>', '<Esc>' },
    keys = 'qwertyuiopasdfghjklzxcvbnm',
    priority = {
      rust = {
        { pattern = 'fill match arms',                       key = 'm' },
        { pattern = 'add `#%[derive%]`',                     key = 'd' },
        { pattern = 'consider making this binding mutable:', key = 'm' },
        { pattern = 'change visibility to pub',              key = 'p' },
        { pattern = 'generate `new`',                        key = 'n' },
        { pattern = 'extract into variable',                 key = 'x' },
        { pattern = 'extract into function',                 key = 'f' },
        { pattern = 'consider',                              key = 'c' },
        { pattern = 'change this to:',                       key = 'c' },
        { pattern = 'remove all the unused imports',         key = 'R' },
        { pattern = 'generate impl for',                     key = 'i' },
        { pattern = 'generate trait impl for',               key = 't' },
        { pattern = 'try ',                                  key = 't' },
        { pattern = 'implement missing members',             key = 'i' },
        { pattern = 'import `',                              key = 'i' },
        { pattern = 'inline ',                               key = 'i' },
      },
      ltex = {
        { pattern = "add '", key = 'F' },
      },
    },
    -- Fixes error thrown when code action list exceeds a threshold
    register_ui_select = true,
  },
}

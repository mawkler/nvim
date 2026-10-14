-----------------
-- Claude Code --
-----------------
return {
  'coder/claudecode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  config = true,
  opts = {
    terminal = {
      snacks_win_opts = {
        keys = {
          claude_window_prefix = {
            '<C-w>',
            function()
              vim.api.nvim_input('<C-\\><C-n><C-w>')
            end,
            mode = 't',
            desc = 'Window commands',
          },
        },
      },
    },
  },
  cmd = {
    'ClaudeCode',
    'ClaudeCodeFocus',
    'ClaudeCodeSelectModel',
    'ClaudeCodeAdd',
    'ClaudeCodeSend',
    'ClaudeCodeTreeAdd',
    'ClaudeCodeStatus',
    'ClaudeCodeStart',
    'ClaudeCodeStop',
    'ClaudeCodeOpen',
    'ClaudeCodeClose',
    'ClaudeCodeDiffAccept',
    'ClaudeCodeDiffDeny',
    'ClaudeCodeCloseAllDiffs',
  },
  keys = {
    { '<leader>CC', '<cmd>ClaudeCode<CR>',            desc = 'Toggle Claude' },
    { '<leader>Cf', '<cmd>ClaudeCodeFocus<CR>',       desc = 'Focus Claude' },
    { '<leader>Cr', '<cmd>ClaudeCode --resume<CR>',   desc = 'Resume Claude' },
    { '<leader>Cc', '<cmd>ClaudeCode --continue<CR>', desc = 'Continue Claude' },
    { '<leader>Cm', '<cmd>ClaudeCodeSelectModel<CR>', desc = 'Select Claude model' },
    { '<leader>Cb', '<cmd>ClaudeCodeAdd %<CR>',       desc = 'Add current buffer' },
    { '<leader>CC', '<cmd>ClaudeCodeSend<CR>',        desc = 'Send to Claude',     mode = 'x' },
    { '<leader>Ca', '<cmd>ClaudeCodeDiffAccept<CR>',  desc = 'Accept diff' },
    { '<leader>Cd', '<cmd>ClaudeCodeDiffDeny<CR>',    desc = 'Deny diff' },
    {
      '<leader>Cs',
      '<cmd>ClaudeCodeTreeAdd<CR>',
      desc = 'Add file',
      ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw', 'snacks_picker_list' },
    },
  },
}

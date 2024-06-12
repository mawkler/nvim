------------------
-- Comment.nvim --
------------------
---@diagnostic disable: missing-fields
return {
  'numToStr/Comment.nvim',
  keys = {
    { 'cm',         '<Plug>(comment_toggle_linewise_current)' },
    { '<leader>c',  '<Plug>(comment_toggle_linewise)' },
    { '<leader>c',  '<Plug>(comment_toggle_linewise_visual)', mode = 'x' },
    { '<leader>C',  '<Plug>(comment_toggle_linewise)$' },
    { '<leader>cB', '<Plug>(comment_toggle_blockwise)$' },
    { '<leader>cb', '<Plug>(comment_toggle_blockwise)' },
    { '<leader>b',  '<Plug>(comment_toggle_blockwise_visual)', mode = 'x' },
    { '<leader>cc', '<Plug>(comment_toggle_linewise)' },
    { '<leader><', mode = 'x' },
    { '<leader>>', mode = 'x' },
    '<leader>cp',
  },
  dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
  config = function()
    local map = require('utils').map
    local ts_context_integration = require(
      'ts_context_commentstring.integrations.comment_nvim'
    )

    require('Comment').setup({
      mappings = {
        basic = false,
      },
      toggler = {
        line = '<leader>cc',
        block = '<leader>cbb'
      },
      opleader = {
        line = '<leader>c',
      },
      extra = {
        above = '<leader>cO',
        below = '<leader>co',
        eol = '<leader>cA'
      },
      ignore = '^$', -- Ignore empty lines
      pre_hook = ts_context_integration.create_pre_hook(),
    })

    local comment_api = require('Comment.api')
    local function comment_map(modes, lhs, command, operator_pending)
      map(modes, lhs, function()
        local operator = operator_pending and 'g@' or 'g@$'
        comment_api.call(command, operator)
      end, command)
    end

    comment_map('n', '<leader>c>',   'comment_linewise_op', true)
    comment_map('n', '<leader>c>>',  'comment_current_linewise_op')
    comment_map('n', '<leader>cb>>', 'comment_current_blockwise_op')
    comment_map('x', '<leader>>',    'comment_current_linewise_op')

    comment_map('n', '<leader>c<',   'uncomment_linewise_op', true)
    comment_map('n', '<leader>cu',   'uncomment_linewise_op', true)
    comment_map('n', '<leader>c<<',  'uncomment_current_linewise_op')
    comment_map('n', '<leader>cb<<', 'uncomment_current_blockwise_op')
    comment_map('x', '<leader><',    'uncomment_current_linewise_op')


    -- For some reason, putting this in lazy's `keys` doesn't work. I'm
    -- guessing that Lazy doesn't get the `remap` right
    map('n', '<leader>cp', 'yycmp', {
      remap = true, desc = 'Comment and duplicate line'
    })
  end,
}

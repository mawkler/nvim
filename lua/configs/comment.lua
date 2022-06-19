------------------
-- Comment.nvim --
------------------
return { 'numToStr/Comment.nvim',
  keys = {
    {'n', '<leader>c'},
    {'x', '<leader>c'},
    {'n', '<leader>C'},
    {'x', '<leader><'},
    {'x', '<leader>>'},
    {'x', '<leader>b'},
    {'n', 'cm'},
  },
  config = function()
    local map, feedkeys = require('utils').map, require('utils').feedkeys

    require('Comment').setup {
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
      pre_hook = function(ctx)
        if vim.bo.filetype == 'typescriptreact' then
          local c_utils = require('Comment.utils')
          local ts_context_utils = require('ts_context_commentstring.utils')
          local type = ctx.ctype == c_utils.ctype.line and '__default' or '__multiline'
          local location

          if ctx.ctype == c_utils.ctype.block then
            location = ts_context_utils.get_cursor_location()
          elseif ctx.cmotion == c_utils.cmotion.v or ctx.cmotion == c_utils.cmotion.V then
            location = ts_context_utils.get_visual_start_location()
          end

          return require('ts_context_commentstring.internal').calculate_commentstring({
            key = type,
            location = location
          })
        end
      end
    }

    local comment_api = require('Comment.api')
    local function comment_map(modes, lhs, command, operator_pending)
      map(modes, lhs, function()
        comment_api.call(command)
        if not operator_pending then
          feedkeys('g@$')
        else
          feedkeys('g@')
        end
      end, command)
    end

    map('n', '<leader>C',  '<Plug>(comment_toggle_linewise)$')
    map('n', '<leader>cB', '<Plug>(comment_toggle_blockwise)$')
    map('n', '<leader>cb', '<Plug>(comment_toggle_blockwise)')
    map('x', '<leader>b',  '<Plug>(comment_toggle_blockwise_visual)')
    map('n', 'cm',         '<Plug>(comment_toggle_current_linewise)')
    map('n', '<leader>cp', 'yycmp', {remap = true})

    comment_map('n', '<leader>c>',   'comment_linewise_op', true)
    comment_map('n', '<leader>c>>',  'comment_current_linewise_op')
    comment_map('n', '<leader>cb>>', 'comment_current_blockwise_op')
    comment_map('x', '<leader>>',    'comment_current_linewise_op')

    comment_map('n', '<leader>c<',   'uncomment_linewise_op', true)
    comment_map('n', '<leader>cu',   'uncomment_linewise_op', true)
    comment_map('n', '<leader>c<<',  'uncomment_current_linewise_op')
    comment_map('n', '<leader>cb<<', 'uncomment_current_blockwise_op')
    comment_map('x', '<leader><',    'uncomment_current_linewise_op')
  end,
}

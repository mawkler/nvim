---------------
-- Neoscroll --
---------------
return {
  'karb94/neoscroll.nvim',
  event = 'WinScrolled',
  cond = function() return not vim.g.neovide end,
  config = function()
    local neoscroll = require('neoscroll')
    local map = require('utils').map

    require('neoscroll').setup({ easing_function = 'cubic' })

    local scroll_speed = 70
    local nx = { 'n', 'x' }

    map(nx, '<C-u>', function() neoscroll.ctrl_u({ duration = scroll_speed }) end)
    map(nx, '<C-d>', function() neoscroll.ctrl_d({ duration = scroll_speed }) end)
    map(nx, '<C-b>', function() neoscroll.ctrl_b({ duration = scroll_speed }) end)
    map(nx, '<C-f>', function() neoscroll.ctrl_f({ duration = scroll_speed }) end)
    map(nx, 'zt',    function() neoscroll.zt({ half_win_duration = scroll_speed, easing = 'sine' }) end)
    map(nx, 'zz',    function() neoscroll.zz({ half_win_duration = scroll_speed, easing = 'sine' }) end)
    map(nx, 'zb',    function() neoscroll.zb({ half_win_duration = scroll_speed, easing = 'sine' }) end)
    map(nx, '<C-y>', function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 }) end)
    map(nx, '<C-e>', function() neoscroll.scroll(0.1,  { move_cursor = false, duration = 100 }) end)
  end
}

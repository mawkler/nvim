---------------
-- Neoscroll --
---------------
return { 'karb94/neoscroll.nvim',
  event = 'WinScrolled',
  cond = function() return not vim.g.neovide end,
  config = function()
    local scroll_speed = 140
    local plugin_setup = require('utils').plugin_setup

    plugin_setup('neoscroll', { easing_function = 'cubic' })
    import('neoscroll.config', function(config)
      config.set_mappings({
        ['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', scroll_speed}},
        ['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', scroll_speed}},
        ['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', scroll_speed}},
        ['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', scroll_speed}},
        ['zt']    = {'zt', {scroll_speed}, 'sine'},
        ['zz']    = {'zz', {scroll_speed}, 'sine'},
        ['zb']    = {'zb', {scroll_speed}, 'sine'},
      })
    end)
  end
}

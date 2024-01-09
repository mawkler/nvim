local g = vim.g

if vim.fn.exists('g:neovide') == 1 then
  g.neovide_floating_blur_amount_x = 3.0
  g.neovide_floating_blur_amount_y = 3.0
  g.neovide_cursor_trail_size = 0.7
  g.neovide_scroll_animation_length = 0.06
  g.neovide_cursor_animate_command_line = true
end

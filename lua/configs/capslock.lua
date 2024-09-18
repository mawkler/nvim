--------------
-- Capslock --
--------------

local function reload_statusline()
  vim.opt.statusline = vim.opt.statusline
end

local function toggle_caps_lock()
  local mode = vim.fn.mode()
  require('capslock').toggle(mode)
  reload_statusline()
end

return {
  'barklan/capslock.nvim',
  keys = {
    { '<M-c>', toggle_caps_lock, mode = { 'i', 'c' } },
  },
  opts = {}
}

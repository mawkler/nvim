--------------
-- Capslock --
--------------
return {
  'barklan/capslock.nvim',
  keys = {
    { '<M-c>', mode = 'i' },
  },
  config = function()
    require('capslock').setup()

    local function reload_statusline()
      vim.opt.statusline = vim.opt.statusline
    end

    local function caps_lock()
      require('capslock').toggle()
      reload_statusline()
    end

    vim.keymap.set('i', '<M-c>', caps_lock)
  end
}

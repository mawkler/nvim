-----------------
-- Vim-session --
-----------------
return { 'xolox/vim-session',
  requires = {'xolox/vim-misc'},
  after = 'vim-startify',
  config = function()
    vim.g.session_autosave = 'yes'
    vim.g.session_autosave_periodic = 1
    vim.g.session_autosave_silent = 1
    vim.g.session_default_overwrite = 1
    vim.g.session_autoload = 'no'
    vim.g.session_lock_enabled = 0
    vim.g.session_directory = vim.g.startify_session_dir
  end
}

---------
-- TSC --
---------
return {
  'dmmulroy/tsc.nvim',
  cmd = 'TSC',
  opts = {
    auto_open_qflist = false,
    spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
    flags = {
      skipLibCheck = true,
    },
  }
}

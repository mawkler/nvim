--------------------------
-- Mason Tool Installer --
--------------------------
return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = {
    ensure_installed = require('utils').is_nixos() and {} or {
      'prettier',
      'vacuum',
      'codelldb', -- Used by rustaceanvim
      'vimls',
      'lemminx',
      'js-debug-adapter',
      'go-debug-adapter',
      'bash-debug-adapter',
      'delve',
      'mdsf',
    },
  }
}

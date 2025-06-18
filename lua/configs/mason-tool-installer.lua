--------------------------
-- Mason Tool Installer --
--------------------------
return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = {
    ensure_installed = {
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

--------------------------
-- Mason Tool Installer --
--------------------------
return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = {
    ensure_installed = {
      'prettier',
      'vacuum',
      'zk',
      'codelldb', -- Used by rustaceanvim
      'vimls',
      'lemminx',
      'js-debug-adapter',
      'go-debug-adapter',
      'bash-debug-adapter',
      'delve',
    },
  }
}

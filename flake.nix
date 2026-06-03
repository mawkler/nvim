{
  description = "Mawkler's Neovim configuration";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { ... }:
    {
      nixosModules.default =
        { pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [
            neovim

            # General dependencies
            ascii-image-converter
            gcc
            lua5_1
            lua51Packages.tree-sitter-cli
            luarocks
            neovide

            # Language servers
            bash-language-server
            bicep-lsp
            fish-lsp
            gopls
            hyprls
            just-lsp
            kdePackages.qtdeclarative # qmlls
            languagetool
            lemminx
            ltex-ls-plus
            lua-language-server
            nil
            nixd
            vscode-json-languageserver
            python312Packages.python-lsp-server
            rust-analyzer
            taplo
            tinymist
            typescript-language-server
            typos-lsp
            vim-language-server
            vscode-extensions.dbaeumer.vscode-eslint
            yaml-language-server
            zk

            # Formatters
            keep-sorted
            mdsf
            nixfmt
            prettierd
            shfmt
            rumdl
            kdlfmt

            # Linters
            vacuum-go

            # Debugger adapters
            delve
            lldb
            vscode-extensions.golang.go
            vscode-js-debug
            # bash-debug-adapter # Doesn't exist

            # Plugin dependencies
            mailcap # rest.nvim
          ];
        };
    };
}

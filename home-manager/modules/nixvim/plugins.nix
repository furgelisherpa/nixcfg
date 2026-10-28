{
  config,
  pkgs,
  ...
}: {
  # --- module: nixvim/plugins.nix -----------------------------------------
  # General-purpose plugins + the colorscheme: the file explorer, tree-sitter
  # (syntax/indent), comments, surround/autopairs, devicons, statusline.
  # LSP/completion/format/lint live in their own files (lsp.nix, etc.).

  programs.nixvim = {
    extraPackages = with pkgs; [
      glib
    ];

    plugins = {
      # Syntax highlighting / indentation via tree-sitter
      treesitter = {
        enable = true;
        settings = {
          sync_install = false;
          highlight.enable = true;
          indent.enable = true;
        };

        # Languages to install parsers for
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          nix
          bash
          c
          cpp
          css
          dockerfile
          html
          javascript
          json
          lua
          markdown
          markdown_inline
          python
          query
          regex
          rust
          toml
          tsx
          typescript
          vim
          vimdoc
          yaml
        ];
      };

      # Treesitter-aware comment toggling
      ts-comments = {
        enable = true;
        settings = {
          keymaps = {
            line = "gl";
            block = "gb";
          };
        };
      };

      nvim-surround.enable = true;
      ts-autotag.enable = true;
      nvim-autopairs.enable = true;
      web-devicons.enable = true;
      flutter-tools.enable = true;
      lazygit.enable = true;
      gitsigns.enable = true;
      multicursors.enable = true;
    };
  };
}

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

    # Colorscheme
    colorschemes.gruvbox-material-nvim = {
      enable = true;

      settings = {
        background = {
          transparent = false;
        };
        comments = {
          italics = false;
        };
        contrast = "hard";
        float = {
          force_background = false;
        };
        italics = false;
        signs = {
          force_background = false;
        };
      };
    };

    plugins = {
      # File explorer sidebar
      nvim-tree = {
        enable = true;

        settings = {
          view = {
            width = 30;
            side = "left";
            relativenumber = false;
          };

          renderer = {
            group_empty = true;
            highlight_git = true;
            icons.show = {
              file = true;
              folder = true;
              folder_arrow = true;
              git = true;
            };
          };

          filters = {
            dotfiles = false;
            custom = [
              "^\\.git$"
              "^node_modules$"
              "^\\.cache$"
            ];
          };

          actions = {
            open_file = {
              quit_on_open = false;
            };
          };
        };
      };

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
      lualine.enable = true;
    };

    # Keymap lives here, next to the plugin it controls
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>NvimTreeToggle<CR>";
        options = {
          desc = "Toggle NvimTree";
          silent = true;
        };
      }
    ];
  };
}

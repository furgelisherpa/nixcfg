{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [fd ripgrep];

    plugins.telescope = {
      enable = true;

      extensions.fzf-native.enable = true;
      extensions.ui-select.enable = true;

      settings = {
        defaults = {
          prompt_prefix = "  ";
          selection_caret = " ";
          path_display = ["truncate"];
          layout_strategy = "horizontal";
          sorting_strategy = "ascending";

          layout_config = {
            prompt_position = "top";
            preview_cutoff = 1;
            height = 0.4;
            width = 0.6;
          };

          vimgrep_arguments = [
            "rg"
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
            "--hidden"
            "--glob"
            "!.git/*"
          ];

          file_ignore_patterns = [
            "%.git/"
            "node_modules/"
            "%.cache/"
          ];

          mappings = {
            i = {
              "<C-j>" = {__raw = "require('telescope.actions').move_selection_next";};
              "<C-k>" = {__raw = "require('telescope.actions').move_selection_previous";};
              "<C-u>" = {__raw = "require('telescope.actions').preview_scrolling_up";};
              "<C-d>" = {__raw = "require('telescope.actions').preview_scrolling_down";};
              "<esc>" = {__raw = "require('telescope.actions').close";};
            };
          };
        };

        pickers = {
          # Use fd for file search, excluding .git
          find_files = {
            previewer = false;
            find_command = [
              "fd"
              "--type"
              "f"
              "--hidden"
              "--strip-cwd-prefix"
              "--exclude"
              ".git"
            ];
          };
          buffers = {
            previewer = false;
            sort_lastused = true;
            mappings.i."<C-d>" = {__raw = "require('telescope.actions').delete_buffer";};
          };
          oldfiles = {
            previewer = false;
            sort_lastused = true;
          };
          live_grep = {
            layout_config = {
              height = 0.8;
              width = 0.8;
            };
          };
        };
      };
    };

    # <leader>f
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>f";
        group = "Find";
        icon = "󰍉 ";
      }
    ];

    keymaps = [
      # Files
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          desc = "Find files";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fo";
        action = "<cmd>Telescope oldfiles<CR>";
        options = {
          desc = "Recently opened files";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options = {
          desc = "Find buffers";
          silent = true;
        };
      }

      # Grep
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options = {
          desc = "Live grep";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fw";
        action = "<cmd>Telescope grep_string<CR>";
        options = {
          desc = "Grep word under cursor";
          silent = true;
        };
      }

      # Git
      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>Telescope git_commits<CR>";
        options = {
          desc = "Git commits";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fB";
        action = "<cmd>Telescope git_branches<CR>";
        options = {
          desc = "Git branches";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fS";
        action = "<cmd>Telescope git_status<CR>";
        options = {
          desc = "Git status";
          silent = true;
        };
      }

      # LSP-backed pickers
      {
        mode = "n";
        key = "<leader>fR";
        action = "<cmd>Telescope lsp_references<CR>";
        options = {
          desc = "LSP references";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fd";
        action = "<cmd>Telescope diagnostics<CR>";
        options = {
          desc = "Diagnostics";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fy";
        action = "<cmd>Telescope lsp_document_symbols<CR>";
        options = {
          desc = "Document symbols";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fY";
        action = "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>";
        options = {
          desc = "Workspace symbols";
          silent = true;
        };
      }

      # Meta
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        options = {
          desc = "Help tags";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fk";
        action = "<cmd>Telescope keymaps<CR>";
        options = {
          desc = "Keymaps";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope resume<CR>";
        options = {
          desc = "Resume last search";
          silent = true;
        };
      }
    ];
  };
}

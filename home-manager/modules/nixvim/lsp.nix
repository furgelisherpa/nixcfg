{pkgs, ...}: {
  programs.nixvim = {
    diagnostic = {
      settings = {
        virtual_text = {
          prefix = "●";
          spacing = 4;
        };

        underline = true;
        signs = true;
        severity_sort = true;
        update_in_insert = true;
        float = {
          border = "rounded";
          source = "always";
        };
      };
    };

    # LSP servers + tools they need
    extraPackages = with pkgs; [
      nixd
      typescript
    ];

    plugins = {
      # Completion engine
      blink-cmp = {
        enable = true;

        settings = {
          completion = {
            list = {
              selection = {
                preselect = false;
                auto_insert = false;
              };
            };
          };

          keymap = {
            preset = "none";

            "<C-n>" = ["select_next" "fallback"];
            "<C-p>" = ["select_prev" "fallback"];
            "<CR>" = ["accept" "fallback"];
            "<C-b>" = ["scroll_documentation_up" "fallback"];
            "<C-f>" = ["scroll_documentation_down" "fallback"];
            "<C-space>" = ["show" "show_documentation" "hide_documentation"];
            "<C-e>" = ["hide" "fallback"];
          };

          sources = {
            default = ["lsp" "path" "snippets" "buffer"];
          };

          completion = {
            menu = {
              border = "none";
              draw = {
                columns = [
                  ["kind_icon"]
                  ["label" "label_description"]
                  ["source_name"]
                ];
              };
            };
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 200;
              window = {
                border = "none";
              };
            };
          };
          fuzzy.implementation = "prefer_rust_with_warning";
        };
      };

      lsp = {
        enable = true;
        inlayHints = true;

        # <leader>lf is intentionally absent here - format lives in formatting.nix
        keymaps = {
          silent = true;

          lspBuf = {
            "K" = "hover";
            "<leader>ld" = "definition";
            "<leader>lD" = "declaration";
            "<leader>lR" = "references";
            "<leader>lI" = "implementation";
            "<leader>ls" = "signature_help";
            "<leader>la" = "code_action";
            "<leader>lr" = "rename";
          };
          diagnostic = {
            "gl" = "open_float";
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>lj" = "goto_next";
            "<leader>lk" = "goto_prev";
            "<leader>ld" = "open_float";
            "<leader>lq" = "setloclist";
          };
        };

        # Language servers to enable
        servers = {
          nixd = {
            enable = true;

            settings = {
              formatting = {
                command = ["alejandra"];
              };
              diagnostic = {
                suppress = [
                  "eval-cache-miss"
                ];
              };
            };
          };

          tsgo.enable = true;
        };
      };

      luasnip.enable = true;
      friendly-snippets.enable = true;
    };

    # <leader>l = LSP
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>l";
        group = "LSP";
        icon = "󰒕 ";
      }
    ];
  };
}

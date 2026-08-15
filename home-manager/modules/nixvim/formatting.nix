{pkgs, ...}: {
  programs.nixvim = {
    # Formatter binaries used below
    extraPackages = with pkgs; [
      alejandra
      prettierd
      stylua
    ];

    plugins.conform-nvim = {
      enable = true;

      settings = {
        # Map filetype -> formatters to run
        formatters_by_ft = {
          nix = ["alejandra"];
          javascript = ["prettierd"];
          typescript = ["prettierd"];
          javascriptreact = ["prettierd"];
          typescriptreact = ["prettierd"];
          json = ["prettierd"];
          html = ["prettierd"];
          css = ["prettierd"];
          lua = ["stylua"];
          "_" = ["squeeze_blanks" "trim_whitespace"];
        };

        # Format automatically on save unless explicitly disabled
        format_on_save = ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end
            return { lsp_fallback = true }
          end
        '';
        lsp_fallback = false;
      };
    };

    keymaps = [
      {
        mode = ["n" "v"];
        key = "<leader>cf";
        action = ''
          function()
            require("conform").format({ async = true, lsp_fallback = true })
          end
        '';
        options = {
          desc = "Format buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ce";
        action = "<cmd>g/^$/d<cr>";
        options = {
          desc = "Remove Empty Lines";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ci";
        action = "<cmd>norm gg=G<cr>";
        options = {
          desc = "Reindent Entire Buffer";
          silent = true;
        };
      }
    ];

    # Commands to toggle format-on-save globally or per-buffer
    extraConfigLua = ''
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, { desc = "Disable autoformat-on-save", bang = true })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, { desc = "Re-enable autoformat-on-save" })
    '';
  };
}

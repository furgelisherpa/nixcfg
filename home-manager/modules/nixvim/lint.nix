{pkgs, ...}: {
  programs.nixvim = {
    # Linter binaries used below
    extraPackages = with pkgs; [
      statix
      deadnix
      eslint_d
    ];

    plugins.lint = {
      enable = true;

      # Map filetype -> linters to run
      lintersByFt = {
        nix = ["statix" "deadnix"];
        javascript = ["eslint_d"];
        typescript = ["eslint_d"];
        javascriptreact = ["eslint_d"];
        typescriptreact = ["eslint_d"];
      };

      # Auto-run linters on these events
      autoCmd = {
        event = ["BufEnter" "BufWritePost" "InsertLeave"];
        callback = {
          __raw = ''
            function()
              require('lint').try_lint()
            end
          '';
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ll";
        action = ''
          function()
            require("lint").try_lint()
          end
        '';
        options = {
          desc = "Trigger linter";
          silent = true;
        };
      }
    ];
  };
}

{pkgs, ...}: {
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      settings = {
        open_mapping = "[[<c-\\>]]";
        direction = "horizontal";
        shade_terminals = true;
        size = 20;
        hide_numbers = true;
        shading_factor = 2;
        start_in_insert = true;
        insert_mappings = true;
        persist_size = true;
        close_on_exit = true;
        shell = "${pkgs.zsh}/bin/zsh";
        float_opts = {
          border = "single";
          winblend = 0;
        };
      };
    };

    # <leader>o = Terminal
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>o";
        group = "Terminal";
        icon = " ";
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>of";
        action = "<cmd>ToggleTerm direction=float<CR>";
        options.desc = "Float terminal";
      }
      {
        mode = "n";
        key = "<leader>oh";
        action = "<cmd>ToggleTerm direction=horizontal<CR>";
        options.desc = "Horizontal terminal";
      }
      {
        mode = "n";
        key = "<leader>ov";
        action = "<cmd>ToggleTerm size=80 direction=vertical<CR>";
        options.desc = "Vertical terminal";
      }
    ];
  };
}

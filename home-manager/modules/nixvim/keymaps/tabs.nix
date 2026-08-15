{...}: {
  programs.nixvim = {
    # <leader>t = Tabs
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>t";
        group = "Tabs";
        icon = "󰓩 ";
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>tn";
        action = "<cmd>tabnext<CR>";
        options = {
          desc = "Next Tab";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tp";
        action = "<cmd>tabprevious<CR>";
        options = {
          desc = "Previous Tab";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tc";
        action = "<cmd>tabclose<CR>";
        options = {
          desc = "Close Tab";
          silent = true;
        };
      }
    ];
  };
}

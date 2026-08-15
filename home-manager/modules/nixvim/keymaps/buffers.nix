{...}: {
  # <leader>b = Buffers
  programs.nixvim = {
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>b";
        group = "Buffers";
        icon = "󰓩 ";
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>bprevious<cr>";
        options = {
          desc = "Previous Buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>bnext<cr>";
        options = {
          desc = "Next Buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>be";
        action = "<cmd>enew<CR>";
        options = {
          desc = "New Buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        options = {
          desc = "Delete Buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>bdelete!<CR>";
        options = {
          desc = "Force Delete";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bx";
        action = "<cmd>%!xxd<cr>";
        options = {
          desc = "Toggle Hexmode";
          silent = true;
        };
      }
    ];
  };
}

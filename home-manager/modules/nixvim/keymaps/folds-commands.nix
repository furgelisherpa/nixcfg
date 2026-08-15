{...}: {
  programs.nixvim = {
    # <leader>z = Folds, <leader>c = Commands
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>z";
        group = "Folds";
        icon = "C ";
      }
      {
        __unkeyed-1 = "<leader>c";
        group = "Code";
        icon = "󰞋 ";
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>zf";
        action = "zf%";
        options = {
          desc = "Create Fold around Block";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>c!";
        action = ":!";
        options = {
          desc = "Execute Shell Command";
          silent = false;
        };
      }
    ];
  };
}

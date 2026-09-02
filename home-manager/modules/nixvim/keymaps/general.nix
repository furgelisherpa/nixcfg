{...}: {
  programs.nixvim.keymaps = [
    # Window resize
    {
      mode = "n";
      key = "<A-h>";
      action = "<cmd>vertical resize -2<CR>";
      options = {
        desc = "Resize Left";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<A-l>";
      action = "<cmd>vertical resize +2<CR>";
      options = {
        desc = "Resize Right";
        silent = true;
      };
    }

    # Move text (normal mode)
    {
      mode = "n";
      key = "<A-j>";
      action = "<cmd>m .+1<cr>==";
      options = {
        desc = "Move Text Down";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<A-k>";
      action = "<cmd>m .-2<cr>==";
      options = {
        desc = "Move Text Up";
        silent = true;
      };
    }

    # Fast actions
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>w!<cr>";
      options = {
        desc = "Write File";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>confirm bd<cr>";
      options = {
        desc = "Exit";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "Q";
      action = "ZQ";
      options = {
        desc = "Quit Without Saving";
        silent = true;
      };
    }

    # Visual mode
    {
      mode = "v";
      key = "<";
      action = "<gv";
      options = {
        desc = "Shift Selection Left";
        silent = true;
      };
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
      options = {
        desc = "Shift Selection Right";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<A-j>";
      action = ":m '>+1<cr>gv=gv";
      options = {
        desc = "Move Selection Down";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":m '<-2<cr>gv=gv";
      options = {
        desc = "Move Selection Up";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "p";
      action = ''"_dP'';
      options = {
        desc = "Paste Without Yanking";
        silent = true;
      };
    }
  ];
}

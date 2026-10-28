let
  nt = key: cmd: desc: {
    mode = "n";
    inherit key;
    action = "<cmd>${cmd}<CR>";
    options = {
      inherit desc;
      silent = true;
    };
  };
in {
  programs.nixvim = {
    plugins.nvim-tree = {
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

        actions.open_file.quit_on_open = false;

        # Buffer-local keymaps (only active inside the tree window)
        on_attach.__raw = ''
          function(bufnr)
            local api = require("nvim-tree.api")

            local function map(key, fn, desc)
              vim.keymap.set("n", key, fn, {
                desc = "nvim-tree: " .. desc,
                buffer = bufnr,
                noremap = true,
                silent = true,
                nowait = true,
              })
            end

            -- keep all of nvim-tree's default mappings...
            api.config.mappings.default_on_attach(bufnr)

            -- ...then add/override
            map("l", api.node.open.edit, "Open")
            map("h", api.node.navigate.parent_close, "Close directory")
            map("v", api.node.open.vertical, "Open: vertical split")
            map("s", api.node.open.horizontal, "Open: horizontal split")
            map("t", api.node.open.tab, "Open: new tab")
            map("P", api.node.open.preview, "Open: preview")
            map("gx", api.node.run.system, "Open with system app")
            map("?", api.tree.toggle_help, "Help")
            map("<Esc>", api.tree.close, "Close tree")
          end
        '';
      };
    };

    plugins.web-devicons.enable = true;

    keymaps = [
      (nt "<leader>e" "NvimTreeToggle" "Toggle NvimTree")
      (nt "<leader>E" "NvimTreeFindFile" "Reveal current file in tree")
      (nt "<leader>o" "NvimTreeFocus" "Focus NvimTree")
    ];
  };
}

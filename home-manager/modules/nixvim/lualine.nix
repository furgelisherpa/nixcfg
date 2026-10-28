{...}: {
  programs.nixvim = {
    plugins.lualine = {
      enable = true;

      settings = {
        options = {
          theme = "auto";
          globalstatus = true;
          icons_enabled = true;
          component_separators = {
            left = "|";
            right = "|";
          };
          section_separators = {
            left = "";
            right = "";
          };
          disabled_filetypes.statusline = ["dashboard" "alpha"];
        };

        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch" "diff" "diagnostics"];
          lualine_c = [
            {
              __unkeyed-1 = "filename";
              path = 1; # 0 = name, 1 = relative path, 2 = absolute
              symbols = {
                modified = "[+]";
                readonly = "[RO]";
              };
            }
          ];
          lualine_x = ["encoding" "fileformat" "filetype"];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };

        inactive_sections = {
          lualine_c = ["filename"];
          lualine_x = ["location"];
        };

        extensions = ["fzf" "neo-tree" "quickfix"];
      };
    };
  };
}

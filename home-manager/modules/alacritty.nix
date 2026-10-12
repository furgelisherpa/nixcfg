{pkgs, ...}: {
  # --- module: alacritty.nix ----------------------------------------------
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };

        size = 12;
      };

      window = {
        # Override COSMIC/GNOME client-side decorations with none.
        decorations = "None";
        padding = {
          x = 0;
          y = 0;
        };

        dynamic_padding = false;
        opacity = 1.0;
        dynamic_title = false;
        startup_mode = "Windowed";
      };

      scrolling = {
        history = 50000;
        multiplier = 3;
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "Off";
        };

        unfocused_hollow = false;
      };

      terminal = {
        osc52 = "OnlyCopy";
        shell = {
          program = "${pkgs.tmux}/bin/tmux";
          args = [
            "new-session"
            "-A"
            "-s"
            "system"
          ];
        };
      };

      mouse = {
        hide_when_typing = true;
      };
    };
  };
}

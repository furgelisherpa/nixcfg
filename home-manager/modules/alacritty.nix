{pkgs, ...}: {
  # --- module: alacritty.nix ----------------------------------------------
  # Owns the terminal emulator. Alacritty is GPU-accelerated; here it's wired
  # to launch straight into tmux (see terminal.shell below) so every window is
  # a persistent tmux session rather than a throwaway shell.

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
        # Override COSMIC/GNOME client-side decorations with none; a clean,
        # maximised terminal (matches the minimal look and avoids extra title
        # bars when snapped).
        decorations = "None";
        padding = {
          x = 0;
          y = 0;
        };

        dynamic_padding = false;
        opacity = 1.0; # opaque — readability over translucency
        dynamic_title = false;
        startup_mode = "Windowed";
      };

      scrolling = {
        history = 50000; # roomy scrollback
        multiplier = 3; # faster wheel scrolling
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "Off";
        };

        unfocused_hollow = true; # hollow cursor when window loses focus
      };

      terminal = {
        osc52 = "OnlyCopy"; # allow OSC52 clipboard write from apps (e.g. tmux yank)
        shell = {
          # Auto-start tmux inside every alacritty window: attach to (or create)
          # the shared `system` session, so new windows join the same workspace.
          program = "${pkgs.tmux}/bin/tmux";
          args = [
            "new-session"
            "-A" # attach to `system` if it exists, else create it
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

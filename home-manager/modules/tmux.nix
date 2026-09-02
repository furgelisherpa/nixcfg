{pkgs, ...}: {
  # --- module: tmux.nix ----------------------------------------------------
  # Owns the terminal multiplexer. tmux provides a persistent workspace that
  # survives window/SSH disconnects; alacritty (alacritty.nix) auto-attaches.

  programs.tmux = {
    enable = true;

    # Number the windows from 1 instead of 0 (matches typical muscle memory).
    baseIndex = 1;

    # Remove the delay after pressing Esc (important for vim/Emacs keybindings
    # so mode transitions feel instant rather than laggy).
    escapeTime = 0;

    # vim-style pane/window movement keys.
    keyMode = "vi";
    terminal = "xterm-256color";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";

    plugins = with pkgs.tmuxPlugins; [
      sensible # sane defaults community plugin
      yank # system-clipboard integration (works with OSC52 in alacritty)
    ];

    extraConfig = ''
      # Status line: time + date on the right, plain black/white.
      set -g status-right ' %H:%M  %d-%b-%y '
      set -g status-style "bg=black,fg=white"

      # Minimal pane borders (single line), subtle inactive, bright active.
      set -g pane-border-lines single
      set -g pane-border-style "fg=colour238"
      set -g pane-active-border-style "fg=white"

      # Window splitting: use v/h keys like vim, but ALWAYS keep the current
      # pane's working directory in the new pane (`-c "#{pane_current_path}"`).
      unbind v
      unbind h
      unbind %
      unbind '"'
      bind v split-window -h -c "#{pane_current_path}"
      bind h split-window -c "#{pane_current_path}"

      # Move between windows with j/k like vim buffers.
      bind j next-window
      bind k previous-window

      # Pane navigation with Ctrl+arrows (tmux's natural pane motion).
      bind C-h select-pane -L
      bind C-j select-pane -D
      bind C-k select-pane -U
      bind C-l select-pane -R
    '';
  };
}

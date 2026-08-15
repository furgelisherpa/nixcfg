{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    # Remove the delay after pressing Esc (important for vim keybindings)
    escapeTime = 0;
    keyMode = "vi";
    terminal = "xterm-256color";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
    ];

    extraConfig = ''
      set -g status-right ' %H:%M  %d-%b-%y '
      set -g status-style "bg=black,fg=white"

      set -g pane-border-lines single
      set -g pane-border-style "fg=colour238"
      set -g pane-active-border-style "fg=white"

      # set window split
      unbind v
      unbind h
      unbind %
      unbind '"'
      bind v split-window -h -c "#{pane_current_path}"
      bind h split-window -c "#{pane_current_path}"

      bind j next-window
      bind k previous-window

      # pane navigation
      bind C-h select-pane -L
      bind C-j select-pane -D
      bind C-k select-pane -U
      bind C-l select-pane -R
    '';
  };
}

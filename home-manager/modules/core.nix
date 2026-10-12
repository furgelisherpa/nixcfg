{
  pkgs,
  config,
  ...
}: {
  # --- module: core.nix ----------------------------------------------------
  # home-manager configuration
  home = {
    username = "pstivy";
    homeDirectory = "/home/pstivy";

    sessionVariables = {
      MANPAGER = "nvim +Man!";

      # Default shell.
      SHELL = "${pkgs.zsh}/bin/zsh";

      # Interactive tool defaults.
      LESS = "R";

      # Re-home each tool's cache/data dirs into the XDG tree.
      GOPATH = "${config.xdg.dataHome}/go";
      GOMODCACHE = "${config.xdg.cacheHome}/go/mod";
      NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
      PNPM_HOME = "${config.xdg.dataHome}/pnpm";
      BUN_INSTALL = "${config.xdg.dataHome}/bun";
      NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
      PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc";
      PYTHON_HISTORY = "${config.xdg.dataHome}/python/history";
      PIP_CACHE_DIR = "${config.xdg.cacheHome}/pip";
      WORKON_HOME = "${config.xdg.dataHome}/virtualenvs";
    };

    # Add user-local bin to PATH.
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    # Global pointer cursor so GTK apps keep a consistent cursor (COSMIC
    # doesn't always set one for X clients).
    pointerCursor = {
      enable = true;
      gtk.enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };
  };

  # Enable fontconfig so applications detect installed fonts.
  fonts.fontconfig.enable = true;

  # Follow the XDG base directory spec for home-manager-managed files.
  xdg.enable = true;

  # GTK theming.
  gtk = {
    enable = true;

    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  # Ensures the `home-manager` CLI is available for ad-hoc switches.
  programs.home-manager.enable = true;

  # Ensure direnv is enable
  programs.direnv.enable = true;
}

{
  pkgs,
  config,
  ...
}: {
  # --- module: core.nix ----------------------------------------------------
  # Base user environment: unfree allowance, home identity, environment
  # variables, PATH, pointer cursor, fontconfig, XDG dirs, GTK, home-manager.

  # home-manager configuration
  home = {
    # User identity — must match the account in nixos/modules/users.nix.
    username = "pstivy";
    homeDirectory = "/home/pstivy";

    sessionVariables = {
      # Default pager. NOTE: $EDITOR is deliberately NOT set here — it's owned
      # by the Emacs machinery (custom.emacsConfig) so vim/emacs don't fight
      # over who provides it.
      MANPAGER = "nvim +Man!";

      # Default shell.
      SHELL = "${pkgs.zsh}/bin/zsh";

      # Interactive tool defaults.
      LESS = "R";

      # Re-home each tool's cache/data dirs into the XDG tree. Keeping these
      # out of `~` means `ls ~` stays clean, per-app data is discoverable, and
      # cross-tool backups/cleanups are simpler. Each points at the matching
      # xdg.dataHome/xdg.cacheHome location.
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

    # Add user-local bin to PATH (for manually dropped scripts/tools not
    # managed by nix).
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    # Global pointer cursor so GTK apps keep a consistent cursor (COSMIC
    # doesn't always set one for X clients).
    pointerCursor = {
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

  # GTK theming. The CSS blocks are commented out as optional styling hooks —
  # COSMIC is not a GTK shell, so these are left off by default.
  gtk = {
    enable = true;
    # gtk3 = {
    #   extraCss = '' ... '';
    # };
    # gtk4 = {
    #   extraCss = '' ... '';
    # };
  };

  # Ensures the `home-manager` CLI is available for ad-hoc switches.
  programs.home-manager.enable = true;
}

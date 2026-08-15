{
  pkgs,
  config,
  ...
}: {
  # Allow unfree packages for user-level installs too
  nixpkgs.config.allowUnfree = true;

  # home-manager configuration
  home = {
    username = "pstivy";
    homeDirectory = "/home/pstivy";

    sessionVariables = {
      # Default Editor & Pager
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";

      # Default shell
      SHELL = "${pkgs.zsh}/bin/zsh";

      # Interactive Tool Defaults
      LESS = "R";

      # Dev Caches (Keeps ~/.cache and ~/.local/share tidy without polluting ~)
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

    # Add user-local bin to PATH
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];
  };

  # Enable Fontconfig so applications detect installed fonts
  fonts.fontconfig.enable = true;

  # Auto XDG_DIRs setup
  xdg.enable = true;

  programs = {
    # Enable home-manager
    home-manager.enable = true;
  };
}

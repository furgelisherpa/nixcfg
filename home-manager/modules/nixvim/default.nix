{...}: {
  # --- module: nixvim/default.nix ------------------------------------------
  # Entry point for the Neovim (nixvim) config. Nixvim is a Nix DSL over
  # Neovim: options/plugins/keymaps are declared declaratively here and
  # rendered into the runtime config by nixvim itself.
  #
  # Splitting: each concern lives in its own file (options, plugins, lsp,
  # formatting, linting, telescope, terminal, autocmds, keymaps) and is
  # imported below in roughly startup-dependency order.

  # Load nixvim option groups; order roughly follows startup dependency
  imports = [
    ./dependencies.nix
    ./options.nix
    ./keymaps
    ./autocmds.nix
    ./plugins.nix
    ./lsp.nix
    ./terminal.nix
    ./formatting.nix
    ./lint.nix
    ./telescope.nix
  ];

  programs.nixvim = {
    enable = true;
    # Emacs (emacsclient) owns $EDITOR via custom.emacsConfig.defaultEditor,
    # so nixvim must not register itself as the default editor (which would
    # fight Emacs for that role).
    defaultEditor = false;
  };
}

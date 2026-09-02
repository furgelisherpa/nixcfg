{inputs, ...}: {
  # --- home-manager entry point -------------------------------------------
  # Top-level user configuration for `pstivy@core`. Mirrors the structure of
  # nixos/configuration.nix: imports a set of per-tool modules, each owning one
  # concern. Add new user-level tools here as an import.

  imports = [
    # flake-provided module sets (nixvim IDE + sops secret management)
    inputs.nixvim.homeModules.nixvim
    inputs.sops-nix.homeManagerModules.sops

    # per-tool modules (one file per concern)
    ./modules/core.nix
    ./modules/secrets.nix
    ./modules/alacritty.nix
    ./modules/packages.nix
    ./modules/ssh-gpg.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/tmux.nix
    ./modules/nixvim

    # maEmacs: modular Emacs IDE (external flake)
    inputs.ma-emacs.homeManagerModules.maEmacs
  ];

  # Pin the home-manager release this config was first built against.
  # Like system.stateVersion, only raise when deliberately migrating.
  home.stateVersion = "26.05";
}

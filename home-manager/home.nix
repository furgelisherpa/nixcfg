{inputs, ...}: {
  # Home-manager module list, mirrors nixos/configuration.nix's structure
  imports = [
    inputs.nixvim.homeModules.nixvim

    ./modules/core.nix
    ./modules/packages.nix
    ./modules/ssh-gpg.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/terminal-tools.nix
    ./modules/nixvim
    ./modules/tmux.nix
  ];

  # Pin the home-manager release this config was first built against
  home.stateVersion = "26.05";
}

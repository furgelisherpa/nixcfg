{inputs, ...}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    inputs.sops-nix.homeManagerModules.sops

    ./modules/core.nix
    ./modules/secrets.nix
    ./modules/alacritty.nix
    ./modules/packages.nix
    ./modules/ssh-gpg.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/tmux.nix
    ./modules/nixvim
    ./modules/quteborwser.nix
    ./modules/flutter
  ];

  home.stateVersion = "26.05";
}

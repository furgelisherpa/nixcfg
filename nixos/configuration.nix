{...}: {
  # Pull in hardware scan output and all feature modules
  imports = [
    ./hardware-configuration.nix

    ./modules/nix-settings.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/desktop.nix
    ./modules/audio.nix
    ./modules/security.nix
    ./modules/users.nix
    ./modules/virtualization.nix
    ./modules/bluetooth.nix
  ];

  # Pin the NixOS release this config was first built against
  system.stateVersion = "26.05";
}

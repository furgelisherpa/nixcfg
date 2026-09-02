{pkgs, ...}: {
  # --- module: boot.nix ----------------------------------------------------
  # Owns bootloader + kernel selection.

  # Bootloader: systemd-boot is the lightweight, EFI-native option and pairs
  # naturally with NixOS generations (each generation appears in the menu).
  boot.loader = {
    systemd-boot = {
      enable = true;
      # Keep only the 10 most recent generations in the boot menu. Older
      # entries stay in the store but stop cluttering the boot menu.
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true; # needed for `nixos-rebuild switch` to write EFI vars
  };

  # Use latest kernel series (linuxPackages = latest stable).
  boot.kernelPackages = pkgs.linuxPackages;
}

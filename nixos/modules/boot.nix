{pkgs, ...}: {
  # --- module: boot.nix ----------------------------------------------------
  boot.loader = {
    systemd-boot = {
      enable = true;
      # Keep only the 3 most recent generations in the boot menu. Older
      # entries stay in the store but stop cluttering the boot menu.
      configurationLimit = 3;
    };
    efi.canTouchEfiVariables = true; # needed for `nixos-rebuild switch` to write EFI vars
  };

  # Remove /tmp dirs mess on boot
  boot.tmp.cleanOnBoot = true;

  # Use latest kernel series (linuxPackages = latest stable).
  boot.kernelPackages = pkgs.linuxPackages;
}

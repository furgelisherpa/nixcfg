{pkgs, ...}: {
  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      # Keep only the 10 most recent generations in the boot menu
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages;
}

{...}: {
  # --- module: bluetooth.nix ----------------------------------------------

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}

{...}: {
  # --- module: bluetooth.nix ----------------------------------------------
  # Owns Bluetooth radio behavior.

  hardware.bluetooth = {
    enable = true;
    # Turn the Bluetooth radio on automatically at boot (laptops: avoids a
    # manual `bluetoothctl power on` every session).
    powerOnBoot = true;
  };
}

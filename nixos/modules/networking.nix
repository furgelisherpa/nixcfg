{...}: {
  # --- module: networking.nix ---------------------------------------------
  networking = {
    networkmanager.enable = true;
    hostName = "core";
  };
}

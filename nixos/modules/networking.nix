{...}: {
  # --- module: networking.nix ---------------------------------------------
  networking = {
    networkmanager.enable = true;
    hostName = "core";
    networkmanager.wifi.macAddress = "permanent";
  };

  # Ensure proprietary firmware blobs are fully loaded for the wireless card
  hardware.enableRedistributableFirmware = true;

  # Force the Realtek rtw88 driver to disable aggressive power saving and ASPM
  boot.extraModprobeConfig = ''
    options rtw88_core disable_lps_deep=y
    options rtw88_pci disable_aspm=y
    options rtw88_pci disable_msi=y
  '';
}

{ ... }: {
  # Use NetworkManager for network configuration
  networking.networkmanager.enable = true;

  # Set the machine's hostname
  networking.hostName = "core";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}

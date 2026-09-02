{...}: {
  # --- module: networking.nix ---------------------------------------------
  # Owns network wiring (NetworkManager), hostname, and firewall policy.

  # Use NetworkManager for network configuration — gives GUI/CLI control and
  # handles Wi-Fi/dhcp/VPN via `nmcli`/applet rather than hand-rolled config.
  networking.networkmanager.enable = true;

  # Hostname for this machine. `core` is fixed here; the user `pstivy` is
  # defined in users.nix.
  networking.hostName = "core";

  # Firewall defaults to ON in NixOS. Nothing needs inbound ports on this
  # desktop, so we deliberately open nothing. If a service ever needs a port:
  #
  #   networking.firewall.allowedTCPPorts = [ 8080 ];
  #   networking.firewall.allowedUDPPorts = [ 5353 ];
  #
  # (Avoid `networking.firewall.enable = false`; it disables ALL filtering.)
}

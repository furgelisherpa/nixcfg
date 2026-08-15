{ ... }: {
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
}

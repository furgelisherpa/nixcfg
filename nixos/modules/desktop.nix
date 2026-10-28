{pkgs, ...}: {
  # --- module: desktop.nix -------------------------------------------------
  services = {
    # COSMIC desktop + greeter (login screen).
    displayManager.cosmic-greeter.enable = true;

    desktopManager.cosmic.enable = true;
    # GNOME keyring unlocks secrets for apps (SSH agents, browser master
    # passwords, etc.) under COSMIC.
    gnome.gnome-keyring.enable = true;

    # Optimization
    system76-scheduler.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      # Cosmic Apps
      cosmic-icons
      cosmic-monitor
      cosmic-store
      cosmic-wallpapers

      # Cosmic Extensions
      cosmic-ext-applet-caffeine
      cosmic-ext-applet-weather
    ];
    cosmic.excludePackages = with pkgs; [
      cosmic-edit
      cosmic-term
      cosmic-player
    ];
  };

  # Enable Firefox as the fallback system browser.
  programs.firefox.enable = true;

  # Enable CUPS to print documents (now used by way of the COSMIC/Print UI).
  services.printing.enable = true;

  # Enable dev documentations
  documentation = {
    dev.enable = true;
    man.cache.enable = true;
  };
}

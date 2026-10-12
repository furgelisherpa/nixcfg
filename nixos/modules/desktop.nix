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

      # GUI Tools / Desktop Apps
      vim
      zathura
      libreoffice
      krita
      gimp
      obs-studio
      mpv

      sxiv
      deadbeef
      calibre
      spotify

      # Terminal Utilities
      bc
      ffmpeg
      lsd
      highlight
      yt-dlp
      rsync
      htop
      jq
      tldr
      unzip
      p7zip
      wl-clipboard
      xxd
      less
      rlwrap
      ripgrep
      fd
      coreutils

      # Network Utilities
      nettools
      inetutils
      dnsutils
      iproute2
      mtr
      nmap
      tcpdump
      curl
      wget
      socat
      iperf3
      netcat-openbsd

      # Programming utilities
      gcc
      gnumake
      python3
      nodejs

      # Virtualization tooling
      lazydocker
      spice
      spice-protocol
      virt-viewer
      bridge-utils
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
}

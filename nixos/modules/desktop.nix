{pkgs, ...}: {
  # --- module: desktop.nix -------------------------------------------------
  # Owns the graphical desktop (display manager, desktop environment, keyring)
  # plus the system-wide GUI/CLI package set and desktop services (printing).

  services = {
    # COSMIC desktop + its greeter (login screen).
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    # GNOME keyring unlocks secrets for apps (SSH agents, browser master
    # passwords, etc.) under COSMIC.
    gnome.gnome-keyring.enable = true;
  };

  environment = {
    # System-wide packages available to every user. Prefer wrapping per-user
    # tools in home-manager/modules/packages.nix; keep true multi-user
    # essentials (CLI/network/virtualization tooling) here.
    systemPackages = with pkgs; [
      # GUI Tools / Desktop apps
      vim
      zathura # PDF viewer
      libreoffice
      krita # raster painting
      gimp
      obs-studio # screencast/streaming
      mpv # video player
      sxiv # image viewer
      deadbeef # audio player
      calibre # e-book management
      spotify

      # Terminal Utilities
      bc
      ffmpeg
      lsd # prettier `ls`
      highlight # syntax highlighting for `less`/`ccat`
      yt-dlp # video/audio download
      rsync
      htop
      jq # JSON processor
      tldr
      unzip
      p7zip
      wl-clipboard # Wayland clipboard CLI (wlc/wlcopy)
      xxd
      less

      # Network Utilities
      nettools
      inetutils
      dnsutils # dig/nslookup
      iproute2 # ip/ss
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
      lazydocker # TUI for docker
      spice # SPICE protocol client libs (VMs)
      spice-protocol
      virt-viewer
      bridge-utils # bridge networking for VMs
    ];
  };

  # Enable Firefox as the fallback system browser.
  programs.firefox.enable = true;

  # Enable CUPS to print documents (now used by way of the COSMIC/Print UI).
  services.printing.enable = true;
}

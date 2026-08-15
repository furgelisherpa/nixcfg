{pkgs, ...}: {
  home.packages = with pkgs; [
    # GUI Tools
    vim
    zathura
    libreoffice
    krita
    gimp
    obs-studio

    # Fonts
    nerd-fonts.jetbrains-mono

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
    opencode

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

    # Programming utils
    gcc
    gnumake
    python3
    nodejs

    # Virtualization
    docker-compose
    lazydocker
    spice
    spice-protocol
    virt-viewer
    bridge-utils
  ];
}

{pkgs, ...}: {
  # --- module: packages.nix ------------------------------------------------
  home.packages = with pkgs; [
    # Agent tools
    opencode

    # Terminal tools
    gh

    # GUI tools
    ayugram-desktop
    legcord

    # Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only

    # Torrent
    qbittorrent

    # C/C++
    clang-tools
    gcc
    gnumake
    cmake

    # latex
    texlab
    texliveFull

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
    file
    tree
    which
    lsof
    strace
    pciutils
    usbutils

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
    iw

    # Network Hardware & Diagnostics
    ethtool
    wavemon
    iputils
    traceroute

    # Network Discovery & Monitoring
    arp-scan
    bandwhich
    nload
    termshark

    # DNS, HTTP & TLS
    openssl
    httpie

    # Programming Utilities
    gcc
    gnumake
    python3
    nodejs

    # Virtualization Tooling
    lazydocker
    spice
    spice-protocol
    virt-viewer
    bridge-utils

    # Man Pages
    man-pages
    man-pages-posix
  ];
}

{pkgs, ...}: {
  # --- module: packages.nix ------------------------------------------------
  # User-level (home-manager) package set. Keep USER-only tools here; shared
  # multi-user essentials live in nixos/modules/desktop.nix systemPackages.

  home.packages = with pkgs; [
    # Terminal/Agent tools
    opencode # AI coding agent CLI
    aider-chat-full # AI pair-programming CLI

    # GUI tools
    ayugram-desktop # Telegram (Ayugram)
    qutebrowser # vim-style web browser

    # Fonts — declared so they're installed and usable by fontconfig (alacritty
    # and the emacs config reference these families by name).
    ubuntu-sans
    ubuntu-sans-mono
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.jetbrains-mono
  ];
}

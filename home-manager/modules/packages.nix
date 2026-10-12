{pkgs, ...}: {
  # --- module: packages.nix ------------------------------------------------
  home.packages = with pkgs; [
    # Agent tools
    opencode
    aider-chat-full

    # Terminal tools
    gh

    # GUI tools
    ayugram-desktop
    legcord

    # Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];
}

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
    # Standalone "Symbols Nerd Font (Mono)" — the family nerd-icons (corfu
    # margin icons, via nerd-icons-corfu) renders its glyphs from. The patched
    # JetBrainsMono/Ubuntu fonts embed the glyphs but NOT under this family
    # name, so nerd-icons would fall back to tofu boxes without it.
    nerd-fonts.symbols-only
  ];
}

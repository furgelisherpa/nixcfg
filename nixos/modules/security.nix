{...}: {
  # --- module: security.nix -----------------------------------------------
  # Run a GPG agent for signing (SSH support handled separately)
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };
}

{...}: {
  # --- module: security.nix -----------------------------------------------
  # Owns GnuPG agent + SSH server policy for the system.

  # Run a GPG agent for signing (SSH support handled separately)
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };

  # SSH server is intentionally DISABLED: this is a desktop, and enabling it
  # with no authorized keys configured (password auth also off) would leave a
  # dead open port nobody can log in through. Keeping it off minimizes the
  # attack surface.
  #
  # To re-enable remote access later, provide the user's public keys first
  # (prefer sops so keys stay out of git) and then flip `services.openssh` on:
  #
  #   users.users.pstivy.openssh.authorizedKeys.keys = [ config.sops.secrets.ssh_authorized_keys.path ];
  #   services.openssh = {
  #     enable = true;
  #     settings = {
  #       PermitRootLogin = "no";
  #       PasswordAuthentication = false;   # keys only
  #     };
  #   };
}

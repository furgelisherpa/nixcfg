{
  config,
  lib,
  pkgs,
  ...
}: {
  # --- module: secrets.nix -------------------------------------------------
  # sops-nix secret management. Encrypted secrets live in
  # secrets/secrets.yaml (safe to commit); the age PRIVATE key that unlocks
  # them is ~/.config/sops/age/keys.txt — NEVER in git. Why age over GPG:
  # the age key is a standalone file we control (no keyring state), and sops
  # only needs that one key to (de)encrypt, keeping the trust model tiny.

  sops = {
    # Age private key used to decrypt the secrets file. Grant 0600 + owner-only
    # so only this user can read it.
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";

    # Location of the encrypted secret store (default: secrets/secrets.yaml).
    defaultSopsFile = ./../../secrets/secrets.yaml;

    # Each declared secret gets decrypted to a path at activation. These are
    # the values tools actually consume (via templates below), NOT plaintext
    # in the repo.
    secrets = {
      git_user_name = {};
      git_user_email = {};
      git_signing_key = {};
      ssh_private_key = {};
      ssh_public_key = {};
      # Armored (ASCII) export of the GPG secret signing key, so it survives a
      # wiped ~/.local/share/gnupg. Consumed by the restore hook in
      # ssh-gpg.nix (home.activation.importGpg), NOT by any running tool.
      gpg_private_key = {};
    };

    # Templates materialize the decrypted secrets into the exact files the
    # tools read. Using templates (rather than placing raw secrets) lets us
    # control per-file mode and structure (e.g. a git config block).
    templates = {
      # Git identity + signing key, written as a git config include. Referenced
      # from home-manager/modules/git.nix via `include.path`, so no key
      # material is ever hardcoded in the repo.
      "git-identity" = {
        content = ''
          [user]
              name = ${config.sops.placeholder.git_user_name}
              email = ${config.sops.placeholder.git_user_email}
              signingkey = ${config.sops.placeholder.git_signing_key}
        '';
        path = "${config.xdg.configHome}/git/identity";
        mode = "0600"; # identity contains the signing key id; keep it user-only
      };

      # SSH private key (0600) so ssh-agent / git+ssh work as before.
      "ssh/id_ed25519" = {
        content = ''${config.sops.placeholder.ssh_private_key}'';
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
        mode = "0600"; # private key must never be world-readable
      };

      # SSH public key (0644 — public, safe for others to read).
      "ssh/id_ed25519.pub" = {
        content = ''${config.sops.placeholder.ssh_public_key}'';
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        mode = "0644";
      };

      # Armored GPG private key, staged on disk for the restore hook in
      # ssh-gpg.nix to import on first activation if the key is missing. 0600
      # because it is plaintext private key material (only after sops decrypts
      # this template at activation — never in the repo).
      "gpg/private-key.asc" = {
        content = ''${config.sops.placeholder.gpg_private_key}'';
        path = "${config.xdg.configHome}/sops-nix/secrets/rendered/gpg/private-key.asc";
        mode = "0600";
      };
    };
  };

  # Standalone home-manager needs the explicit home dir for sops paths
  # (sops-nix doesn't otherwise know it in this non-NixOS, user-only context).
  home.homeDirectory = lib.mkDefault "/home/pstivy";
}

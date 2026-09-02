{
  config,
  lib,
  pkgs,
  ...
}: {
  # --- module: ssh-gpg.nix -------------------------------------------------
  # Owns SSH (agent + client) and GPG (agent + signing). SSH keys themselves
  # are supplied by sops (secrets.nix) — this module only wires up the
  # runtime agents and client policy. GPG secret keys are auto-restored from
  # the sops-encrypted armored export (see home.activation.importGpg below).

  # Run a user-level SSH agent so keys loaded with `ssh-add` are cached in
  # memory (avoid re-prompting for passphrases across sessions).
  services.ssh-agent.enable = true;

  # Configure SSH Client.
  programs.ssh = {
    enable = true;
    # We define our own settings below instead of letting home-manager emit a
    # default ~/.ssh/config (which can override/lose host key options).
    enableDefaultConfig = false;
    settings = {
      "*" = {
        # Auto-add keys as they're used (via the agent), so `git push` etc.
        # finds the right key without a manual `ssh-add`.
        AddKeysToAgent = "yes";
      };
    };
  };

  # Enable GPG + agent for signing git commits/tags.
  programs.gpg = {
    enable = true;
    # Keep GPG data under the XDG data dir instead of ~/.gnupg (tidier home);
    # gpg will use {homedir} for its keyring, config and sockets.
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    # How long a cached passphrase stays valid (seconds).
    defaultCacheTtl = 28800; # 8h: sign through a workday without re-entering
    maxCacheTtl = 86400; # hard cap (24h) so a leaked passphrase expires
    pinentry = {
      # GUI pinentry so passphrase prompts appear as a dialog on the desktop
      # rather than failing in a headless context. Qt variant to match the
      # COSMIC (Qt) desktop environment.
      package = pkgs.pinentry-qt;
    };
  };

  # Auto-restore the GPG secret key if the keyring is missing (e.g. after a
  # wiped ~/.local/share/gnupg). The armored private key is staged by sops at
  # ~/.config/sops-nix/secrets/rendered/gpg/private-key.asc (see secrets.nix);
  # we import it only when the fingerprint is absent, so this is idempotent.
  # Runs AFTER the sops-nix activation hook (which (re)renders that staged
  # file), so the key material is always fresh at restore time.
  #
  # `gpg --import` of a secret key does NOT require the passphrase — it only
  # moves the (still passphrase-locked) key blob into the keyring. The
  # passphrase is prompted on first USE (signing), exactly as before the wipe.
  home.activation.importGpg = lib.hm.dag.entryAfter ["sops-nix"] (
    let
      gpgHomedir = config.xdg.dataHome + "/gnupg";
      gpg = "${pkgs.gnupg}/bin/gpg";
      armoredKey =
        config.xdg.configHome
        + "/sops-nix/secrets/rendered/gpg/private-key.asc";
      # Full fingerprint of the primary signing subkey to detect presence.
      fp = "7DFEB511800D7A98152C934A8B8E2EFE97E11A51";
    in ''
      if [[ -f ${armoredKey} ]] && ! ${gpg} --homedir ${gpgHomedir} --batch \
          --list-secret-keys ${fp} >/dev/null 2>&1; then
        _i "Restoring GPG secret key from sops (keyring was missing)"
        run mkdir -m 700 -p ${gpgHomedir}
        ${gpg} --homedir ${gpgHomedir} --batch --import ${armoredKey}
        # Mark the key ultimate trust so signing works without "key not
        # trusted" warnings (mirrors the original keyring state).
        echo "${fp}:6:" | ${gpg} --homedir ${gpgHomedir} --import-ownertrust
      fi
    ''
  );
}

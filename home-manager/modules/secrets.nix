{
  config,
  lib,
  pkgs,
  ...
}: {
  # --- module: secrets.nix -------------------------------------------------
  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";

    # Location of the encrypted secret store.
    defaultSopsFile = ./../../secrets/secrets.yaml;

    secrets = {
      git_user_name = {};
      git_user_email = {};
      git_signing_key = {};
      ssh_private_key = {};
      ssh_public_key = {};
      gpg_private_key = {};
    };

    templates = {
      "git-identity" = {
        content = ''
          [user]
              name = ${config.sops.placeholder.git_user_name}
              email = ${config.sops.placeholder.git_user_email}
              signingkey = ${config.sops.placeholder.git_signing_key}
        '';
        path = "${config.xdg.configHome}/git/identity";
        mode = "0600";
      };

      "ssh/id_ed25519" = {
        content = ''${config.sops.placeholder.ssh_private_key}'';
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
        mode = "0600";
      };

      "ssh/id_ed25519.pub" = {
        content = ''${config.sops.placeholder.ssh_public_key}'';
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        mode = "0644";
      };

      "gpg/private-key.asc" = {
        content = ''${config.sops.placeholder.gpg_private_key}'';
        path = "${config.xdg.configHome}/sops-nix/secrets/rendered/gpg/private-key.asc";
        mode = "0600";
      };
    };
  };

  # Standalone home-manager needs the explicit home dir for sops paths
  home.homeDirectory = lib.mkDefault "/home/pstivy";

  # Run sops-nix after linkGeneration so sops-nix.service exists on first activation.
  home.activation.sops-nix = lib.mkForce (
    lib.hm.dag.entryAfter ["linkGeneration"] ''
      export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
      run ${pkgs.systemd}/bin/systemctl --user daemon-reload
      run ${pkgs.systemd}/bin/systemctl --user restart sops-nix.service
    ''
  );
}

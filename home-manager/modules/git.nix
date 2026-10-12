{
  pkgs,
  config,
  ...
}: {
  # --- module: git.nix -----------------------------------------------------
  programs.git = {
    enable = true;

    # Sign commits/tags by default.
    signing.signByDefault = true;

    settings = {
      gpg.program = "${pkgs.gnupg}/bin/gpg";

      # Force SSH protocol for github URLs instead of https
      url."git@github.com:".insteadOf = "https://github.com/";

      init.defaultBranch = "main";

      # Identity (name/email/signing key) is injected at activation from sops
      include.path = "${config.xdg.configHome}/git/identity";
    };
  };
}

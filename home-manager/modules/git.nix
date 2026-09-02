{
  pkgs,
  config,
  ...
}: {
  # --- module: git.nix -----------------------------------------------------
  # Owns the git client. Identity (name/email/signing key) is deliberately NOT
  # inline here — those values are secrets managed by sops (secrets.nix) and
  # injected at activation via an include file, so nothing sensitive lives in
  # the repo.

  programs.git = {
    enable = true;

    # Sign commits/tags by default. The key id itself comes from the sops
    # `git-identity` template (secrets.nix), so no key material is hardcoded.
    signing.signByDefault = true;

    settings = {
      gpg.program = "${pkgs.gnupg}/bin/gpg";

      # Force SSH protocol for github URLs instead of https (we authenticate
      # with ssh keys via the agent, so https interactions would prompt/pass
      # and slower).
      url."git@github.com:".insteadOf = "https://github.com/";

      init.defaultBranch = "main";

      # Identity (name/email/signing key) is injected at activation from sops
      # into ~/.config/git/identity (secrets.nix template). Git picks it up
      # here; keep this indirection so the values can rotate without touching
      # git settings.
      include.path = "${config.xdg.configHome}/git/identity";
    };
  };
}

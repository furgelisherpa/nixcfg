{
  config,
  pkgs,
  ...
}: {
  services.ssh-agent.enable = true;

  # Configure SSH Client
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
    };
  };

  # Enable GPG and GPG Agent for signing
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    # How long a cached passphrase stays valid (seconds)
    defaultCacheTtl = 28800;
    maxCacheTtl = 86400;
    pinentry = {
      package = pkgs.pinentry-qt;
    };
  };
}

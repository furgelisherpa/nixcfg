{pkgs, ...}: {
  programs.git = {
    enable = true;

    # Enable GPG Signing
    signing = {
      key = "8B8E2EFE97E11A51";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "furgelisherpa";
        email = "furgelizsherpa@gmail.com";
      };

      gpg.program = "${pkgs.gnupg}/bin/gpg";

      # Force SSH protocol for github URLs instead of https
      url."git@github.com:".insteadOf = "https://github.com/";

      init.defaultBranch = "main";
    };
  };
}

{...}: {
  # --- module: nix.nix -----------------------------------------------------
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      extra-substituters = [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    };
    channel.enable = false;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}

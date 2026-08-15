{...}: {
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    # Enable flakes and the new nix CLI
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      auto-optimise-store = true;
    };
    # Use flake inputs instead of nix-channel
    channel.enable = false;
    # Auto garbage-collect old generations weekly
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}

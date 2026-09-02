{...}: {
  # --- module: nix.nix -----------------------------------------------------
  # Owns the Nix package manager itself: nixpkgs config (overlays/unfree) and
  # the nix daemon settings (flakes, channel-less inputs, GC).

  nixpkgs = {
    # nixpkgs overlays: layer extra/custom derivations over the base package
    # set. Deliberately empty here — overlays that are needed (e.g. the
    # emacs-overlay) are applied globally from flake.nix instead, so the
    # system and home-manager share one overlay source of truth.
    overlays = [];

    # Configure the nixpkgs instance used by NixOS.
    config = {
      # Allow non-free packages. Set here at the SYSTEM level; home-manager
      # re-declares it in home-manager/modules/core.nix so user installs
      # inherit the same allowance.
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      # Enable flakes + the experimental `nix` CLI (needed by this repo).
      experimental-features = "nix-command flakes";
      # Use only flake.lock inputs, never the global flake registry. This
      # makes builds deterministic and offline-friendly: a hash in flake.lock
      # is the single source of truth for every input.
      flake-registry = "";

      extra-substituters = [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    };
    # Don't use nix-channel; everything comes from flakes instead. This repo
    # has no channel subscription, and mixing channels with flakes often
    # causes duplicate/conflicting package registration.
    channel.enable = false;
    # Auto garbage-collect old generations weekly to stop the store growing
    # unbounded. `--delete-older-than 30d` keeps the last ~30 days of
    # generations (rollback safety net) while reclaiming older space.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}

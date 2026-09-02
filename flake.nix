{
  description = "furgelisherpa's nixos configuration";

  inputs = {
    # --- package/registry inputs ---
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # home-manager release pinned to the same nixpkgs as NixOS so both share
    # one package set (no version skew between system and user packages).
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # sops-nix: decrypted secret management at activation. `follows` keeps its
    # nixpkgs in lockstep with ours.
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim/nixos-26.05";

    # maEmacs: modular Emacs IDE (home-manager module + emacs-overlay)
    ma-emacs = {
      url = "github:furgelisherpa/ma-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    ma-emacs,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    # nixpkgs with the emacs-overlay applied, so `pkgs.emacs-pgtk` (and the
    # whole emacs package set) is the pinned native-comp/pgtk build.
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (import ma-emacs.inputs.emacs-overlay)
      ];
    };
  in {
    # Default formatter for the whole repo: run `nix fmt` to reformat every
    # .nix file consistently (alejandra). Matches the formatter used by the
    # nixvim conform (formatting.nix) and nixd LSP (lsp.nix) configs.
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # System-level configuration for the host "core".
    nixosConfigurations = {
      core = nixpkgs.lib.nixosSystem {
        inherit system;
        # Pass `inputs` through so configuration.nix modules can reference
        # flake inputs (e.g. emacs-overlay, crafted-emacs).
        specialArgs = {inherit inputs;};
        modules = [
        # Apply the emacs-overlay to the system nixpkgs as well, so system
        # packages built against emacs use the same overlay set.
        {nixpkgs.overlays = [(import ma-emacs.inputs.emacs-overlay)];}
          sops-nix.nixosModules.sops
          ./nixos/configuration.nix
        ];
      };
    };

    # Per-user home-manager configuration for pstivy@core.
    homeConfigurations = {
      "pstivy@core" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Merge nixcfg's own flake inputs with maEmacs' inputs so that every
        # module sees everything it needs under one `inputs' set: nixcfg modules
        # use `inputs.nixvim'/`inputs.sops-nix' etc., the maEmacs sub-modules use
        # `inputs.pgmacs'/`inputs.crafted-emacs'/etc.
        extraSpecialArgs = {
          inputs = nixpkgs.lib.recursiveUpdate inputs (ma-emacs.inputs or {});
        };
        modules = [./home-manager/home.nix];
      };
    };
  };
}

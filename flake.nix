{
  description = "furgelisherpa's nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";

    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
    };

    doom-config = {
      url = "path:./home-manager/doom.d";
      flake = false;
    };

    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    hosts,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations.core = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        sops-nix.nixosModules.sops
        hosts.nixosModule
        {
          networking.stevenBlackHosts = {
            enable = true;
            enableIPv6 = true;
            blockFakenews = true;
            blockGambling = true;
            blockPorn = false;
          };
        }
        ./nixos/configuration.nix
      ];
    };

    homeConfigurations."pstivy@core" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
      };
      extraSpecialArgs = {inherit inputs;};
      modules = [./home-manager/home.nix];
    };
  };
}

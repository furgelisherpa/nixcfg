{
  description = "furgelisherpa's nixos configuration";

  inputs = {
    # Pin system packages to the stable NixOS 26.05 channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # Extra unstable channel, available for packages that need newer versions
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
  in {
    # System-level configuration for the host "core"
    nixosConfigurations = {
      core = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./nixos/configuration.nix];
      };
    };

    # Per-user home-manager configuration for pstivy@core
    homeConfigurations = {
      "pstivy@core" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [./home-manager/home.nix];
      };
    };
  };
}

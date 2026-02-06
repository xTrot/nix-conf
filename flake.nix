{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree.url = "github:vic/import-tree";

    # End external global imports.
  };

  outputs = inputs @ {
    flake-parts,
    import-tree,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;}
    (import-tree ./modules);

  # outputs = {
  #   self,
  #   nixpkgs,
  #   ...
  # } @ inputs: {
  #   # use "nixos", or your hostname as the name of the configuration
  #   # it's a better practice than "default" shown in the video
  #
  #   nixosConfigurations.xps13 = nixpkgs.lib.nixosSystem {
  #     specialArgs = {inherit inputs;};
  #     modules = [
  #       ./host/xps13/configuration.nix
  #       inputs.home-manager.nixosModules.default
  #     ];
  #   };
  #
  #   nixosConfigurations.performus = nixpkgs.lib.nixosSystem {
  #     specialArgs = {inherit inputs;};
  #     modules = [
  #       ./host/performus/configuration.nix
  #       inputs.home-manager.nixosModules.default
  #     ];
  #   };
  # };

  # End old flake
}

{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {

    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video

    nixosConfigurations.xps13 = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./host/xps13/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };

    nixosConfigurations.performus = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./host/performus/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };

  };
}

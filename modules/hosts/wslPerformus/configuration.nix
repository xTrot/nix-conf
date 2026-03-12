{
  inputs,
  self,
  ...
}: {
  # Declaring the config for the wslPerformus system.

  # Importing hardware config
  flake.nixosConfigurations.wslPerformus = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      self.nixosModules.wslPerformusHw
      inputs.home-manager.nixosModules.default
      inputs.nixos-wsl.nixosModules.default
      inputs.nix-index-database.nixosModules.default
    ];
  };

  flake.nixosModules.wslPerformusHw = {lib, ...}: {
    imports = [
      self.nixosModules.systemCommon

      self.modules.nixos.enddy
    ];

    wsl.enable = true;
    wsl.defaultUser = "enddy";

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    networking.hostName = "wslPerformus"; # Define your hostname.

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    # environment.systemPackages = with pkgs; [
    #   # Tools
    # ];

    # List services that you want to enable:

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}

{
  inputs,
  self,
  ...
}: {
  # Declaring the config for the performus system.

  # Importing hardware config
  flake.nixosConfigurations.performus = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      self.nixosModules.performusHw
      inputs.home-manager.nixosModules.default
    ];
  };

  flake.nixosModules.performusHw = {pkgs, ...}: {
    imports = [
      self.nixosModules.systemCommon
      self.nixosModules.desktop
      self.nixosModules.av
      self.nixosModules.gaming
      self.nixosModules.keyboard

      self.modules.nixos.enddy

      # disko
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.performus
    ];

    networking.hostName = "performus"; # Define your hostname.

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Install firefox.
    programs.firefox.enable = true;

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

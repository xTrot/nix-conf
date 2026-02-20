{
  inputs,
  self,
  ...
}: {
  # Declaring the config for the performus system.

  # Importing hardware config
  flake.nixosConfigurations.xps13 = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      self.nixosModules.xps13Hw
      inputs.home-manager.nixosModules.default
    ];
  };

  flake.nixosModules.xps13Hw = {pkgs, ...}: {
    imports = [
      self.nixosModules.systemCommon
      self.nixosModules.keyboard

      self.modules.nixos.enddy

      # disko
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.xps13
    ];

    networking.hostName = "xps13"; # Define your hostname.

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      # Hyprland config
      (
        waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
        })
      )
      mako
      libnotify
      waybar
      font-awesome
      swww
      rofi
      networkmanagerapplet
      hyprlock
      hypridle
    ];

    # Hyprland config
    services.xserver.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # List services that you want to enable:

    # Enable power monitoring.
    services.upower.enable = true;

    # Wireguard VPN
    networking.wg-quick.interfaces.wg0.configFile = "/home/enddy/.config/wireguard/xps13.conf";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}

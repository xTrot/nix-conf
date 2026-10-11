{
  flake.nixosModules.desktop = {pkgs, ...}: {
    # Enables gnome desktop applications.

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.dolphin
      thunderbird
      google-chrome
      pgadmin4-desktopmode
      obsidian
      discord
      vscode
      gnome-calculator
    ];

    # Destop module end.
  };
}

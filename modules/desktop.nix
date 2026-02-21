{
  flake.nixosModules.desktop = {pkgs, ...}: {
    # Enables desktop applications.

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

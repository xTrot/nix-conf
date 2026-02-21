{
  flake.nixosModules.av = {pkgs, ...}: {
    # Enables audio visual applications.

    environment.systemPackages = with pkgs; [
      spotify
      gimp2-with-plugins
      digikam
      vlc
      obs-studio
    ];

    # Audio visual module end.
  };
}

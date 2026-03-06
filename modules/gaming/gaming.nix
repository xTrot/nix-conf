{
  flake.nixosModules.gaming = {
    pkgs,
    lib,
    ...
  }: let
    inherit (lib) mkDefault;
  in {
    # Enables steam among other things.

    hardware.graphics.enable = mkDefault true;

    programs = {
      gamemode.enable = true;
      gamescope.enable = true;
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
        extraPackages = with pkgs; [
          SDL2
          gamescope
          er-patcher
        ];
        protontricks.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      steam-run
      steamtinkerlaunch
    ];

    # Gaming module end.
  };
}

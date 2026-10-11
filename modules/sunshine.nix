{inputs, ...}: {
  flake.nixosModules.sunshine = {...}: {
    # Enables Sunshine and tricks to improve it.

    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    hardware.uinput.enable = true;

    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "enddy";

    systemd.user.services.lock-on-login = {
      description = "Lock screen immediately after automatic login";
      wantedBy = ["gnome-session.target"];
      after = ["gnome-session.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStartPre = "${inputs.nixpkgs.legacyPackages."x86_64-linux".coreutils}/bin/sleep 0.3";
        ExecStart = "${inputs.nixpkgs.legacyPackages."x86_64-linux".systemd}/bin/loginctl lock-session";
      };
    };

    # Sunshine module end.
  };
}

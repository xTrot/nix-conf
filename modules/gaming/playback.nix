{
  flake.nixosModules.playback = {
    lib,
    pkgs,
    ...
  }: {
    # Enables the Epilogue Playback Game Boy Catridge Operator

    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

    environment.systemPackages = let
      version = "1.8.0";
      name = "Playback";
      pname = "playback";

      src = pkgs.fetchurl {
        url = "https://releases.epilogue.co/desktop/playback/${version}/release/linux/Playback.AppImage";
        hash = "sha256-hnRUoKrYrtwXe+qBeEYhpzwtV0M/p6pM7OL1dwt4YDs=";
      };

      appimageContents = pkgs.appimageTools.extractType2 {inherit pname version src;};
    in [
      (pkgs.appimageTools.wrapType2 rec {
        inherit name pname version src appimageContents;

        meta = {
          mainProgram = "${pname}";
          description = "Playback software for Epilogue Operator";
          homepage = "https://www.epilogue.co/";
          downloadPage = "https://www.epilogue.co/downloads";
          sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
          platforms = ["x86_64-linux"];
        };

        extraInstallCommands = ''
          install -m 444 -D ${appimageContents}/${name}.desktop $out/share/applications/${name}.desktop
          install -m 444 -D ${appimageContents}/${name}.png \
            $out/share/icons/hicolor/512x512/apps/${name}.png
          substituteInPlace $out/share/applications/${name}.desktop \
            --replace-fail 'Exec=${name}' 'Exec=${pname}'
        '';
      })
    ];

    users.users.enddy = {
      extraGroups = ["dialout" "plugdev"];
    };

    services.udev.extraRules = ''
      # GB Operator
      SUBSYSTEM=="usb", ATTR{idVendor}=="16d0", ATTR{idProduct}=="123b", MODE="0666"
      SUBSYSTEM=="usb", ATTR{idVendor}=="16d0", ATTR{idProduct}=="123c", MODE="0666"
      SUBSYSTEM=="usb", ATTR{idVendor}=="16d0", ATTR{idProduct}=="123d", MODE="0666"
      SUBSYSTEM=="tty", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="123b", MODE="0666"
      SUBSYSTEM=="tty", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="123c", MODE="0666"
      SUBSYSTEM=="tty", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="123d", MODE="0666"
      # SN Operator
      SUBSYSTEM=="usb", ATTR{idVendor}=="16d0", ATTR{idProduct}=="1416", MODE="0666"
      SUBSYSTEM=="usb", ATTR{idVendor}=="16d0", ATTR{idProduct}=="1417", MODE="0666"
      SUBSYSTEM=="usb", ATTR{idVendor}=="16d0", ATTR{idProduct}=="123e", MODE="0666"
      SUBSYSTEM=="tty", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="1416", MODE="0666"
      SUBSYSTEM=="tty", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="1417", MODE="0666"
      SUBSYSTEM=="tty", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="123e", MODE="0666"
    '';

    # Playback module end.
  };
}

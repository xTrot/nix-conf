{
  flake.nixosModules.wlsPerformusHw = {...}: {
    imports = [
      <nixos-wsl/modules>
    ];

    wsl.enable = true;
  };
}

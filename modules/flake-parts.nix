{
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  options.flake.diskoConfigurations = lib.mkOption {
    type = lib.types.attrsOf lib.types.deferredModule;
    default = {};
    description = "My custom disko configurations set";
  };

  config = {
    debug = true;

    systems = [
      "x86_64-linux"
    ];
  };
}

{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  config = {
    debug = true;

    systems = [
      "x86_64-linux"
    ];
  };
}

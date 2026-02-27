return {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'shell.nix', '.git' },
  settings = {
    nixd = {
      nixpkgs = {
        expr = 'import <nixpkgs> { }',
      },
      filetypes = { 'nix' },
      formatting = {
        command = { 'alejandra' },
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake /home/enddy/nix-conf/).nixosConfigurations.performus.options',
        },
        home_manager = {
          expr = '(builtins.getFlake /home/enddy/nix-conf/).homeConfigurations.performus.options.home-manager.users.type.getSubOptions []',
        },
        flake_parts = {
          expr = '(builtins.getFlake /home/enddy/nix-conf/).debug.options',
        },
        flake_parts2 = {
          expr = '(builtins.getFlake /home/enddy/nix-conf/).currentSystem.options',
        },
      },
    },
  },
}

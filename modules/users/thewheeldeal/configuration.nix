{...}: let
  username = "thewheeldeal";
in {
  flake.modules.nixos."${username}" = {pkgs, ...}: {
    # User Definition Module

    users.users."${username}" = {
      isNormalUser = true;
      description = "${username}";
      extraGroups = ["networkmanager" "wheel" "input" "uinput"];
      initialPassword = "changeme";
    };

    programs.git = {
      enable = true;
      config = {
        user.name = "xTrot";
        user.email = "enddyygf93@live.com";
        init.defaultBranch = "main";
        push.autosetupremote = true;
      };
    };

    # User Definition Module End
  };
}

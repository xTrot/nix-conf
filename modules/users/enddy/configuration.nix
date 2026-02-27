{inputs, ...}: let
  username = "enddy";
in {
  flake.modules.nixos."${username}" = {...}: {
    users.users."${username}" = {
      isNormalUser = true;
      description = "${username}";
      extraGroups = ["networkmanager" "wheel" "input" "uinput"];
      initialPassword = "changeme";
      openssh.authorizedKeys.keys = [
        # performus
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPDuE+pkbyRNO/F4SMUp/ULgRkqnk2B+aGV00p/Ip6S3 enddyygf93@live.com"
        # xps13
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOC5Dti5TAo0dfp++qWXmyNvTZcPhlixNsIB/GFVqKt+ enddyygf93@live.com"
      ];
    };

    home-manager.users."${username}" = {
      imports = [
        inputs.self.modules.homeManager."${username}"
      ];
    };
  };
}

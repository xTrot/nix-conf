{inputs, ...}: let
  username = "enddy";
in {
  # Home-Manager

  # Linking
  flake.homeConfigurations.${username} = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
    modules = [
      inputs.self.modules.homeManager.${username}
      {nixpkgs.config.allowUnfree = true;}
    ];
  };

  # Actual Module
  flake.modules.homeManager."${username}" = {pkgs, ...}: {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # Deprecated: (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
      nerd-fonts.fira-code

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')

      # CLI stuff
      vim
      usbutils
      htop
      lsof
      wget
      curl
      tree
      dos2unix
      mlocate
      fastfetch
      stow
      postgresql_18
      rclone
      lazygit
      lazydocker
      opencode
      nix-inspect
      bat
      bat-extras.batman
      tealdeer
      wikiman

      # Neovim dependencies
      gnumake
      gcc
      ripgrep
      unzip
      # git it is a dependency but I install somewhere else.
      xclip
      lua-language-server
      python3
      cargo # nil dependency
      luarocks
      fd
      lua5_1

      # Development
      alejandra
      go
      gotools
      jdk
      maven
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/enddy/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
      EDITOR = "nvim";

      # Hint electron apps to use wayland.
      NIXOS_OZONE_WL = "1";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # git config
    programs.git = {
      enable = true;
      settings = {
        user.name = "xTrot";
        user.email = "enddyygf93@live.com";
        init.defaultBranch = "main";
        push.autosetupremote = true;
      };
    };

    # ssh config
    services.ssh-agent.enable = true;
    programs.ssh = {
      enable = true;
      extraConfig = ''
        ControlMaster auto
        ControlPath ~/.ssh/controlmasters/%r@%h:%p
        ControlPersist 10m

        ServerAliveInterval 60
        ServerAliveCountMax 3
        ConnectionAttempts 3

        AddKeysToAgent yes
      '';
    };

    # ghostty config
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        theme = "Catppuccin Mocha";
      };
    };

    programs.bash = {
      enable = true;
    };

    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        {plugin = vim-tmux-navigator;}
        {plugin = resurrect;}
        {plugin = yank;}
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavour "mocha"
          '';
        }
      ];
      extraConfig = ''
        set-option -sa terminal-overrides ",xterm*:Tc"
        set -g mouse on

        unbind C-b
        set -g prefix C-Space
        bind C-Space send-prefix

        # Vim style pane selection
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Start windows and panes at 1, not 0
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        # Use Alt-arrow keys without prefix key to switch panes
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # Shift arrow to switch windows
        bind -n S-Left  previous-window
        bind -n S-Right next-window

        # Shift Alt vim keys to switch windows
        bind -n M-H previous-window
        bind -n M-L next-window

        # set vi-mode
        set-window-option -g mode-keys vi
        # keybindings
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
      '';
    };

    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
      };
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    programs.neovim.plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };
}

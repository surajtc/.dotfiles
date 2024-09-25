{
  config,
  inputs,
  pkgs,
  lib,
  variables,
  ...
}: {
  imports = [
    ../../config/nixvim
    ../../config/hypr
    ../../config/firefox
  ];

  home.username = "${variables.userName}";
  home.homeDirectory = "/home/${variables.userName}";

  home.stateVersion = "24.05";

  # mytex = pkgs.texlive.withPackages (ps: [ps.fontspec]);

  home.packages = with pkgs; [
    # gcc
    # nodejs
    # pnpm
    # yarn
    # python3
    alejandra
    brave
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.thunar-media-tags-plugin
    rofi-wayland
    brightnessctl
    gnome-themes-extra
    gtk-engine-murrine
    gtk3
    gtk4
    adwaita-qt
    # TODO: Move this to devShells
    python3
    nodejs
    pnpm
    wl-clipboard
    wl-clipboard-x11
    wl-clip-persist
    cliphist
    networkmanagerapplet
    # qt6-wayland
    grim
    slurp
    # mytex
    texliveFull
    open-webui
  ];

  home.file = {
    # ".config/nvim" = {
    #     source = ../../config/nvim;
    #     recursive = true;
    #   };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userName = variables.gitUserName;
    userEmail = variables.gitEmail;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.ignoreDups = true;
    history.ignoreAllDups = true;
    history.ignoreSpace = true;

    defaultKeymap = "emacs";

    cdpath = ["$HOME/Documents" "$HOME/Documents/CodeBase"];

    shellAliases = {
      ll = "ls -la";
      ee = "tree -L 3";

      ga = "git add .";
      gc = "git commit -m";
      gp = "git push -u origin";

      nix-cfg = "cd $HOME/.dotfiles && nvim";
      nix-rbs = "sudo nixos-rebuild switch --show-trace --flake .";
    };

    initExtra = "fastfetch";
  };

  programs.starship.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      cursor_shape = "block";
      window_padding_width = 10;
      enable_audio_bell = "no";

      background = lib.mkForce "${config.lib.stylix.colors.withHashtag.base08}";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;

    userSettings = {
      "workbench.sideBar.location" = "right";
      "editor.cursorStyle" = "block";
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "window.menuBarVisibility" = "toggle";
      "workbench.startupEditor" = "none";
    };

    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-toolsai.jupyter
      dbaeumer.vscode-eslint
      zainchen.json
      ritwickdey.liveserver
      ms-azuretools.vscode-docker
      eamodio.gitlens
      esbenp.prettier-vscode
      formulahendry.auto-rename-tag
      formulahendry.auto-close-tag
      formulahendry.code-runner
      ms-vscode-remote.remote-ssh
      christian-kohler.path-intellisense
      yzhang.markdown-all-in-one
      bbenoist.nix
      kamadorueda.alejandra
      supermaven.supermaven
    ];
  };

  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    style.name = "adwaita";
    platformTheme.name = "gtk";
  };

  stylix = {
    enable = true;
    image = ../../config/wallpapers/default.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    cursor.size = 24;

    targets.nixvim.enable = false;

    fonts = {
      sizes = {
        applications = 9;
        desktop = 9;
        popups = 9;
        terminal = 10;
      };

      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}

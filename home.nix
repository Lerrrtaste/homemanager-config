#        ____                                         _____                                __                     __
#       / /\ \                                       / /\_ \                              /\ \__                 /\ \__
#      / /\ \ \___     ___     ___ ___      __      / /\//\ \      __   _ __   _ __   _ __\ \ ,_\    __      ____\ \ ,_\    __
#     / /  \ \  _ `\  / __`\ /' __` __`\  /'__`\   / /   \ \ \   /'__`\/\`'__\/\`'__\/\`'__\ \ \/  /'__`\   /',__\\ \ \/  /'__`\
#    / /    \ \ \ \ \/\ \L\ \/\ \/\ \/\ \/\  __/  / /     \_\ \_/\  __/\ \ \/ \ \ \/ \ \ \/ \ \ \_/\ \L\.\_/\__, `\\ \ \_/\  __/
#   /_/      \ \_\ \_\ \____/\ \_\ \_\ \_\ \____\/_/      /\____\ \____\\ \_\  \ \_\  \ \_\  \ \__\ \__/.\_\/\____/ \ \__\ \____\
#  /_/        \/_/\/_/\/___/  \/_/\/_/\/_/\/____/_/       \/____/\/____/ \/_/   \/_/   \/_/   \/__/\/__/\/_/\/___/   \/__/\/____/
#

{ config, pkgs, ... }:

let
  conf_src_base = "home/lerrrtaste/.local/share/chezmoi/dot_config/";
  conf_dest_base = "/home/lerrrtaste/.config/";
  conf_home = "nixpkgs/home.nix";
  conf_os = "nixos/configuration.nix";
  scripts_src = if builtins.pathExists("/home/lerrrtaste/repos/github.com/lerrrtaste/custom-dwm") then
    /home/lerrrtaste/repos/github.com/lerrrtaste/scripts
  else
    builtins.fetchGit "https://github.com/lerrrtaste/scripts.git";  # to force download --option tarball-ttl 0 (default 1 hr)
in
{
  nixpkgs.config.allowUnfree = true;

  # Import NUR
  # TODO pin
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  # Import my other modules
  imports = [
    ./vim/init.nix
    ./emacs/init.nix
    ./modules/ncmpcpp.nix
    #./modules/firefox.nix # FIXME google docs doesnt load
  ];

  # Setup Home
  home.username = "lerrrtaste";
  home.homeDirectory = "/home/lerrrtaste";

  home.sessionVariables = {
    EDITOR="vim";
    VISUAL="vim";
  };

  #xdg = {
  #  enable = true;
  #  mime.enable = true;
  #  mimeApps.enable = true;

  #  mimeApps = {  # FIXME asap
  #    defaultApplications = {
  #      "text/plain" = "emc";
  #      "application/pdf" = ["zorg.pwmt.zathura-pdf-mupdf.desktop"];  #FIXME overriden by libreoffice
  #      "video/*" = "mpv";
  #      "image/*" = "sxvi";
  #    };
  #  };
  #};

  home.file.".xinitrc" = {
    source = ./xinitrc;
  };

  # Setup Keybindings
  # TODO (see if it can be replaced with dwm autostart cmd)
  services.xcape = {
    enable = true;
    mapExpression = {
      Caps_Lock = "Escape";
    };
  };

  # Packages
  home.packages = with pkgs; [
    # general
    maim  # screenshoots
    # barrier
    thefuck
    termdown

    # ide
    # jetbrains.clion
    # jetbrains.idea-ultimate
    # godot # TODO reanable once v3.5.x

    # dev tools
    git
    rsync
    # docker
    # docker-compose
    # gnumake

    # files
    git-annex
    # sshfs
    p7zip
    trash-cli

    # media
    # mkchromecast
    mpv
    sxiv  # image viewer
    gimp
    # python39Packages.deemix  # TODO manage config with home.files
    qbittorrent
    youtube-dl

    # office
    libreoffice
    zathura
    firefox # TODO keep as seperate package (ff from module with different name, then add keybinds (shift)-alt-b to open them)
    # texlive.combined.scheme-full  # latex full (ca 5 gb!)
    teams
    # protonmail-bridge # TODO write emacs mu4e config

    # passwords
    libsecret
    keepassxc
    onlykey
    # onlykey-agent # TODO one day (crashes, how to use?)
    # protonvpn-cli

    # Deps
    # busybox  # git-annex webapp TODO conflicts with default
    libmusicbrainz # beets
    picard # beets
    # jre # language tool emacs layer
    # languagetool
    # python310Packages.gdtoolkit # for gdscript-mode autoformatting
  ];

  # Packages with options
  programs.bash = {
    enable = true;
    shellAliases = {  # TODO port edit aliases to dashboard keymap
      # Edit desitnation state
      neo = "vim " + conf_dest_base + conf_os;
      neh = "vim " + conf_dest_base + conf_home; 

      # Edit source state
      nco = "chezmoi edit " + conf_dest_base + conf_os;
      nch = "chezmoi edit " + conf_dest_base + conf_home;
      
      # Open working state dir
      nlo = "lf " + conf_dest_base + "/nixos";
      nlh = "lf " + conf_dest_base + "/nixpkgs";
      
      # Switch config
      nso = "sudo nixos-rebuild switch";
      nsh = "home-manager switch";

      # Other
      gas = "git annex sync";
      gasc = "git annex sync --content";
      gad = "git annex add .";

      # Files
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";
      mkdir = "mkdir -p";
      ncdu = "ncdu --exclude .git --exclude-kernfs -L -rr --confirm-quit";

      # Termdowns
      td = "termdown -b";
      tdc = "termdown -b -c 60"; # critical

    };

    # TODO automatically fetch using fetchFromGithub and source all files
    initExtra = ''
      # Append custom scripts to Path
      export PATH=$PATH:${scripts_src}

      # Enable onlykey-agent
      # export GNUPGHOME=~/.gnupg/onlykey;

      # Source scripts with "src_" prefix
      for f in ${scripts_src}/src_*; do source $f; done

      # the fuck
      eval "$(thefuck --alias)"

      # direnv
      eval "$(direnv hook bash)" # for direnv
    '';
  };

  # Python Dev Envs (TODO move to nix shell?)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

 # services.barrier = {
 #   client.enable = if builtins.getEnv "HOSTNAME" == "mrfusion" then true else false;
 #   client.server = "delorean";
 # };

  services.mpd = {
    enable = true;
    musicDirectory = "/home/lerrrtaste/annex/music/library";
    playlistDirectory = "/home/lerrrtaste/annex/music/playlists";
  };

  # TODO configure with spotify secrets
  #services.mopidy = {
  #  enable = true;
  #  extensionPackages = [ pkgs.mopidy-spotify ];
  #  configuration = ''
  #    [core]
  #    restore_state = false;
  #  '';
  #};

  programs = { 
    git = {
      enable = true;
      userName = "Laurenz Foglia";
      userEmail = "lerrrtaste@protonmail.com";
      diff-so-fancy.enable = true;
    };

    beets = {
      enable = true;
      settings = {
        directory = "/home/lerrrtaste/annex/music/library";
        import_dir = "/home/lerrrtaste/Downloads/deemix";
        asciify_paths = "yes";
        import = {
          copy = "no";
          move = "yes";
          from_scratch = "no";
          # autotag = "no";  # maybe enable if it works well
          bell = "yes";
        };
        plugins = [
          "lyrics"
          "duplicates"  # list duplicates with beet duplicate
          "albumtypes"  # tag type of album in name (album, single, compilation, etc)
          "deezer"  # enter deezer id (additional to musicbrainz)
          "missing"  # beet missing for missing tracks
          "unimported"  # beet unimported for tracks still in the import dir
        ];
        unimported = {
          ignore_subdirectories = "no";
        };
      };
    };

    lf = {
      enable = true;
      settings = { };
      keybindings = {
        D = "trash";
        U = "!du -chs * | sort -h | less";
        I = "set hidden!";

        # bookmarks
        m = "mark-save";
        M = "mark-remove";
        L = "mark-load";
        H = "cd ~";

        # movement
        "J" = "bottom";
        "K" = "top";
      };
      commands = {
        trash = "trash-put $fx"; # TODO print feedback (maybe require confirm y/n)
      };
      # TODO replace with pistol (https://github.com/workflow/nixos-config/blob/7a57692adaa883b23c213fc7fe5c4be38e56eb81/home/lf.nix#L115)
      previewer.source = pkgs.writeShellScript "pv.sh" ''
            #!/bin/sh
            case "$1" in
                *.tar*) tar tf "$1";;
                *.zip) unzip -l "$1";;
                *.rar) unrar l "$1";;
                *.7z) 7z l "$1";;
                *.pdf) pdftotext "$1" -;;
                *) highlight -O ansi "$1" || cat "$1";;
            esac
          '';
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses"; 
  }; 

  # home.useUserPackages = true;  # install packages to /etc/profiles/per-user/lerrrtaste (instead of home)
  # home.useGlobalPkgs = true;  # use system nixpkgs instead of a seperate home-manager one

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

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
  scripts_src = if builtins.pathExists
  ("/home/lerrrtaste/repos/github.com/lerrrtaste/scripts") then
    /home/lerrrtaste/repos/github.com/lerrrtaste/scripts
  else
    builtins.fetchGit
    "https://github.com/lerrrtaste/scripts.git"; # to force download --option tarball-ttl 0 (default 1 hr)
in {
  nixpkgs.config.allowUnfree = true;

  # Import NUR
  # TODO pin
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
  };

  # Import my other modules
  imports = [
    ./vim/init.nix
    ./emacs/init.nix
    ./modules/ncmpcpp.nix
    ./modules/firefox.nix
  ];

  # Setup Home
  home.username = "lerrrtaste";
  home.homeDirectory = "/home/lerrrtaste";

  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  manual.manpages.enable = false;

  xdg = {
    mimeApps = {
      enable = true;
      associations.added = {
        "application/pdf" = ["org.pwmt.zathura.desktop"];
      };
      defaultApplications = {
        "application/pdf" = ["org.pwmt.zathura.desktop"];
      };
    };
  };
   # enable = true;
   # mime.enable = true;
   # mimeApps.enable = true;

   # mimeApps = {  # FIXME asap
   #   defaultApplications = {
   #     "text/plain" = "emc";
   #     "application/pdf" = ["zorg.pwmt.zathura-pdf-mupdf.desktop"];  #FIXME overriden by libreoffice
   #     "video/*" = "mpv";
   #     "image/*" = "sxvi";
   #   };
   # };
  # };

  home.file.".xinitrc" = { source = ./xinitrc; };

  # Setup Keybindings
  # TODO (see if it can be replaced with dwm autostart cmd)
  services.xcape = {
    enable = true;
    mapExpression = { Caps_Lock = "Escape"; };
  };

  # Packages
  home.packages = with pkgs; [
    # general
    maim # screenshoots
    # barrier
    thefuck
    termdown
    tipp10
    drawio
    redshift

    # ide
    # jetbrains.clion
    # jetbrains.idea-ultimate
    # godot # TODO reanable once v3.5.x
    godot_4

    # dev tools
    git
    rsync
    # docker
    # docker-compose
    # gnumake
    xcolor

    # files
    git-annex
    bup
    # sshfs
    p7zip
    trash-cli
    tree

    # media
    # mkchromecast
    mpv
    sxiv # image viewer
    gimp
    python39Packages.deemix  # TODO manage config with home.files
    # qbittorrent
    youtube-dl

    # office
    libreoffice
    zathura
    tridactyl-native
    texlive.combined.scheme-full  # latex full (ca 5 gb!)
    teams
    # protonmailo-bridge # TODO write emacs mu4e config
    # firefox
    zotero

    # passwords
    libsecret
    keepassxc
    onlykey
    # onlykey-agent # TODO one day (crashes, how to use?)
    # protonvpn-cli

    # Deps
    xdotool # scripts
    xsel # scripts
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
    shellAliases = { # TODO port edit aliases to dashboard keymap
      # Edit desitnation state
      neo = "vim " + conf_dest_base + conf_os;
      neh = "vim " + conf_dest_base + conf_home;

      # Edit source state
      # nco = "chezmoi edit " + conf_dest_base + conf_os;
      # nch = "chezmoi edit " + conf_dest_base + conf_home;

      # Open working state dir
      nlo = "lf " + conf_dest_base + "/nixos";
      nlh = "lf " + conf_dest_base + "/nixpkgs";

      # Switch config
      nso = "sudo nixos-rebuild switch";
      nsh = "home-manager switch";
      nua =
        "nix-channel --update && sudo nix-channel --update && sudo nixos-rebuild switch && home-manager switch";

      # Annex
      gas = "git annex sync";
      gasc = "git annex sync --content";
      gad = "git annex add .";

      gal = "git annex lock .";
      gau = "git annex unlock .";

      gol = "git annex lock ~/annex/org";
      gou = "git annex unlock ~/annex/org";

      ga = "git annex";

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

      #bup
      export BUP_DIR=/media/raid/bup
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
  #
  programs.btop = {
    enable = true;
    settings = {
      #* Name of a btop++/bpytop/bashtop formatted ".theme" file, "Default" and "TTY" for builtin themes.
      #* Themes should be placed in "../share/btop/themes" relative to binary or "$HOME/.config/btop/themes"
      color_theme = "Default";

      #* If the theme set background should be shown, set to False if you want terminal background transparency.
      theme_background = true;

      #* Define presets for the layout of the boxes. Preset 0 is always all boxes shown with default settings. Max 9 presets.
      #* Format: "box_name:P:G,box_name:P:G" P=(0 or 1) for alternate positions, G=graph symbol to use for box.
      #* Use whitespace " " as separator between different presets.
      #* Example: "cpu:0:default,mem:0:tty,proc:1:default cpu:0:braille,proc:0:tty"
      presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";

      vim_keys = true;
      rounded_corners = true;

      #* Default symbols to use for graph creation, "braille", "block" or "tty".
      #* "braille" offers the highest resolution but might not be included in all fonts.
      #* "block" has half the resolution of braille but uses more common characters.
      #* "tty" uses only 3 different symbols but will work with most fonts and should work in a real TTY.
      graph_symbol = "braille";
      graph_symbol_cpu = "default";
      graph_symbol_mem = "default";
      graph_symbol_net = "default";
      graph_symbol_proc = "default";

      shown_boxes = "proc cpu mem net";

      update_ms = 2000;

      #* Processes sorting, "pid" "program" "arguments" "threads" "user" "memory" "cpu lazy" "cpu responsive",
      #* "cpu lazy" sorts top process over time (easier to follow), "cpu responsive" updates top process directly.
      proc_sorting = "cpu lazy";

      proc_reversed = false;
      proc_tree = false;
      proc_colors = true;
      proc_gradient = true;
      proc_per_core = true;
      proc_mem_bytes = true;

      #* Use /proc/[pid]/smaps for memory information in the process info box (very slow but more accurate)
      proc_info_smaps = false;

      #* Show proc box on left side of screen instead of right.
      proc_left = false;
      cpu_graph_upper = "total";
      # cpu_graph_lower = "total";
      # cpu_invert_lower = True
      cpu_single_graph = true;
      show_uptime = true;

      temp_scale = "celsius";
      disks_filter = "exclude=/boot";

      show_swap = true;
      swap_disk = false;

      only_physical = true;

      #* Toggles if io activity % (disk busy time) should be shown in regular disk usage view.
      show_io_stat = true;

      #* Toggles io mode for disks, showing big graphs for disk read/write speeds.
      io_mode = false;

      #* Set to True to show combined read/write io graphs in io mode.
      io_graph_combined = false;

      #* Set fixed values for network graphs in Mebibits. Is only used if net_auto is also set to False.
      net_download = 100;

      net_upload = 100;

      #* Use network graphs auto rescaling mode, ignores any values set above and rescales down to 10 Kibibytes at the lowest.
      net_auto = true;

      #* Sync the auto scaling for download and upload to whichever currently has the highest scale.
      net_sync = false;

      #* Show battery stats in top right if battery is present.
      show_battery = true;
    };
  };

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
  # services.redshift = {
  #   enable = true;
  #   provider = "manual";
  #   latitude = "52.52";
  #   longitude = "13.41";
  #   enableVerboseLogging = true;
  #   settings = {
  #     redshift = {
  #       adjustment-method = "randr";
  #     };
  #     environment = {
  #       DISPLAY = ":0";
  #     };
  #     # randr = {
  #     #   screen = 1;
  #     # };
  #   };
  # };
  # systemd.services."" #TODO override targets, no graphical-session.target with startx!
  #   wantedBy = [ "multi-user.target" ];
  # };

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
        import_dir = "/media/ssd/deemix/downloads";
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
          "duplicates" # list duplicates with beet duplicate
          "albumtypes" # tag type of album in name (album, single, compilation, etc)
          "deezer" # enter deezer id (additional to musicbrainz)
          "missing" # beet missing for missing tracks
          "unimported" # beet unimported for tracks still in the import dir
        ];
        paths = {
          default = "$albumartist/$album%aunique{}/$track $title";
          singleton = "$artist/singles/$title";
          comp = "Compilations/$album%aunique{}/$track $title";
        };
        unimported = { ignore_subdirectories = "no"; };
      };
    };

    lf = {
      enable = true;
      settings = { };
      keybindings = {
        D = "trash";
        R = "trash-restore";
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
        # ask for y/n confirmation and then run trash-put $fx
        trash = ''
          ''${{
                    read -p "Trash $fx? [y/N] " -n 1 -r
                    echo
                    if [[ $REPLY =~ ^[Yy]$ ]]
                    then
                      trash-put "$fx"
                    fi
                  }}'';
        trash-restore = ''
          ''${{
                    trash-restore $PWD
                  }}'';
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

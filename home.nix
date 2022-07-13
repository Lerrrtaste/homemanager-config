{ config, pkgs, ... }:

let
  conf_src_base = "home/lerrrtaste/.local/share/chezmoi/dot_config/";
  conf_dest_base = "/home/lerrrtaste/.config/";
  conf_home = "nixpkgs/home.nix";
  conf_os = "nixos/configuration.nix";
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
    ./development.nix 
    ./vim/init.nix
    ./emacs/init.nix
    ./modules/ncmpcpp.nix
    # ./firefox/init.nix # FIXME google docs doesnt load
  ];

  # Setup Home
  home.username = "lerrrtaste";
  home.homeDirectory = "/home/lerrrtaste";

  home.sessionVariables = {
    EDITOR="vim";
    VISUAL="vim";
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "emc";
    "video/*" = "mpv";
    "image/*" = "sxvi";
    # "inode/directory" = "lf";
  };

  # Setup Keybindings FIXME
  services.xcape = {
    enable = true;
    mapExpression= {
      Caps_Lock = "Escape";
    };
  };

  # Packages
  home.packages = with pkgs; [
    # TODO mkchromecast + audio controls

    # ide
    jetbrains.clion
    jetbrains.idea-ultimate

    # dev tools
    git
    rsync
    docker
    docker-compose
    gnumake

    # files
    # duplicati
    git-annex
    lf
    sshfs
    p7zip

    # media
    # mpd # music player daemon (alternatively mopidy has spotify control (nonfree))
    mkchromecast
    mpv
    sxiv  # image viewer
    gimp
    python39Packages.deemix  # TODO manage config with home.files

    # office
    libreoffice
    zathura
    firefox # TODO keep as seperate package (ff from module with different name, then add keybinds (shift)-alt-b to open them)

    # passwords
    libsecret
    keepassxc
    onlykey
    # protonvpn-cli

    # Deps
    # busybox  # git-annex webapp
    libmusicbrainz
    picard
  ];

  # Packages with options
  programs.bash = {
    enable = true;
    shellAliases = {
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
      emc = "emacsclient -c -a 'emacs --daemon'";
      gas = "git annex sync";
      gasc = "git annex sync --content";
    };
    
  };


  services.mpd = {
    enable = true;
    musicDirectory = "/home/lerrrtaste/annex/music/library";
    playlistDirectory = "/home/lerrrtaste/annex/music/playlists";
  };

  programs = { 
    git = {
      enable = true;
      userName = "Lerrrtaste";
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
      };
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

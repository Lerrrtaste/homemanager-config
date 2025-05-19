{ config, lib, pkgs, ... }:

builtins.trace("- Loading Module: music.nix")
{
  imports =
    [
      ./ncmpcpp.nix
    ];

  home.packages = with pkgs; [
    python312Packages.deemix
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "/home/lerrrtaste/annex/media/music/libraries";
    playlistDirectory = "/home/lerrrtaste/annex/media/music/playlists";
    network.startWhenNeeded = true;
    extraConfig = ''
      # for visualizer in ncmpcpp
      audio_output {
        type                    "fifo"
        name                    "my_fifo"
        path                    "/tmp/mpd.fifo"
        format                  "44100:16:2"
      }
      audio_output {
        type                    "pulse"
        name                    "PulseAudio"
      }
    '';
  };

  # services.mpdscribble = {
  #   enable = true;
  #   journalInterval = 45;
  #   endpoints."last.fm" = {
  #     username = "sequel883";
  #     passwordFile = "/run/secretsagenix/lastfm_password";
  #   };
  # };

  programs.beets = {
    enable = true;
    settings = {
      directory = "/home/lerrrtaste/annex/media/music/libraries"; # where the music is stored
      library = "/home/lerrrtaste/annex/media/music/beets.db";
      import_dir = "/home/lerrrtaste/beets_import";
      asciify_paths = "yes";
      import = {
        copy = "yes"; # no to manage files in place (in directory), to keep playlists
        # move = "yes"; # yes to move cleaned files to directory
        from_scratch = "no";
        # autotag = "no";  # maybe enable if it works well
        bell = "yes";
      };
      plugins = [
        "albumtypes"
        "duplicates" # list duplicates with beet duplicate
        "albumtypes" # tag type of album in name (album, single, compilation, etc)
        "deezer" # enter deezer id (additional to musicbrainz)
        "missing" # beet missing for missing tracks
        "unimported" # beet unimported for tracks still in the import dir
      ];
      albumtypes = { # plugin
        types = {
          ep = "EP";
          single = "Single";
          soundtrack = "OST";
          live = "Live";
          compilation = "Anthology";
          remix = "Remix";
        };
        ignore_va = "compilation";
        bracket = "[]";
      };
      paths = {
      # paths = ''
      #   default: artists/$albumartist/[$year]$atypes $album%aunique{}/$track $title
      #   singleton: artists/$albumartist/EPs/$year - $title

      #   comp: compilations/$album%aunique{}/$track $title

      #   albumtype:sountrack: soundtrack/$album%aunique{}/$track $title
      # '';
        # default = "$albumartist/[$year]$atypes $album%aunique{}/$track $title";
        # singleton = "$albumartist/singles/$title";
        # comp = "Compilations/$album%aunique{}/$track $title"; # for releases with non dominant artist (various artists)
        default = "artists/$albumartist/$atypes$year $album%aunique{}/$track $title";
        singleton = "artists/$albumartist/EPs/$year $title";
        comp = "compilations/$album%aunique{}/$track $title"; # for releases with non dominant artist (various artists)
        "albumtype:soundtrack" = "soundtracks/$album%aunique{}/$track $title";
      };
      unimported = { ignore_subdirectories = "no"; };
    };
  };

  # services.mopidy = {
  #   enable = true;
  #   extensionPackages = [
  #     pkgs.mopidy-mpd
  #     pkgs.mopidy-local
  #     # pkgs.mopidy-party # TODO !!!
  #   ]; # soptifyy todo
  #   settings = {
  #     mpd = {
  #       enabled = true;
  #       # hostname = "1
  #       # port = 6600;
  #       # password = "";
  #     };
  #     local = {
  #       enabled = true;
  #       media_dir = "/home/lerrrtaste/annex/music/library";
  #       scan_follow_symlinks = true;
  #     };
  #     http = { enabled = false; };
  #   };
  # };
    # musicDirectory = "/home/lerrrtaste/annex.old/music/library";
    # playlistDirectory = "/home/lerrrtaste/annex/music/playlists";
  # };

  #services.mopidy = { # TODO fix maybe
  #  enable = true;
  #  extensionPackages = [
  #    pkgs.mopidy-mpd
  #    pkgs.mopidy-local
  #    pkgs.mopidy-spotify
  #    pkgs.mopidy-notify
  #    pkgs.mopidy-ytmusic
  #    pkgs.mopidy-mopify
  #    # pkgs.mopidy-spotify-web
  #    # pkgs.mopidy-party # TODO !!!
  #  ]; # soptifyy todo
  #  settings = {
  #    mpd = {
  #      enabled = true;
  #      # hostname = "1
  #      # port = 6600;
  #      # password = "";
  #    };
  #    local = {
  #      enabled = true;
  #      media_dir = "/home/lerrrtaste/annex/music/library";
  #      scan_follow_symlinks = true;
  #    };
  #    spotify = {
  #      enabled = true;
  #      client_id = builtins.readFile /run/agenix/spf-id;
  #      client_secret = builtins.readFile /run/agenix/spf-secret;
  #      username = "lerrrtaste";
  #      password = builtins.readFile /run/agenix/spf-pass;
  #      allow_playlist = false;
  #    };
  #    ytmusic = {
  #      enabled = true;
  #      auth_json = "/tmp/auth.json";
  #};
  ## spotify-web = {
  ##   enabled = true;
  ##   client_id = builtins.readFile /run/agenix/spf-id;
  ##   client_secret = builtins.readFile /run/agenix/spf-secret;
  ## };
  ## TODO m3u playlists_dir
  #file = { enabled = false; };
  #http = { enabled = true; };
  #mopify = {
  #enabled = true;
  #};
  #};
  #};

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

}

{ config, lib, pkgs, ... }:

builtins.trace("- Loading Module: music.nix")
{
  imports =
    [
      ./ncmpcpp.nix
    ];

  home.packages = with pkgs; [
    python312Packages.deemix # classic deemix terminal

    # navidrome
    # miniserve
    # kics
    # srm
    # kirc # irc
    # dnsviz # analyze dns and dnsse behavior
    # wapiti
    # crowdsec

    # # Players
    # musicpod # music, radio, tv, podcasts
    # kdePackages.audiotube
    # gpodder # podcasts
    # fooyin  # customizable
    # famistudio # news editor
    # clementine


    # gixy # static nic ocnfig analyszer
    # # Playback
    # mpv
    # # ncmcpp # just the best
    # strawberry # Music player and music collection organizer
    # clementine # multiplatform
    # # ytmdesktop
    # # ytmdl # ytm music dl
    # ytdl-sub
    # nuclear # finds free music streams
    # sayonara # music player
    # ytui-music # yt terminal client
    # exaile
    # lx-music-desktop
    # harmony-music # cross platform
    # recordbox # simple player
    # muzika # elegant
    # lollypop
    # libprojectm
    # gonic
    # vidcutter
    # mdevctl
    # gocatcli
    # udiskie
    # music-assistant
    # testdisk-qt
    # github-desktop
    # git-repo-updater
    # github-copilot-cli
    # git-credential-keepassxc
    # media-downloader
    # tplay

    # mullvad-vpn
    # dsvpn
    # ivpn-ui
    # ivpn
    # protonvpn-gui
    # badvpn
    # headscale
    # netbird

    # # security
    # ssh-mitm
    # gss
    # websecprobe
    # badrobot
    # zenmap
    # sssd
    # scorecard
    # ssh-mitm
    # vulnix
    # checkmate
    # bearer
    # termineter
    # ssh-mitm
    # gss
    # websecprobe
    # zenmap
    # sssd
    # chipsec
    # dockle
    # notus-scanner
    # lynis
    # dnsdiag
    # cloud-custodian
    # misconfig-mapper
    # zotify
    # your_spotify
    # xnotify

    # # Library Management
    # ffmpeg-full
    # music-assistant #  library manager for various music sources
    # kid3-qt
    # kid3
    # beets
    # famistudio
    # cmt
    # pragha
    # haskellPackages.HarmTrace
    # glyr # serach engine
    # eartag # easy tagger
    # termusic
    # pantheon.elementary-music # for elementary os
    # zotify # fast music and podcast dl
    # transcribe
    # sonata # elegant
    # sc68
    # resonance
    # raysession
    # nulloy
    # mellowplayer
    # linuxwave
    # jellyfin-tui
    # inori
    # headset # for yt and reddit
    # jellyfin
    # jellyfin-web
    # jellyfin-tui
    # jellyfin-media-player
    # jftui
    # finamp
    # jellyflix
    # delfin
    # sonixd
    # feishin
    # deadbeef
    # buzztrax
    # amberol
    # amarok
    # go-musicfox
    # ymuse
    # waylyrics
    # tauon
    # tagutil
    # tagger
    # sonic-visualiser
    # projectm_3
    # muso
    # museeks
    # muffon
    # milkytracker
    # monophony
    # luppp
    # fum
    # wealthfolio
    # streamrip
    # schismtracker
    # plexamp
    # plattenalbum
    # onthespot
    # ncmpc
    # ncspot
    # rmpc
    # deepin.deepin-music
    # jellycli # cli jelly
    # quodlibet-full
    # sublime-music

    # vimpc
    # supersonic # tweight cross playtform subsonic client
    # sonixd # jelly compatible
    # musikcube
    # feishin # subsonic and jelly
    # cmus
    # gapless
    # musly
    # cider-2
    # polaris
    # picard


    # rmpc # tuic mpd client
    # scotty #transfers history betweenh services
    # bloomeetunes # cross playtform many sources

    # punes-qt6


    # Official Streaming Clients
    # spotify
    # ytmdesktop # electron wrapper
    # youtube-music # electron wrapper
    # ytmdesktop
    # # tidal-hifi
    # foxdot # live cofing musig

    # Inofficial Native Clients
    # spotifyd # as unix daemon
    # spotify-qt #lightweight qt client
    # spotify-player tui player
    # spoitfy-cli-linux # full terminal
    # spot #native client
    # psst #native rust gui (no electron)
    # ncspot # ncurses gooo
    # youtube-music
    # spotify-player
    # streamrip
    # muzika
    # monophony


    # Tools
    # qbittorrent
    # python313Packages.deemix # still the best
    # yt-dlp
    # ytdl-sub
    # openshot-qt
    # termusic
    # ytui-music
    # ytui-music
    # ytmdl
    # streamrip # rip tidal, soundcloud, deezer
    # # tidal-d
    # spotdl # dl playlists, and metadata
    # # onthespot # qt spoitfy downloader
    # dl-librescore # get sheet music
    # scdl # dl soundclient
    # fertilizer # cross seeding


    # Scrobbling
    # mpris-scrobbler
    # lastfm # services manager
    # cmusfm
    # rescrobbled
    # mpdas # mpd scrobbler
    # mpd-mpris
    # mpdscribble
    # mpd-notification
    # yams
    # cantata # gui for mpd
    # listenbrainz-mpd
    # mus
    # mpc
    # inori
    # clerk
    # ashuffle
    # rofi-mpd
    # ymuse
    # pms
    # vimpc
    # ympd
    # mympd
    # mmtc
    # rmpc
    # miniplayer
    # sublime-music

    # other
    # audit # audit libarary
    # mediaelch
    # media-downloader
    # kodi
    # mtx

    # kaffeine
    # olaris-server
    # jellyfin
    # dim
    # retrofe
    # syncplay
    # pinchflat
    # cosmic-player
    # jellyfin-media-player
    # vlc
    # mnamer
    # flexget
    # reddsaver
    # owntone
    # gossip
    # haskellPackages.real-dice
    # bashmount
    # you-get
    # sherlock
    # metadata
    # stremio
    # phockup

    # # Addons
    # spicetify-cli # mods spotify
    # your_spotify # track usage
    # zmusic
    # mikmod

    # # Lyrics
    # swaglyrics
    # sptlrx # spotify lyrics in term
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
  #     pkgs.mopidy-local # play local files
  #     pkgs.mopidy-spotify
  #     pkgs.mopidy-ytmusic
  #     pkgs.mopidy-mopify webclient based on spotify interface
  #     pkgs.mopidy-iris # web client for spoitfy and others
  #     pkgs.mopidy-subidy # play from subsconic server
  #     pkgs.mopidy-youtube # play from subsconic server
  #     pkgs.mopidy-tunein # play from subsconic server
  #     pkgs.mopidy-tidal # play from subsconic server
  #     pkgs.mopidy-soundclound # play from subsconic server
  #     pkgs.mopidy-soundclound # play from subsconic server
  #     mopidy-musicbox-webclient # musicbox frontend
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

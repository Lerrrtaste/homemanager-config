{ config, pkgs, lib, hm-firefox, ... }:

{
  # For touchscreen support
  # environment.sessionVariables = {
  #   MOZ_USE_XINPUT2 = "1";
  # };
  #
  home.file = {
    tridactyl = {
      source = ../tridactylrc;
      target = ".tridactylrc";
    };
  };
  programs.firefox = {
    enable = true;

    package = pkgs.firefox.override {
      cfg = {
        enableTridactylNative = true;
        # TODO import tridactyl cfg file
      };
      extraPolicies = {
        # AppAutoUpdate = false;
        # DisableAppUpdate = true;
        # DisableSystemAddonUpdate = true;
        # NewTabPage = false;
        # DisplayMenuBar = false;
        # NetworkPrediction = false;
        # CaptivePortal = false;
        # DNSOver
        # HTTPS = {
        #   Enabled = false;
        # };
        # DisableFirefoxStudies = true;
        # DisableTelemetry = true;
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        # DisableFormHistory = true;
        # DisablePasswordReveal = true;
        # NoDefaultBookmarks = true;
        DontCheckDefaultBrowser = true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
        # SearchSuggestEnabled = false;
        # UserMessaging = {
        #   ExtensionRecommendations = false;
        #   SkipOnboarding = true;
        # };
        # TODO remove adds from newtab page
        # TODO dont keep tabs after closing
        # TODO enable https only mode
        # ExtensionSettings = {};
      };
    };

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      # essential
      #     keepassxc-browser
      languagetool
      tridactyl
      bitwarden

      # qol
      consent-o-matic
      auto-tab-discard
      augmented-steam
      reddit-enhancement-suite
      refined-github

      # dev
      react-devtools
      reduxdevtools

      # youtube
      df-youtube
      sponsorblock
      return-youtube-dislikes

      # privacy
      # multi-account-containers
      umatrix
      temporary-containers
      link-cleaner
      terms-of-service-didnt-read
      localcdn
      ublock-origin
      canvasblocker
    ];

    profiles = {
      #     # TODO import bookmarks!
      default = {
        id = 0;
        name = "nixmain";
        isDefault = true;

        # "linux" = {
        #   toolbar = true;
        #   bookmarks = {
        #     nixos = {
        #       name = "nixos";
        #       url = "https://nixos.org/";
        #     };
        #     nixpkgs = {
        #       keyword = "Nixpkgs";
        #       url = "https://search.nixos.org/packages";
        #     };
        #     home-manager = {
        #       # Home Manager Manual
        #       keyword = "hmm";
        #       url = "https://nix-community.github.io/home-manager/";
        #     };
        #     home-manager-opt = {
        #       # Home Manager Configuration Options
        #       keyword = "hmo";
        #       url = "https://nix-community.github.io/home-manager/options.html";
        #     };
        #     nur = {
        #       # Nix User Repositories
        #       keyword = "nur";
        #       url = "https://nur.nix-community.org/";
        #     };
        #   };
        # };

        # hda
        # {
        #   name = "hda";
        #   toolbar = true;
        #   bookmarks = [
        #     { name = "obs"; url = "https://obs.h-da.de/"; }
        #     { name = "moodle"; url = "https://lernen.h-da.de/"; }
        #     { name = "mail"; url = "https://webmail.h-da.de/"; }
        #   ];
        # };

        settings = {
          "browser.toolbars.bookmarks.visibility" = "always";
          "browser.toolbars.bookmarks.showOtherBookmarks" = false;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.places.importBookmarksHTML" = "true";
          #
          #
          #         "app.normandy.api_url" = "";
          #         "app.normandy.enabled" = false;
          #         "app.shield.optoutstudies.enabled" = false;
          #         "app.update.auto" = false;
          #         "beacon.enabled" = false;
          #         "breakpad.reportURL" = "";
          #         "browser.aboutConfig.showWarning" = false;
          #         "browser.cache.offline.enable" = false;
          #         "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
          #         "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          #         "browser.crashReports.unsubmittedCheck.enabled" = false;
          #         "browser.disableResetPrompt" = true;
          #         "browser.fixup.alternate.enabled" = false;
          #         "browser.newtab.preload" = false;
          #         "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          #         "browser.newtabpage.enabled" = false;
          #         "browser.newtabpage.enhanced" = false;
          #         "browser.newtabpage.introShown" = false;
          #         "browser.safebrowsing.appRepURL" = "";
          #         "browser.safebrowsing.blockedURIs.enabled" = false;
          #         "browser.safebrowsing.downloads.enabled" = false;
          #         "browser.safebrowsing.downloads.remote.enabled" = false;
          #         "browser.safebrowsing.downloads.remote.url" = "";
          #         "browser.safebrowsing.enabled" = false;
          #         "browser.safebrowsing.malware.enabled" = false;
          #         "browser.safebrowsing.phishing.enabled" = false;
          #         "browser.search.suggest.enabled" = false;
          #         "browser.selfsupport.url" = "";
          #         "browser.send_pings" = false;
          #         "browser.sessionstore.privacy_level" = 2;
          #         "browser.shell.checkDefaultBrowser" = false;
          #         "browser.startup.homepage_override.mstone" = "ignore";
          #         "browser.tabs.crashReporting.sendReport" = false;
          #         "browser.urlbar.groupLabels.enabled" = false;
          #         "browser.urlbar.quicksuggest.enabled" = false;
          #         "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.trimURLs" = false;
          #         "datareporting.healthreport.service.enabled" = false;
          #         "datareporting.healthreport.uploadEnabled" = false;
          #         "datareporting.policy.dataSubmissionEnabled" = false;
          #         "device.sensors.ambientLight.enabled" = false;
          #         "device.sensors.enabled" = false;
          #         "device.sensors.motion.enabled" = false;
          #         "device.sensors.orientation.enabled" = false;
          #         "device.sensors.proximity.enabled" = false;
          #         "dom.battery.enabled" = false;
          #         "dom.event.clipboardevents.enabled" = false;
          #         "dom.security.https_only_mode" = true;
          #         "dom.security.https_only_mode_ever_enabled" = true;
          #         "experiments.activeExperiment" = false;
          #         "experiments.enabled" = false;
          #         "experiments.manifest.uri" = "";
          #         "experiments.supported" = false;
          #         "extensions.getAddons.cache.enabled" = false;
          #         "extensions.getAddons.showPane" = false;
          #         "extensions.greasemonkey.stats.optedin" = false;
          #         "extensions.greasemonkey.stats.url" = "";
          "extensions.pocket.enabled" = false;
          #         "extensions.shield-recipe-client.api_url" = "";
          #         "extensions.shield-recipe-client.enabled" = false;
          #         "extensions.webservice.discoverURL" = "";
          #         "keyword.enabled" = false;
          #         "media.autoplay.default" = 1;
          #         "media.autoplay.enabled" = false;
          #         "media.eme.enabled" = false;
          #         "media.gmp-widevinecdm.enabled" = false;
          #         "media.navigator.enabled" = false;
          #         "media.peerconnection.enabled" = false;
          #         "media.video_stats.enabled" = false;
          #         "network.IDN_show_punycode" = true;
          #         "network.allow-experiments" = false;
          #         "network.captive-portal-service.enabled" = false;
          #         "network.cookie.cookieBehavior" = 1;
          #         "network.dns.disablePrefetch" = true;
          #         "network.dns.disablePrefetchFromHTTPS" = true;
          #         "network.http.referer.spoofSource" = true;
          #         "network.http.speculative-parallel-limit" = 0;
          #         "network.predictor.enable-prefetch" = false;
          #         "network.predictor.enabled" = false;
          #         "network.prefetch-next" = false;
          #         "network.trr.mode" = 5;
          #         "pdfjs.enableScripting" = false;
          #         "privacy.donottrackheader.enabled" = true;
          #         "privacy.donottrackheader.value" = 1;
          #         # "privacy.firstparty.isolate" = true;
          #         "privacy.query_stripping" = true;
          #         "privacy.resistFingerprinting" = true; # maybe breaks things / hard captchas (feature from tor)
          #         "privacy.trackingprotection.cryptomining.enabled" = true;
          #         "privacy.trackingprotection.enabled" = true;
          #         "privacy.trackingprotection.fingerprinting.enabled" = true;
          #         "privacy.trackingprotection.pbmode.enabled" = true;
          #         "privacy.usercontext.about_newtab_segregation.enabled" = true;
          #         "security.ssl.disable_session_identifiers" = true;
          #         "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
          #         "signon.autofillForms" = false;
          #         "toolkit.telemetry.archive.enabled" = false;
          #         "toolkit.telemetry.bhrPing.enabled" = false;
          #         "toolkit.telemetry.cachedClientID" = "";
          #         "toolkit.telemetry.enabled" = false;
          #         "toolkit.telemetry.firstShutdownPing.enabled" = false;
          #         "toolkit.telemetry.hybridContent.enabled" = false;
          #         "toolkit.telemetry.newProfilePing.enabled" = false;
          #         "toolkit.telemetry.prompted" = 2;
          #         "toolkit.telemetry.rejected" = true;
          #         "toolkit.telemetry.reportingpolicy.firstRun" = false;
          #         "toolkit.telemetry.server" = "";
          #         "toolkit.telemetry.shutdownPingSender.enabled" = false;
          #         "toolkit.telemetry.unified" = false;
          #         "toolkit.telemetry.unifiedIsOptIn" = false;
          #         "toolkit.telemetry.updatePing.enabled" = false;
          #         # "webgl.disabled" = true;
          #         "webgl.renderer-string-override" = " ";
          #         "webgl.vendor-string-override" = " ";
        };
      };
    };
  };
}

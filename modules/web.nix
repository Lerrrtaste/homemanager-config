{ config, lib, pkgs, ... }:
let
  basicBrowser = pkgs.surf;
  defaultBrowser = pkgs.librewolf;
  comprehensiveBrowser = pkgs.vivaldi;
  experimentalBrowser = pkgs.opera-latest;
in {

  # mime
  xdg.mimeApps.defaultApplications = {
    "text/html" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
  };


  #
  programs.librewolf = {
    enable = true;
    # Enable WebGL, cookies and history
    settings = {
      "webgl.disabled" = true;
      "privacy.resistFingerprinting" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
  };

  home.packages = with pkgs; [
    surf # pure webkit, suckless
    librewolf # secure, private, opensource, ff fork, simple, sync broken
    brave # secure, tracking resistant, tab organization, sync, chromium

    # testing
    # vivaldi # ki stuff, cool tabs
    # opera # workspaces, tab-island, integrated im apps, security audits, bmark manager, dashboards, music, social media, shopping, crypto
  ];
}














    # opera-neo # closed source, beta, app-style tabs, testing only
    # opera-gx # customizable

#     programs.firefox = {
#   enable = true;
#   package = pkgs.librewolf;
#   policies = {
#     DisableTelemetry = true;
#     DisableFirefoxStudies = true;
#     Preferences = {
#       "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
#       "cookiebanners.service.mode" = 2; # Block cookie banners
#       "privacy.donottrackheader.enabled" = true;
#       "privacy.fingerprintingProtection" = true;
#       "privacy.resistFingerprinting" = true;
#       "privacy.trackingprotection.emailtracking.enabled" = true;
#       "privacy.trackingprotection.enabled" = true;
#       "privacy.trackingprotection.fingerprinting.enabled" = true;
#       "privacy.trackingprotection.socialtracking.enabled" = true;
#     };
#     ExtensionSettings = {
#       "jid1-ZAdIEUB7XOzOJw@jetpack" = {
  #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
  #         installation_mode = "force_installed";
  #       };
  #       "uBlock0@raymondhill.net" = {
  #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
  #         installation_mode = "force_installed";
  #       };
  #     };
  #   };
  # };

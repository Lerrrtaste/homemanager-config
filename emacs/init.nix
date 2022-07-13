{ config, pkgs, lib, ... }:

{
  services.emacs.enable = true;

  programs.emacs = {
    enable = true;
  };

  home.packages = with pkgs; [
    # required deps (doom)
    git
    ripgrep

    # optionsl deps (doom)
    fd
    clang
    pinentry_emacs
    zstd
    sqlite

    # copilot
    nodejs
  ];

  home.file.".doom.d" = {
    source = ./doom.d;
    recursive = true;
    onChange = builtins.readFile ./reload_doom.sh;
  };
}


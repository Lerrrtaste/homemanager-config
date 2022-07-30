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

  # FIXME it always detects changes when there are non
  # maybe link the files so i can reload by hand too someow
  home.file.".doom.d" = {
    source = ./doom.d;
    recursive = true;
    onChange = builtins.readFile ./reload_doom.sh;
  };
}


{ config, pkgs, lib, ... }:

#   # FIXME it always detects changes when there are non
#   # maybe link the files so i can reload by hand too someow
#   home.file.".doom.d" = {
#     source = ./doom.d;
#     recursive = true;
#     # onChange = builtins.readFile ./reload_doom.sh;
#   };
# }

let
  # NOTE deprecated / abandoned as it seems (2024-11)
  # doom-emacs = pkgs.callPackage (builtins.fetchTarball {
  #   url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
  # }) {
  #   doomPrivateDir = /home/lerrrtaste/.doom.d;  # Directory containing your config.el, init.el
  #                               # and packages.el files
  # };
in {

  # !!!!
  # NOTE requires nixpkgs overlay pinned in home.nix
  # !!!!

  home.packages = [
    # doom-emacs #FIXME maybe...
    pkgs.emacs-git  # Installs Emacs 28 + native-comp

    # required deps (doom)
    pkgs.git
    pkgs.ripgrep

    #optionsl deps (doom)
    pkgs.fd
    pkgs.clang
    pkgs.pinentry-emacs
    pkgs.zstd
    pkgs.sqlite

    # copilot
    pkgs.nodejs-18_x # 16 initially

    # sh
    pkgs.shellcheck

    #web
    pkgs.html-tidy

    #nix
    pkgs.nixfmt-classic

    #cc
    pkgs.libclang
    # pkgs.clang-tool # needed in shell for flycheck
    # pkgs.gcc11
    # pkgs.gcc11Stdenv

    # roam graphs
    pkgs.graphviz
  ];

  # services.emacs = {
  #   enable = false; # broken
  #   package = pkgs.emacsGcc;
  # };
  # programs.emacs = {
  #   enable = true;
  #   package = pkgs.emacs-git;
  # };

   # FIXME it always detects changes when there are non
   # maybe link the files so i can reload by hand too someow
   home.file.doom = {
     enable = true;
     executable = false;
     recursive = true;

     source = ./doom.d;
     target = "/home/lerrrtaste/.doom.d";

     # onChange = builtins.readFile ./reload_doom.sh;
   };

   home.activation.doom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          doom sync
  '';
}

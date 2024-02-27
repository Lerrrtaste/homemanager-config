{ config, pkgs, lib, ... }:

# {
#   # nixpkgs.overlays = [ (self: super: { nodejs = self.nodejs-17_x; }) ];
#   services.emacs.enable = true;

#   programs.emacs = {
#     enable = true;
#   };

#   home.packages = with pkgs; [
#     # required deps (doom)
#     git
#     ripgrep

#     # optionsl deps (doom)
#     fd
#     clang
#     pinentry_emacs
#     zstd
#     sqlite

#     # copilot
#     nodejs-16_x

#     # sh
#     shellcheck

#     # web
#     html-tidy

#     # nix
#     nixfmt

#   # cc
#   libclang


#   ];

#   # FIXME it always detects changes when there are non
#   # maybe link the files so i can reload by hand too someow
#   home.file.".doom.d" = {
#     source = ./doom.d;
#     recursive = true;
#     # onChange = builtins.readFile ./reload_doom.sh;
#   };
# }

let
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
  }) {
    doomPrivateDir = ./doom.d;  # Directory containing your config.el, init.el
                                # and packages.el files
  };
in {
  home.packages = [
    # doom-emacs #FIXME maybe...

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
    pkgs.nixfmt

    #cc
    pkgs.libclang
    # pkgs.clang-tool # needed in shell for flycheck
    # pkgs.gcc11
    # pkgs.gcc11Stdenv

    # roam graphs
    pkgs.graphviz
  ];

  services.emacs = {
    enable = true;
  };
  programs.emacs.enable = true;

   # FIXME it always detects changes when there are non
   # maybe link the files so i can reload by hand too someow
   home.file.".doom.d" = {
     source = ./doom.d;
     recursive = true;
     # onChange = builtins.readFile ./reload_doom.sh;
   };
}

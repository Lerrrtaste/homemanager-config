{ config, pkgs, lib, ... }:

{
    programs.vim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      vim-which-key
    ];

    settings = {
      ignorecase = true;
    };

    extraConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./base.vim)
      (lib.strings.fileContents ./plugins.vim)
      ];
  };
}

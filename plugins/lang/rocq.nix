{ pkgs, ... }:
{
  plugins.coq-nvim = {
    enable = true;
  };
  extraPlugins = [
    pkgs.vimPlugins.Coqtail
  ];
}

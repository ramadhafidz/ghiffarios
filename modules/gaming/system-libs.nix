{ pkgs, ... }:

{
  # Steam and Wine for gaming
  environment.systemPackages = with pkgs; [
    steam
    wine
    winetricks
    protonup-qt
  ];
}
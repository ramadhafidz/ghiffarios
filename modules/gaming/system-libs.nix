{ pkgs, ... }:

{
  # Steam and Wine for gaming
  environment.systemPackages = with pkgs; [
    steam
    wine
    winetricks
    protonup-qt
  ];

  # Steam configuration with DWProton compatibility tools
  programs.steam = {
    enable = true;
    extraCompatPackages = [
      pkgs.dwproton-bin
    ];
  };
}
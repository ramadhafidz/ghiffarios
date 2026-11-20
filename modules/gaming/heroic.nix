{ pkgs, ... }:

{
  home.packages = with pkgs; [
    heroic   # GOG, Epic Games, and Amazon Games launcher
  ];
}

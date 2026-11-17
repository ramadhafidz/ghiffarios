{ pkgs, ... }:

{
  # 32-bit libraries required by Steam and many games
  environment.systemPackages = with pkgs; [
    lib32zlib
    lib32ncurses5
    lib32libpulse
    lib32libxkbcommon
    lib32mesa
    lib32libdrm
    lib32vulkan
  ];
}
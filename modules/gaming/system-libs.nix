{ pkgs, ... }:

{
  # 32-bit libraries required by Steam and many games
  environment.systemPackages = with pkgs; [
    pkgsi686-linux.zlib
    pkgsi686-linux.ncurses5
    pkgsi686-linux.libpulse
    pkgsi686-linux.libxkbcommon
    pkgsi686-linux.mesa
    pkgsi686-linux.libdrm
    pkgsi686-linux.vulkan
  ];
}
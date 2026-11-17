{ pkgs, ... }:

{
  home.packages = with pkgs; [
    steam

    # X11 libraries needed by Steam
    libXcursor
    libXrandr
    libXi
    libXrender
    libXinerama
    libXcomposite
    libXdamage
    libXfixes
    libXft
    libXext

    # Additional graphics libraries
    libdrm
    libglvnd
    vulkan-tools
    vulkan-loader
  ];
}
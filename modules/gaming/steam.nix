{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Wine and helper tools for running Windows games
    wine
    winetricks
    protonup-qt
    vulkan-tools
  ];

  # Symlink DWProton directly to Steam's compatibility tools directory
  home.file.".local/share/Steam/compatibilitytools.d/DWProton".source =
    inputs.dwproton.packages.${pkgs.stdenv.hostPlatform.system}.dw-proton.steamcompattool;
}

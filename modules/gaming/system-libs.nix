{ pkgs, inputs, ... }:

{
  # Steam configuration with DWProton compatibility tools
  programs.steam = {
    enable = true;
    extraCompatPackages = [
      inputs.dwproton.packages.${pkgs.stdenv.hostPlatform.system}.dw-proton
    ];
  };
}

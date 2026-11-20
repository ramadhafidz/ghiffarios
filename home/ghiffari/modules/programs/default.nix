{ pkgs, ... }:

{
    imports = [
        ./mpv.nix
        ./arrpc.nix
        ./artcraft.nix
    ];

    home.packages = with pkgs; [
        brave
        discord
        vscodium
        gpu-screen-recorder-gtk
    ];
}

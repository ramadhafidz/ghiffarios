{ ... }:

{
    imports = [
        ./hardware-configuration.nix

        ../../modules/nixos/core
        ../../modules/nixos/desktop
        ../../modules/nixos/security
        ../../modules/nixos/users/ghiffari.nix
        ../../modules/nixos/users/shell.nix
        ../../modules/gaming/system-libs
        ./hardware/nvidia.nix
        ./hardware/intel-fallback.nix
        ./hardware/udev.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "ghiffari-workstation";

    system.stateVersion = "26.05";
}

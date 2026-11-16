{ ... }:

{
    imports = [
        ./hardware-configuration.nix

        ../../modules/core
        ../../modules/desktop
        ../../modules/security
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "ghiffari-workstation";

    system.stateVersion = "26.05";
}

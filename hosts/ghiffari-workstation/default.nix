{ lib, ... }:

{
    imports = [
        ./hardware-configuration.nix

        ../../modules/core
        ../../modules/desktop
        ../../modules/security
        ../../modules/hardware/nvidia.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "ghiffari-workstation";

    specialisation = {
        intel-fallback.configuration = {
            system.nixos.tags = [ "intel-fallback" ];

            services.xserver.videoDrivers = lib.mkForce [
                "modesetting"
            ];

            environment.sessionVariables.KWIN_DRM_DEVICES =
                lib.mkForce "/dev/dri/gpu-intel";

            boot.blacklistedKernelModules = [
                "nouveau"
                "nvidia"
                "nvidia_drm"
                "nvidia_modeset"
                "nvidia_uvm"
                "nvidiafb"
            ];
        };
    };

    services.udev.extraRules = ''
        SUBSYSTEM=="drm", KERNEL=="card[0-9]", SUBSYSTEMS=="pci", KERNELS=="0000:01:00.0", SYMLINK+="dri/gpu-nvidia"
        SUBSYSTEM=="drm", KERNEL=="card[0-9]", SUBSYSTEMS=="pci", KERNELS=="0000:00:02.0", SYMLINK+="dri/gpu-intel"
    '';

    system.stateVersion = "26.05";
}

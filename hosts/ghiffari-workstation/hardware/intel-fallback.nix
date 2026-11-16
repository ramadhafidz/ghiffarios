{ lib, ... }:

{
    specialisation.intel-fallback.configuration = {
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
}

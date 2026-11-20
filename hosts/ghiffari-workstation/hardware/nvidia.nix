{ ... }:

{
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        branch = "legacy_580";
        nvidiaSettings = true;
    };

    environment.sessionVariables.KWIN_DRM_DEVICES =
        "/dev/dri/gpu-nvidia";
}

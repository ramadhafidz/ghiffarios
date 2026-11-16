{ ... }:

{
    services.udev.extraRules = ''
        SUBSYSTEM=="drm", KERNEL=="card[0-9]", SUBSYSTEMS=="pci", KERNELS=="0000:01:00.0", SYMLINK+="dri/gpu-nvidia"
        SUBSYSTEM=="drm", KERNEL=="card[0-9]", SUBSYSTEMS=="pci", KERNELS=="0000:00:02.0", SYMLINK+="dri/gpu-intel"
    '';
}

{ pkgs, ... }:

let
  betterBlurDx = pkgs.kdePackages.callPackage ./packages/kwin-effects-better-blur-dx.nix { };
in
{
    services.xserver.enable = true;

    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
        quickshell
        klassy
        betterBlurDx
        kde-rounded-corners
    ];

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
        elisa
        khelpcenter
        krdp
        plasma-browser-integration
        plasma-keyboard
        qtvirtualkeyboard
        kwin-x11
        baloo-widgets
    ];

    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };
}

{ ... }:

{
    time.timeZone = "Asia/Jakarta";
    i18n.defaultLocale = "en_US.UTF-8";

    networking.networkmanager.enable = true;

    users.users.ghiffari = {
        isNormalUser = true;
        description = "Hafidz Ramadhan Ghiffari";
        extraGroups = [
            "networkmanager"
            "wheel"
        ];
    };

    programs.git.enable = true;
    programs.firefox.enable = true;

    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    nixpkgs.config.allowUnfree = true;
}

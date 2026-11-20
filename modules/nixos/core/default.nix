{ ... }:

{
    time.timeZone = "Asia/Jakarta";
    i18n.defaultLocale = "en_US.UTF-8";

    programs.git.enable = true;
    programs.firefox.enable = true;

    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    # Otomatisasi pembersihan storage & deduplikasi file di /nix/store
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    nix.optimise.automatic = true;

    # Pemeliharaan SSD & Filesystem
    services.fstrim = {
        enable = true;
        interval = "weekly";
    };

    services.btrfs.autoScrub = {
        enable = true;
        interval = "monthly";
        fileSystems = [ "/" ];
    };

    nixpkgs.config.allowUnfree = true;
}

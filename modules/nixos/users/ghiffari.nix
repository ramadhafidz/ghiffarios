{ pkgs, ... }:

{
    users.users.ghiffari = {
        isNormalUser = true;
        description = "Hafidz Ramadhan Ghiffari";
        extraGroups = [
            "networkmanager"
            "wheel"
        ];
        shell = pkgs.zsh;
    };
}

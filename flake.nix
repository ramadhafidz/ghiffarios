{
    description = "GhiffariOS - Personal NixOS Configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        dwproton = {
            url = "github:imaviso/dwproton-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        oh-my-pi.url = "github:can1357/oh-my-pi";
    };

    outputs = inputs@{ self, nixpkgs, home-manager, oh-my-pi, ... }:

        let
            mkHost = {
                host,
                home,
                username ? "ghiffari",
                system ? "x86_64-linux",
            }:

                nixpkgs.lib.nixosSystem {
                    inherit system;

                    modules = [
                        host

                        home-manager.nixosModules.home-manager

                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.backupFileExtension = "backup";

                            home-manager.extraSpecialArgs = {
                                inherit inputs;
                            };

                            home-manager.users.${username} = import home;
                        }
                    ];
                };
        in
        {
            nixosConfigurations = {
                ghiffari-workstation = mkHost {
                    host = ./hosts/ghiffari-workstation;
                    home = ./home/ghiffari;
                };
            };
        };
}
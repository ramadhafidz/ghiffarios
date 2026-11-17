{ inputs, pkgs, ... }:

{
    home.packages = [
        inputs.oh-my-pi.packages.${pkgs.stdenv.hostPlatform.system}.omp
    ];
}

{ pkgs, ... }:

let
  version = "19.0.1";

  rawBin = pkgs.fetchurl {
    url = "https://github.com/can1357/oh-my-pi/releases/download/v${version}/omp-linux-x64";
    hash = "sha256-gKaSxa25xxEkuxHne9fts8+Pu6tpgNsyBty2pMspBbU=";
  };

  ompBin = pkgs.runCommand "omp-bin" { } ''
    install -m755 -D ${rawBin} $out/bin/omp
  '';

  # Oh-my-pi is bundled as a Bun single-file executable. Running patchelf corrupts
  # Bun's internal trailer/payload offsets (causing it to fall back to the raw Bun CLI).
  # buildFHSEnv preserves the binary byte-for-byte in an FHS glibc environment.
  omp = pkgs.buildFHSEnv {
    name = "omp";
    targetPkgs = pkgs: with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
    runScript = "${ompBin}/bin/omp";
  };
in
{
  home.packages = [
    omp
  ];
}

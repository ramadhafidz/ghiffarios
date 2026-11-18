{ pkgs, ... }:

let
  version = "18.22.2";
  omp = pkgs.stdenv.mkDerivation {
    pname = "omp";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/can1357/oh-my-pi/releases/download/v${version}/omp-linux-x64";
      hash = "sha256-gKaSxa25xxEkuxHne9fts8+Pu6tpgNsyBty2pMspBbU=";
    };

    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
    ];

    dontUnpack = true;

    installPhase = ''
      install -m755 -D $src $out/bin/omp
    '';
  };
in
{
  home.packages = [
    omp
  ];
}


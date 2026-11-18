{ pkgs, ... }:

let
  mkNerdFontZip = { name, zipName, hash }:
    pkgs.stdenvNoCC.mkDerivation {
      pname = "nerd-fonts-${name}";
      version = "3.5.1";
      src = pkgs.fetchzip {
        url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/${zipName}.zip";
        inherit hash;
        stripRoot = false;
      };
      installPhase = ''
        runHook preInstall
        install -m444 -D -t $out/share/fonts/truetype *.ttf 2>/dev/null || true
        install -m444 -D -t $out/share/fonts/opentype *.otf 2>/dev/null || true
        runHook postInstall
      '';
    };

  openDyslexicNerdFont = mkNerdFontZip {
    name = "opendyslexic";
    zipName = "OpenDyslexic";
    hash = "sha256-+rJINvHMfpsWgw/SvWwkIX8PkhqdkdK325+vy2ErtV0=";
  };
  hermitNerdFont = mkNerdFontZip {
    name = "hermit";
    zipName = "Hermit";
    hash = "sha256-jDzb9dX47ceuWKv14UTgfeX0C2fHBJ3r/2oXlz6Bfpo=";
  };
  agaveNerdFont = mkNerdFontZip {
    name = "agave";
    zipName = "Agave";
    hash = "sha256-PVQuwcE31yCjBS6vhl9KSBg2pNl3rbFj7XI8+CKvesk=";
  };
  firaCodeNerdFont = mkNerdFontZip {
    name = "fira-code";
    zipName = "FiraCode";
    hash = "sha256-TR53vd5/usNJtdLhzMJWKCiEWRJQATYYpa0bFY6Gsdk=";
  };
in
{
  imports = [
    ./konsole.nix
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    kdePackages.kate
    nerd-fonts.jetbrains-mono
    openDyslexicNerdFont
    hermitNerdFont
    agaveNerdFont
    firaCodeNerdFont
  ];
}

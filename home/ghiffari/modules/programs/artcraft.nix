{ pkgs, lib, ... }:

let
  mkCraftApp =
    {
      pname,
      version,
      sha256,
      repoName ? pname,
      binName ? pname,
      description,
    }:
    pkgs.stdenvNoCC.mkDerivation rec {
      inherit pname version;

      src = pkgs.fetchurl {
        url = "https://github.com/storytold/${repoName}/releases/download/v${version}/${pname}-${version}-linux-x86_64.tar.gz";
        inherit sha256;
      };

      nativeBuildInputs = [ pkgs.autoPatchelfHook ];

      buildInputs = with pkgs; [
        stdenv.cc.cc.lib
        libGL
        libxkbcommon
        wayland
        libx11
        libxcursor
        libxi
        libxrandr
      ];

      sourceRoot = ".";

      installPhase = ''
        runHook preInstall

        cd *-linux-x86_64
        mkdir -p $out
        cp -r bin share $out/

        runHook postInstall
      '';

      meta = {
        inherit description;
        homepage = "https://getartcraft.com";
        license = lib.licenses.asl20;
        platforms = [ "x86_64-linux" ];
        mainProgram = binName;
      };
    };

  artcraftLauncher = mkCraftApp {
    pname = "artcraft-launcher";
    repoName = "craft-launcher";
    version = "0.19.2";
    sha256 = "39a9aeb77f85ab06d65540b194f1582ec8c26529f7e10a8c9d6c07ff2180b66d";
    description = "Official ArtCraft Launcher & updater for the Craft app suite";
  };

  photocraft = mkCraftApp {
    pname = "photocraft";
    version = "0.23.1";
    sha256 = "4383aef67a07cc370ad250a6ed60015205d3e6c463faf3ff4b0f67b8178ccfc8";
    description = "Raster photo and image editor (Photoshop alternative)";
  };

  vectorcraft = mkCraftApp {
    pname = "vectorcraft";
    version = "0.24.1";
    sha256 = "a090514252fde145495ac6fc65d6ff1311d698998e57ba434d5d0896c3d1fbfa";
    description = "Vector graphics and illustration editor (Illustrator alternative)";
  };

  lightcraft = mkCraftApp {
    pname = "lightcraft";
    version = "0.21.1";
    sha256 = "b123de16915809a79e64ba4ee3aee9e1cded6ef23b737c06f81cdc7e2f286d62";
    description = "RAW photo development and color grading editor (Lightroom alternative)";
  };

  effectcraft = mkCraftApp {
    pname = "effectcraft";
    version = "0.24.1";
    sha256 = "5ce0393690144227fa9186e82308ad638a6ef6d9f976c996e6d03b5b51b65a7b";
    description = "Motion graphics and visual effects compositing (After Effects alternative)";
  };

  wordcraft = mkCraftApp {
    pname = "wordcraft";
    version = "0.18.1";
    sha256 = "312a057d46dd80597c12dccfd1097ce25edea40baaaeb50bcb6f01ac1aebadb5";
    description = "Document layout and rich text editor (Word alternative)";
  };

  gridcraft = mkCraftApp {
    pname = "gridcraft";
    version = "0.19.1";
    sha256 = "8d97bba2d5bb00fd69ed55064852c1fd914de40d5ecd55ca01c8df81b828946d";
    description = "Spreadsheet and data table calculation editor (Excel alternative)";
  };

  craftAnything = mkCraftApp {
    pname = "craft-anything";
    version = "0.6.1";
    sha256 = "83ec0730c9117f399122b315c63ed4c3a8d31ac55bddd74cb8b33cd2f76ef704";
    description = "AI Agentic software and game prototyping & reverse-engineering tool";
  };
in
{
  home.packages = [
    artcraftLauncher
    photocraft
    vectorcraft
    lightcraft
    effectcraft
    wordcraft
    gridcraft
    craftAnything
  ];
}

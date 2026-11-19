{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  extra-cmake-modules,
  wrapQtAppsHook,
  kwin,
  qttools,
}:

stdenv.mkDerivation rec {
  pname = "kwin-effects-better-blur-dx";
  version = "2.6.0";

  src = fetchFromGitHub {
    owner = "xarblu";
    repo = "kwin-effects-better-blur-dx";
    rev = "v${version}";
    hash = "sha256-CMRHJzMcdg3jxfi9yBo9xMmGnk2acqLewUHQp9xO+tg=";
  };

  patches = [
    ./kwin-effects-better-blur-dx-no-transform-blur.patch
  ];

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
    wrapQtAppsHook
  ];

  buildInputs = [
    kwin
    qttools
  ];

  meta = with lib; {
    description = "Fork of the KWin Blur effect for KDE Plasma 6 with force blur, refraction, and bug fixes";
    homepage = "https://github.com/xarblu/kwin-effects-better-blur-dx";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}

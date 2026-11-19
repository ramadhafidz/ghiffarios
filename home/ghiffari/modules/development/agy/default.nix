{ config, pkgs, lib, ... }:

let
  agyWrapper = pkgs.writeShellScriptBin "agy" ''
    AGY_BINARY="${config.home.homeDirectory}/.local/bin/agy"
    GLIBC="${pkgs.glibc}"

    if [ ! -x "$AGY_BINARY" ]; then
        echo "Error: AGY binary not found at $AGY_BINARY" >&2
        exit 127
    fi

    export PATH="${lib.makeBinPath [ pkgs.wl-clipboard ]}:$PATH"

    exec "$GLIBC/lib64/ld-linux-x86-64.so.2" \
        --library-path "$GLIBC/lib" \
        "$AGY_BINARY" "$@"
  '';
in
{
  home.packages = [
    agyWrapper
    pkgs.wl-clipboard
  ];
}

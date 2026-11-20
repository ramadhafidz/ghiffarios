{ pkgs, ... }:

let
  nixDevInit = pkgs.writeShellScriptBin "nix-dev-init" ''
    set -e

    LANG="''${1:-}"

    if [ -z "$LANG" ]; then
      echo "Usage: nix-dev-init <template>"
      echo "Available templates: node, rust, dotnet, cpp, python"
      exit 1
    fi

    if [ -f "flake.nix" ]; then
      echo "Error: flake.nix already exists in this directory!"
      exit 1
    fi

    case "$LANG" in
      node|nodejs|js|ts)
        cat << 'EOF' > flake.nix
{
  description = "Node.js Development Environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.''${system};
    in {
      devShells.''${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nodejs_22
          corepack
          nodePackages.pnpm
          nodePackages.typescript
        ];
      };
    };
}
EOF
        echo "Created flake.nix for Node.js (Node 22 + pnpm)"
        ;;

      rust|rs)
        cat << 'EOF' > flake.nix
{
  description = "Rust Development Environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.''${system};
    in {
      devShells.''${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          rustc
          cargo
          rustfmt
          clippy
          rust-analyzer
        ];
      };
    };
}
EOF
        echo "Created flake.nix for Rust (rustc, cargo, clippy, rust-analyzer)"
        ;;

      dotnet|csharp|cs)
        cat << 'EOF' > flake.nix
{
  description = "C# / .NET Development Environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.''${system};
    in {
      devShells.''${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          dotnet-sdk_8
          omnisharp-roslyn
        ];
        shellHook = '''
          export DOTNET_ROOT="''${pkgs.dotnet-sdk_8}"
        ''';
      };
    };
}
EOF
        echo "Created flake.nix for C# / .NET (.NET 8 SDK + Omnisharp)"
        ;;

      cpp|c)
        cat << 'EOF' > flake.nix
{
  description = "C / C++ Development Environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.''${system};
    in {
      devShells.''${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          gcc
          clang-tools
          cmake
          gnumake
          pkg-config
          gdb
        ];
      };
    };
}
EOF
        echo "Created flake.nix for C / C++ (gcc, clang-tools, cmake, gdb)"
        ;;

      python|py)
        cat << 'EOF' > flake.nix
{
  description = "Python Development Environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.''${system};
    in {
      devShells.''${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          python3
          python3Packages.pip
          python3Packages.virtualenv
          ruff
          pyright
        ];
      };
    };
}
EOF
        echo "Created flake.nix for Python (Python 3 + virtualenv, ruff, pyright)"
        ;;

      *)
        echo "Unknown template: $LANG"
        echo "Available templates: node, rust, dotnet, cpp, python"
        exit 1
        ;;
    esac

    if [ ! -f ".envrc" ]; then
      echo "use flake" > .envrc
      echo "Created .envrc"
    fi

    if command -v direnv >/dev/null 2>&1; then
      direnv allow
      echo "Ran 'direnv allow' - dev shell is active!"
    fi
  '';
in
{
  home.packages = with pkgs; [
    # Modern CLI Utilities
    lazygit
    eza
    ripgrep
    fd
    bat
    gh
    jq

    # Base light compilers for quick scripting / scratchpads
    python3
    gcc
    gnumake

    # Helper script to initialize per-project flake.nix + direnv
    nixDevInit
  ];
}

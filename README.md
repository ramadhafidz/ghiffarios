# GhiffariOS

Personal, declarative NixOS configuration managed with **Nix Flakes** and **Home Manager**.

GhiffariOS is designed to provide a reproducible, modular, and maintainable Linux environment across multiple devices.

## Overview

The project follows these principles:

- Declarative system configuration using NixOS.
- Reusable architecture for multiple hosts.
- Modular separation between system and user configurations.
- Home Manager integration for user environments.
- Hardware-specific configuration isolated per host.
- Reproducible builds and version-controlled configuration.

## Architecture

GhiffariOS uses a layered configuration architecture.

| Layer | Responsibility |
|---|---|
| Flake | Dependencies, inputs, and host registration |
| Host | Machine-specific system configuration |
| NixOS Modules | Reusable system-level configuration |
| Hardware | Host-specific GPU drivers, hardware rules, and specialisations |
| Home Manager | User environment and application configuration |

### Host Builder

The `mkHost` function in `flake.nix` provides a reusable way to define NixOS hosts.

It accepts:

- `host`: NixOS host configuration path.
- `home`: Home Manager user configuration path.
- `username`: Home Manager username (default: `ghiffari`).
- `system`: Nix system architecture (default: `x86_64-linux`).

Home Manager is integrated as a NixOS module and uses the same Nixpkgs package set.

## Repository Structure

```text
ghiffarios/
├── .editorconfig
├── flake.nix
├── flake.lock
├── README.md
│
├── hosts/
│   └── ghiffari-workstation/
│       ├── default.nix
│       ├── hardware-configuration.nix
│       └── hardware/
│           ├── nvidia.nix
│           ├── intel-fallback.nix
│           └── udev.nix
│
├── modules/
│   └── nixos/
│       ├── core/
│       │   └── default.nix
│       ├── desktop/
│       │   └── default.nix
│       ├── security/
│       │   └── default.nix
│       └── users/
│           └── ghiffari.nix
│
└── home/
    └── ghiffari/
        ├── default.nix
        └── modules/
            ├── desktop/
            │   └── default.nix
            └── programs/
                └── default.nix
```

## Current Host

### ghiffari-workstation

| Component | Configuration |
|---|---|
| OS | NixOS 26.05 |
| Architecture | x86_64-linux |
| CPU | Intel Core i5-7500 |
| RAM | 16 GB |
| Main GPU | NVIDIA Quadro P620 |
| Integrated GPU | Intel HD Graphics 630 |
| Desktop Environment | KDE Plasma 6 |
| Display Manager | SDDM |
| Bootloader | systemd-boot |
| Filesystem | Btrfs |
| Encryption | LUKS2 |
| System State Version | 26.05 |
| Home Manager State Version | 26.05 |

### Hardware Configuration

The workstation has host-specific hardware modules:

- `nvidia.nix`: Proprietary NVIDIA driver configuration.
- `intel-fallback.nix`: Optional Intel graphics specialisation.
- `udev.nix`: Stable GPU device symlinks based on PCI addresses.

The primary desktop configuration uses the NVIDIA Quadro P620.

## Adding a New Host

The architecture is designed to support additional NixOS machines.

### 1. Create the host directory

```text
hosts/
└── new-host/
    ├── default.nix
    └── hardware-configuration.nix
```

Generate the hardware configuration from the target machine rather than copying another host's hardware configuration.

### 2. Create a Home Manager configuration

Create a corresponding user configuration under:

```text
home/
└── new-user/
    └── default.nix
```

Set the correct username, home directory, and state version.

### 3. Register the host in flake.nix

Add a new entry to `nixosConfigurations`:

```nix
nixosConfigurations = {
    ghiffari-workstation = mkHost {
        host = ./hosts/ghiffari-workstation;
        home = ./home/ghiffari;
    };

    new-host = mkHost {
        host = ./hosts/new-host;
        home = ./home/new-user;
        username = "new-user";
        system = "x86_64-linux";
    };
};
```

### 4. Validate the new host

```bash
nix flake check --no-build

nixos-rebuild build --flake .#new-host
```

Do not activate a new host configuration until its hardware settings and build have been verified.

## Build & Validation

Run commands from the repository root.

### Evaluate the system

```bash
nix eval .#nixosConfigurations.ghiffari-workstation.config.system.build.toplevel.drvPath
```

### Check the Flake

```bash
nix flake check --no-build
```

### Build without activation

```bash
nixos-rebuild build --flake .#ghiffari-workstation
```

Building does not activate the configuration or replace the running system.

### Activate the configuration

Only after reviewing and validating the build:

```bash
sudo nixos-rebuild switch --flake .#ghiffari-workstation
```

Reboot if required by the changes.

## Safety & Maintenance

- Never commit passwords, API tokens, private keys, or other secrets.
- Keep hardware configurations specific to their respective hosts.
- Do not copy `hardware-configuration.nix` between machines without regenerating and verifying it.
- Preserve existing `system.stateVersion` and `home.stateVersion` unless intentionally migrating.
- Validate configuration changes before activation.
- Review Git changes before committing.
- Keep local backups and machine-specific files out of version control.

## Development Workflow

Recommended workflow:

1. Inspect the existing configuration.
2. Make a focused change.
3. Run formatting and whitespace checks.
4. Run `nix flake check --no-build`.
5. Build the affected host.
6. Review the resulting changes.
7. Commit the validated changes.
8. Activate only when explicitly intended.

## License

Personal configuration. Licensing will be decided before public release.

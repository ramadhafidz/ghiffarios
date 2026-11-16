# GhiffariOS

Personal, declarative NixOS configuration managed with Nix Flakes and Home Manager.

## Overview

GhiffariOS is a personal NixOS configuration focused on:

- Declarative and reproducible system configuration.
- Modular NixOS architecture.
- Home Manager integration.
- Development and gaming environments.
- System security and maintainability.

## System

| Component | Configuration |
|---|---|
| OS | NixOS 26.05 |
| Architecture | x86_64-linux |
| Desktop | KDE Plasma 6 |
| Display Manager | SDDM |
| Bootloader | systemd-boot |
| Filesystem | Btrfs |
| Encryption | LUKS2 |
| Configuration | Nix Flakes |
| User Environment | Home Manager |

## Hardware

| Component | Hardware |
|---|---|
| CPU | Intel Core i5-7500 |
| GPU | NVIDIA Quadro P620 |
| RAM | 16 GB |
| Main Storage | 256 GB SSD |

## Repository Structure

```text
ghiffarios/
├── flake.nix
├── flake.lock
├── home/
│   └── ghiffari.nix
├── hosts/
│   └── ghiffari-workstation/
│       ├── default.nix
│       └── hardware-configuration.nix
└── modules/
    ├── core/
    ├── desktop/
    └── security/
```

## Building

Evaluate the system:

```bash
nix eval .#nixosConfigurations.ghiffari-workstation.config.system.build.toplevel.drvPath
```

Build without activating:

```bash
nix build .#nixosConfigurations.ghiffari-workstation.config.system.build.toplevel --no-link
```

Apply the configuration:

```bash
sudo nixos-rebuild switch --flake .#ghiffari-workstation
```

## Safety
- Keep hardware-specific configuration private.
- Never commit passwords, tokens, private keys, or secrets.
- Preserve the existing `system.stateVersion`.
- Test configuration changes before activation.

## License

Personal configuration. Licensing will be decided before public release.

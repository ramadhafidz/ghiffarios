---
name: system-maintenance
description: Procedures for SSD fstrim, Btrfs scrub, Nix store garbage collection, storage deduplication, and health checks.
---

# System Maintenance

Procedures and conventions for disk maintenance, filesystem integrity, and Nix store hygiene on GhiffariOS.

## Automated Services

Configured declaratively in `modules/nixos/core/default.nix`:

1. **SSD TRIM (`services.fstrim`)**:
   - `services.fstrim.enable = true`
   - Runs weekly via `fstrim.timer` across all mounted filesystems supporting discard.

2. **Btrfs Scrub (`services.btrfs.autoScrub`)**:
   - `services.btrfs.autoScrub.enable = true`
   - `services.btrfs.autoScrub.interval = "monthly"`
   - `services.btrfs.autoScrub.fileSystems = [ "/" ]`
   - Verifies data and metadata checksums on Btrfs subvolumes (`@`, `@home`, `@nix`).

3. **Nix Garbage Collection (`nix.gc`)**:
   - `nix.gc.automatic = true`
   - `nix.gc.dates = "weekly"`
   - `nix.gc.options = "--delete-older-than 7d"`

4. **Nix Store Deduplication (`nix.optimise`)**:
   - `nix.optimise.automatic = true`
   - `nix.optimise.dates = [ "weekly" ]`
   - Hardlinks duplicate files in `/nix/store` to reclaim disk space.

## Manual Maintenance Commands

> [!CAUTION]
> Deleting generations or running garbage collection requires explicit user approval under `AGENTS.md`.

- **Check Btrfs Scrub Status**:
  ```bash
  sudo btrfs scrub status /
  ```
- **Check Btrfs Filesystem Usage**:
  ```bash
  sudo btrfs filesystem usage /
  ```
- **Manual Hardlink Deduplication (Non-destructive)**:
  ```bash
  nix-store --optimise
  ```
- **Manual Garbage Collection (Explicit approval required)**:
  ```bash
  nix-collect-garbage -d
  ```

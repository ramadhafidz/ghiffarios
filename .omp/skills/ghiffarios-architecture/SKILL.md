---
name: ghiffarios-architecture
description: Repository layering, module boundaries, and where configuration belongs. Use when creating modules, registering hosts, or restructuring the repo.
---

# GhiffariOS Architecture

Layers:
- `flake.nix` — inputs, outputs, host registration. No machine-specific hardware settings here.
- `hosts/` — machine-specific entry points composing system modules and hardware config. Known host: `ghiffari-workstation`.
- `modules/nixos/` — reusable system-level modules organized by responsibility (core, desktop, hardware, security, users, services).
- `home/` — Home Manager user configuration (`home/ghiffari/`).

Decision rule: shared behavior → `modules/nixos/`; genuinely host-specific → `hosts/<host>/`; user apps and preferences → `home/`.

Dependency direction: flake outputs compose hosts; hosts compose NixOS modules and hardware; Home Manager manages user-level config. Reusable modules must not depend on one specific host.

Before moving or creating modules:
1. Inspect existing imports.
2. Identify the setting's current ownership.
3. Check whether another module already provides it.
4. Preserve existing module interfaces.
5. Update references and documentation when restructuring.

Do not reorganize directories merely for aesthetic reasons.

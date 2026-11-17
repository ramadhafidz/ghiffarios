---
name: hardware-management
description: Rules for host hardware configuration, GPU, boot, and kernel settings. Use before touching hosts/*/hardware or hardware-configuration.
---

# Hardware Management

Host context (verify by inspecting actual config, not from memory):
- Dell OptiPlex 7050, i5-7500, 16 GB RAM, NVIDIA Quadro P620 + Intel HD 630.

Rules:
- Hardware config is machine-specific and lives under `hosts/ghiffari-workstation/`.
- Inspect boot, kernel, graphics, and driver settings before editing.
- Preserve GPU fallbacks (`intel-fallback.nix`) and specialisations.
- Never replace generated hardware configuration wholesale.
- Never overwrite, delete, rename, regenerate over, or stage `hardware-configuration.nix.local`; do not assume its contents are safe to publish.
- Before proposing a hardware change: inspect config, explain expected behavior, identify boot/display risks, provide a rollback approach, then obtain approval before activation.

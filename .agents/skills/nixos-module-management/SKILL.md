---
name: nixos-module-management
description: Conventions for writing NixOS modules, flakes, packages, and secrets. Use when editing modules/nixos or flake.nix.
---

# NixOS Module Management

- Declarative configuration; avoid imperative workarounds.
- Modules: one responsibility per module, descriptive filenames, follow existing option/import conventions.
- Flakes: keep inputs explicit; update `flake.lock` only when dependency changes require it, and explain the change.
- Packages: check it is not already installed, decide system vs user level, follow existing conventions, explain new dependencies/overlays, check the unfree policy.
- Secrets: never hardcode, never raw in the store, never print values during validation.
- Validation: non-activating checks matched to change scope — `nix flake check`, `nix eval`, `nix-instantiate --parse` for changed Nix files.

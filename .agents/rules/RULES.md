---
trigger: always_on
---

# GhiffariOS — Agent Rules

Hard rules derived from `AGENTS.md`.

## Approval required (always ask first)
- `nixos-rebuild switch`, `home-manager switch`
- Reboot / shutdown
- Nix garbage collection or store cleanup
- Disk format, repartition, or destructive file operations
- Bootloader, kernel, GPU driver, or critical security changes
- Credential or authentication changes
- Git commit, push, release, or deployment

## Always allowed
- Reading and inspecting files
- Editing project files with focused changes
- Non-activating validation: `nix eval`, `nix flake check`, syntax checks, dry builds (`nixos-rebuild build`, `dry-activate` only with approval)
- Formatting, linting, diff review

## Never
- `git add -A` or `git add .` — stage named files only
- Stage, overwrite, or delete `hosts/ghiffari-workstation/hardware-configuration.nix.local`
- Commit, push, or publish without explicit approval
- Hardcode secrets in Nix expressions or place raw secrets in the store
- Assume a config is active just because it exists in the repo
- Discard uncommitted user work or reset the repo without approval
- Run imperative system workarounds when declarative configuration exists

## NixOS Module Arguments
- `nixpkgs.lib.nixosSystem` accepts `specialArgs` (NOT `extraSpecialArgs`) to pass arguments to modules
- Home Manager accepts `extraSpecialArgs` inside module config
- Never confuse `specialArgs` vs `extraSpecialArgs` between NixOS and Home Manager
- Always validate with `nix flake check --no-build` before declaring done

## Before declaring done
1. Inspect the final diff
2. Run the narrowest non-destructive check that exercises the change
3. Report checks that could not be performed

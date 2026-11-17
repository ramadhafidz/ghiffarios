---
name: system-validation
description: Non-activating validation and activation boundaries for NixOS changes. Use when verifying configuration changes.
---

# System Validation

Allowed without approval:
- `nix flake check`, syntax evaluation, `nix eval`
- Dry builds and `nixos-rebuild build` / `test` evaluation of the configuration
- Diff review after changes

Requires explicit approval:
- `nixos-rebuild switch`, `home-manager switch`
- Nix garbage collection / store cleanup

Process before declaring done:
1. Inspect the final diff.
2. Run the narrowest non-destructive check that exercises the change.
3. Report checks that could not be performed.
4. A successful syntax check does not guarantee successful activation — say so.

Approval must be specific: approval to edit a file does not imply approval to activate; approval to validate does not imply approval to rebuild or switch. If an operation could be destructive or externally visible, stop and ask.

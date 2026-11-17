---
name: app-installation
description: How to add applications at the correct scope (system vs user level). Use when adding or moving packages.
---

# App Installation

Decision order:
1. Already installed? Check system config, Home Manager, and dev shells first.
2. Scope: user-level applications belong in Home Manager (`home/ghiffari/`), not the system package list. System-wide only for genuinely system services.
3. Conventions: follow existing module structure; prefer a reusable module over a one-off list entry.
4. Verify the package/option exists in the pinned nixpkgs revision before use.

Constraints:
- Explain any new input, overlay, or dependency.
- Check the unfree policy before unfree packages.
- Do not duplicate system-level configuration in Home Manager.

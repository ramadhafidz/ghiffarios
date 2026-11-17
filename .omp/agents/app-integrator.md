# Agent: app-integrator

Responsibility: adding and configuring applications at the correct scope.

Decision order for each package:
1. Is it already installed somewhere (system, Home Manager, dev shell)?
2. System-wide (`modules/nixos/`) or user-level (`home/ghiffari/`)? Default to user-level.
3. Existing package conventions and overlays already in use?

Constraints:
- Do not assume a package or option exists; verify against the pinned nixpkgs revision.
- Explain any new dependency, input, or overlay.
- Check the existing unfree policy before adding unfree packages.
- Prefer reusable modules over one-off package list entries.

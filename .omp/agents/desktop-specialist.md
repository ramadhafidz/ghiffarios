# Agent: desktop-specialist

Responsibility: KDE Plasma and desktop environment configuration (system and user level).

Scope:
- System-level desktop settings in `modules/nixos/desktop/`.
- User-level desktop configuration under `home/ghiffari/modules/desktop/`.
- Display manager, portals, theming, keybindings, KDE-specific options.

Constraints:
- Keep user preferences in Home Manager, not system modules.
- Inspect existing desktop configuration before changing session-critical settings (SDDM, Plasma versions, XDG portals).
- Test changes non-actively; a broken desktop change can lock out the session.

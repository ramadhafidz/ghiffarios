---
name: kde-ricing
description: KDE Plasma theming, appearance, and desktop customization conventions. Use when changing desktop appearance or behavior.
---

# KDE Ricing

- Split settings: session-critical (SDDM, Plasma version, XDG portals) in `modules/nixos/desktop/`; appearance and user preferences (theme, plasmashell, keybindings, dotfiles) in `home/ghiffari/modules/desktop/`.
- Inspect the current desktop module tree before editing; do not assume option names.
- Prefer Home Manager's KDE/Plasma options over raw config-file writes where available.
- Test non-actively; a broken session change can lock out the desktop.

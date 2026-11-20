---
name: gaming-setup
description: Conventions for GameMode, MangoHud HUD configurations, Proton/Wine, GPU Screen Recorder, and gaming performance tuning.
---

# Gaming Setup

Conventions for gaming performance, overlays, and tools on GhiffariOS.

## Architecture

- **System Module**: `modules/gaming/default.nix` (imports Steam, GameMode, MangoHud, GPU Screen Recorder).
- **Home Manager Configuration**: `home/ghiffari/modules/programs/mangohud.nix` and `home/ghiffari/modules/desktop/media.nix`.

## Core Guidelines

1. **GameMode (`programs.gamemode.enable = true`)**:
   - Manages CPU governor (performance), I/O priority, process niceness, and GPU performance modes.
   - Kernel split lock mitigation disabled (`boot.kernel.sysctl."kernel.split_lock_mitigate" = 0`) to prevent frame drops in Wine/Proton games.

2. **MangoHud (Compact 1-Line Overlay)**:
   - Always prefer the compact single-line horizontal HUD layout:
     - `legacy_layout = false`
     - `horizontal = true`
     - `font_size = 14`
     - Dedicated GPU monitoring: specify `pci_dev = "0000:01:00.0"` for discrete GPU (dGPU).
     - Toggle hotkey: `Shift_R+F12`.
   - Ensure `programs.mangohud.enableSessionWide = false` to avoid injecting MangoHud into desktop GUI apps.

3. **Graphics & Wine/Proton**:
   - Always ensure 32-bit graphics libraries are enabled: `hardware.graphics.enable32Bit = true`.
   - Proton and Heroic: Steam Remote Play ports `27036-27037/tcp` and `27031-27036/udp` configured when streaming.

4. **GPU Screen Recorder**:
   - Enabled via NixOS module: `programs.gpu-screen-recorder.enable = true`.
   - GTK frontend (`gpu-screen-recorder-gtk`) placed in user packages for desktop recording.

5. **Validation**:
   - Always check syntax and module evaluation: `nix flake check --no-build`.

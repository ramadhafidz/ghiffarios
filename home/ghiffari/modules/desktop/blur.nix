{ lib, pkgs, ... }:

{
  home.activation.configureKWinBlur = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    KWINRC="$HOME/.config/kwinrc"

    # Disable default KWin blur and enable Better Blur DX
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Plugins --key blurEnabled --type bool false
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Plugins --key better_blur_dxEnabled --type bool true

    # Configure Better Blur DX parameters
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key BlurStrength 14
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key NoiseStrength 3
    # Tint the glass dark enough that the rounded blur edge and the window body
    # read as the same surface instead of a bright halo around a dark rect.
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key Brightness 60
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key Saturation 140
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key Contrast 105
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key CornerRadius 10.0
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key BlurDecorations --type bool true
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key BlurMenus --type bool true
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key BlurDocks --type bool true
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key BlurMatching --type bool true
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key BlurNonMatching --type bool false
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Effect-better-blur-dx --key WindowClasses "org.kde.dolphin
org.kde.konsole
kitty
kate
systemsettings
quickshell
org.quickshell
/.*dolphin.*/
/.*konsole.*/
/.*kitty.*/
/.*kate.*/
/.*systemsettings.*/
/.*quickshell.*/"

    # Round the window shape itself, not just the blur region behind it, so a
    # translucent client (Konsole) does not show square content corners inside
    # the rounded blur. Radius must match Better Blur's CornerRadius.
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Plugins --key kwin4_effect_shapecornersEnabled --type bool true
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Round-Corners --key Size 10
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Round-Corners --key InactiveCornerRadius 10
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Round-Corners --key OutlineThickness 0
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Round-Corners --key InactiveOutlineThickness 0
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Round-Corners --key SecondOutlineThickness 0
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Round-Corners --key InactiveSecondOutlineThickness 0
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Round-Corners --key OuterOutlineThickness 0
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRC" --group Round-Corners --key InactiveOuterOutlineThickness 0

    # Disable Baloo file indexer to save CPU and disk I/O
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$HOME/.config/baloofilerc" --group "Basic Settings" --key "Indexing-Enabled" --type bool false

    if [ -z "$DRY_RUN_CMD" ]; then
      ${pkgs.kdePackages.qttools}/bin/qdbus org.kde.KWin /KWin org.kde.KWin.reconfigure || true
    fi
  '';

  # KWin reads window rules only at startup and, when it reconfigures while
  # holding a stale rule book, saves that book over the file. Writing the rules
  # before the reconfigure above therefore leaves an empty kwinrulesrc. Run
  # after every reconfigure has settled and write the rules last; they apply on
  # the next KWin start (re-login).
  home.activation.configureKWinRules = lib.hm.dag.entryAfter [ "configureKWinBlur" "configureKWinAnimations" ] ''
    KWINRULESRC="$HOME/.config/kwinrulesrc"

    if [ -z "$DRY_RUN_CMD" ] && ${pkgs.kdePackages.qttools}/bin/qdbus org.kde.KWin /KWin >/dev/null 2>&1; then
      ${pkgs.coreutils}/bin/sleep 2
    fi

    # Configure KWin Window Rules: Force Opacity (mode 2)
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRULESRC" --group General --key count 1
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRULESRC" --group General --key rules 1
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRULESRC" --group 1 --key Description "Frosted Glass Blur for Apps"
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRULESRC" --group 1 --key opacityactive 90
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRULESRC" --group 1 --key opacityactivemode 2
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRULESRC" --group 1 --key opacityinactive 85
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRULESRC" --group 1 --key opacityinactivemode 2
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRULESRC" --group 1 --key types 1
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRULESRC" --group 1 --key wmclass ".*"
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file "$KWINRULESRC" --group 1 --key wmclassmatch 3
  '';
}

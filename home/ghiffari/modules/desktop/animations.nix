{ lib, pkgs, ... }:

let
  kwriteconfig = "${pkgs.kdePackages.kconfig}/bin/kwriteconfig6";
in
{
  # macOS-like window animations. KWin applies these live on the next reconfigure
  # (System Settings > Window Management > Desktop Effects), no rebuild of the
  # session needed.
  home.activation.configureKWinAnimations = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    KWINRC="$HOME/.config/kwinrc"

    # Open/close: Scale effect, growing/shrinking from the window center.
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Plugins --key scaleEnabled --type bool true
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Effect-scale --key Duration 200
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Effect-scale --key InScale 0.85
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Effect-scale --key OutScale 0.85

    # Minimize: genie-style Magic Lamp, the closest KWin effect to macOS.
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Plugins --key magiclampEnabled --type bool true
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Effect-magiclamp --key AnimationDuration 250

    # Wobbly Windows only behaves with Better Blur DX when the blur is forced
    # by BBDX itself (window class list), not requested by the app: BBDX then
    # fades the blur out during the drag instead of dragging a rectangular
    # blur region. Keep Konsole's own Blur setting off (konsole.nix).
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Plugins --key wobblywindowsEnabled --type bool true
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Effect-wobblywindows --key Settings Custom
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Effect-wobblywindows --key WobblynessLevel 0
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Effect-wobblywindows --key Stiffness 15
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Effect-wobblywindows --key Drag 80
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Effect-wobblywindows --key MoveFactor 10
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Effect-wobblywindows --key MoveWobble --type bool true
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Effect-wobblywindows --key ResizeWobble --type bool false

    # Menus and tooltips.
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Plugins --key slidingpopupsEnabled --type bool true
    $DRY_RUN_CMD ${kwriteconfig} --file "$KWINRC" --group Plugins --key fadingpopupsEnabled --type bool true
  '';
}

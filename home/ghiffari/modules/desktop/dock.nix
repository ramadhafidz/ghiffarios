{ lib, pkgs, ... }:

let
  kwriteconfig = "${pkgs.kdePackages.kconfig}/bin/kwriteconfig6";
in
{
  # Wayland-native Latte fork: parabolic (macOS-style) icon zoom on hover,
  # dot indicators, animated auto-hide.
  systemd.user.services.latte-dock = {
    Unit = {
      Description = "Latte Dock NG";
      PartOf = [ "plasma-workspace.target" ];
      After = [ "plasma-workspace.target" ];
    };
    Service = {
      ExecStart = "${pkgs.latte-dock-ng}/bin/latte-dock-ng --replace";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install.WantedBy = [ "plasma-workspace.target" ];
  };

  # Modern style profile: floating dock with rounded corners, translucent glass,
  # macOS-style dot indicators, 42px icon size, and 70% hover zoom (zoomLevel 14).
  home.activation.configureLatteDock = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    LATTE_DIR="$HOME/.config/latte"
    TEMPLATE="${pkgs.latte-dock-ng}/share/plasma/shells/org.kde.latte.shell/contents/templates/Default.layout.latte"

    # Remove KDE desktop autostart entry to prevent duplicate instances
    # (autostart is fully managed by systemd user service above)
    rm -f "$HOME/.config/autostart/org.kde.latte-dock.desktop"

    mkdir -p "$LATTE_DIR"
    if [ ! -f "$LATTE_DIR/My Layout.layout.latte" ] && [ -f "$TEMPLATE" ]; then
      cp "$TEMPLATE" "$LATTE_DIR/My Layout.layout.latte"
      chmod u+w "$LATTE_DIR/My Layout.layout.latte"
    fi

    for layout in "$LATTE_DIR/My Layout.layout.latte" "$LATTE_DIR/Default.layout.latte"; do
      if [ -f "$layout" ]; then
        chmod u+w "$layout" 2>/dev/null || true
        $DRY_RUN_CMD ${kwriteconfig} --file "$layout" --group Containments --group 1 --group General --key dockStyle 1
        $DRY_RUN_CMD ${kwriteconfig} --file "$layout" --group Containments --group 1 --group General --key iconSize 42
        $DRY_RUN_CMD ${kwriteconfig} --file "$layout" --group Containments --group 1 --group General --key zoomLevel 14
        $DRY_RUN_CMD ${kwriteconfig} --file "$layout" --group Containments --group 1 --group Applets --group 2 --group Configuration --group General --key launchers59 "preferred://browser,preferred://filemanager,applications:org.kde.konsole.desktop,applications:systemsettings.desktop"
      fi
    done
  '';
}

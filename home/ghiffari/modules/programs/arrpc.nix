{ pkgs, ... }:

{
  home.packages = with pkgs; [
    arrpc
  ];

  # Daemon background untuk mem-bridge status game Proton/Wine ke Discord Linux
  systemd.user.services.arrpc = {
    Unit = {
      Description = "arRPC Discord Rich Presence Bridge";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.arrpc}/bin/arrpc";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "default.target" ];
  };
}

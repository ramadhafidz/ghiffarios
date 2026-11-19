{ pkgs, ... }:

{
  # Virtual input subsystem permission for Wine, Proton, and user-space gamepad emulation
  hardware.uinput.enable = true;

  # Steam hardware udev rules for controllers
  hardware.steam-hardware.enable = true;

  # Comprehensive udev rules for hundreds of controllers (DualShock 3/4, DualSense, Xbox, Switch, and clones)
  # Ensures non-root users can access /dev/input/js* and /dev/input/event* devices directly
  services.udev.packages = with pkgs; [
    game-devices-udev-rules
  ];

  # Diagnostic, calibration, and pairing tools for game controllers
  environment.systemPackages = with pkgs; [
    sixpair     # CLI tool to pair PS3 controllers to PC Bluetooth MAC address if auto-pair fails
    jstest-gtk  # Graphical joystick/gamepad tester and calibration GUI
    evtest      # CLI event tester for input devices
  ];
}

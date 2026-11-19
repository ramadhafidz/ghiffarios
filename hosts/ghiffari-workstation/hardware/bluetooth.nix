{ pkgs, ... }:

{
  # Enable Linux Bluetooth subsystem and BlueZ stack
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Enable BlueZ experimental features (battery level reporting & enhanced HID gamepad support)
        Experimental = true;
        # Essential for PS3 controllers (both original Sony and clone/OEM such as Shanwan/Gasia)
        # to complete the non-standard Bluetooth handshake without premature disconnects
        ClassicBondedOnly = false;
      };
      Policy = {
        # Automatically power on adapter on boot
        AutoEnable = true;
      };
    };
  };

  # Graphical Bluetooth manager tray applet
  services.blueman.enable = true;
}

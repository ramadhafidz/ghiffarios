{ pkgs, ... }:

{
  # Steam and required 32-bit libraries for gaming
  environment.systemPackages = with pkgs; [
    steam
  ];
}
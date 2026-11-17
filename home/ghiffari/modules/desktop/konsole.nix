{ ... }:

{
    # Konsole profile using JetBrains Mono Nerd Font.
    # Font family name is the one registered by pkgs.nerd-fonts.jetbrains-mono.
    home.file.".local/share/konsole/JetbrainsMono.profile".text = ''
[General]
Name=JetbrainsMono

[Appearance]
Font=JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0
    '';

    home.file.".config/konsolerc".text = ''
[General]
ConfigVersion=1

[UiSettings]
ColorScheme=

[Desktop Entry]
DefaultProfile=JetbrainsMono.profile
    '';
}

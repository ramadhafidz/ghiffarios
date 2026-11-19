{ ... }:

{
    # Konsole terminal background matches the Breeze window body so the
    # terminal and tab bar read as one surface. Transparency and blur are
    # applied to the whole window by KWin (blur.nix), not per-terminal, so
    # the terminal chrome and content share the same alpha and tint.
    home.file.".local/share/konsole/BreezeTransparent.colorscheme".text = ''
[General]
Description=Breeze Transparent

[Background]
Color=42,46,50

[BackgroundFaint]
Color=42,46,50

[BackgroundIntense]
Color=42,46,50

[Foreground]
Color=252,252,252

[ForegroundFaint]
Color=175,176,179

[ForegroundIntense]
Color=255,255,255
    '';

    # Konsole profile using JetBrains Mono Nerd Font and transparent blur color scheme
    home.file.".local/share/konsole/JetbrainsMono.profile".text = ''
[General]
Name=JetbrainsMono

[Appearance]
ColorScheme=BreezeTransparent
Font=JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0
UseEffects=true
    '';

    # Default profile: Hurmit Nerd Font Mono, blinking animated cursor
    home.file.".local/share/konsole/ghiffari.profile" = {
        force = true;
        text = ''
[Appearance]
ColorScheme=BreezeTransparent
Font=Hurmit Nerd Font Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,,0,0

[Cursor Options]
CursorShape=1
UseCustomCursorColor=false

[General]
Name=ghiffari
Parent=FALLBACK/

[Terminal Features]
AnimatingCursorEnabled=true
BlinkingCursorEnabled=true
        '';
    };

    home.file.".config/konsolerc".text = ''
[General]
ConfigVersion=1

[UiSettings]
ColorScheme=BreezeTransparent

[Desktop Entry]
DefaultProfile=ghiffari.profile
    '';
}

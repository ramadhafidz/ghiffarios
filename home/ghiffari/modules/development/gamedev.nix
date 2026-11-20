{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Godot Engine (Latest 4.x)
    godot_4       # Standard Godot 4 (GDScript, C++)
    godot_4-mono  # Godot 4 Mono edition (full C# / .NET 8 support)

    # Unity Engine (Official Hub)
    unityhub      # Unity Hub for managing Unity Editors (Unity 6, 2022 LTS, etc.) and projects
  ];
}

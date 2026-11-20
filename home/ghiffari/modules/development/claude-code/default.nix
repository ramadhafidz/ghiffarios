{ pkgs, ... }:

{
  home.packages = [
    pkgs.claude-code
  ];

  programs.zsh.shellAliases = {
    claude-code = "claude";
  };
}

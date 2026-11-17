{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Additional plugins via oh-my-zsh
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "sudo"
        "history-substring-search"
        "npm"
        "python"
        "rust"
        "node"
        "fzf"
        "vi-mode"
        "colorful"
        "command-not-found"
      ];
      extraConfig = ''
        # Disable the default prompt substitution noise; keep a clean two-line prompt
        autoload -Uz vcs_info
        precmd() { vcs_info }
        zstyle ':vcs_info:git:*' formats ' %F{yellow}%b%f'
        setopt PROMPT_SUBST
        PROMPT='%F{cyan}%~%f$(vcs_info_msg_0_) %F{magenta}❯%f '
      '';
    };

    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake ~/Workspace/github/ghiffarios#ghiffari-workstation";
      g = "git";
      gco = "git checkout";
      gbr = "git branch";
      glog = "git log --oneline --graph --decorate";
    };

    history = {
      size = 10000;
      ignoreDups = true;
      share = true;
      append = true;
    };
  };

  home.packages = with pkgs; [
    fzf
    zsh-autopair
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
}
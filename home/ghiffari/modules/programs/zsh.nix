{ ... }:

{
    programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            ll = "ls -la";
            update = "sudo nixos-rebuild switch --flake ~/Workspace/github/ghiffarios#ghiffari-workstation";
        };

        history = {
            size = 10000;
            ignoreDups = true;
            share = true;
        };

        initContent
            # Disable the default prompt substitution noise; keep a clean two-line prompt
            autoload -Uz vcs_info
            precmd() { vcs_info }
            zstyle ':vcs_info:git:*' formats ' %F{yellow}%b%f'
            setopt PROMPT_SUBST
            PROMPT='%F{cyan}%~%f$(vcs_info_msg_0_) %F{magenta}❯%f '
        '';
    };
}

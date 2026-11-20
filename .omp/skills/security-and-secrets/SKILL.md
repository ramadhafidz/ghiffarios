---
name: security-and-secrets
description: Conventions for 1Password integration, SSH agent, Git commit signing, firewall rules, and secret management.
---

# Security & Secrets

Conventions for credentials, SSH agent, Git commit signing, and firewall configuration on GhiffariOS.

## 1Password Integration

1. **SSH Agent Socket**:
   - Location: `~/.1password/agent.sock`
   - Configured in SSH client (`home/ghiffari/modules/programs/git.nix` / SSH config):
     ```ssh-config
     Host *
         IdentityAgent ~/.1password/agent.sock
     ```

2. **Git Commit Signing via SSH**:
   - Configured declaratively in `home/ghiffari/modules/programs/git.nix`:
     - `programs.git.settings.commit.gpgsign = true`
     - `programs.git.settings.gpg.format = "ssh"`
     - `programs.git.settings.gpg.ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign"`
     - `programs.git.settings.user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH7o22oXJq6kC4+Z18Hia92sM6BvVf58P3P0K68tT9n1"`
   - **Interactive Terminal Requirement**:
     - Background processes and AI subshells do not have access to the graphical interactive prompt for 1Password biometric/master password authorization.
     - Operations requiring 1Password approval (e.g. `git push`, signing commits) should be executed in the user's interactive terminal (Konsole/Kitty).

3. **Secrets Handling Rules**:
   - **Never hardcode secrets** in Nix files or commit them to git.
   - For agent or tool authorization (e.g. MCP servers), fetch credentials dynamically using 1Password CLI `op read`:
     ```bash
     op read 'op://Personal/Item Name/field'
     ```

## Network & Firewall Boundaries

1. **OpenSSH Daemon**:
   - Managed in `modules/nixos/services/ssh.nix`.
   - `services.openssh.settings.PasswordAuthentication = false` (key-based auth only).
   - `services.openssh.settings.KbdInteractiveAuthentication = false`.
   - `networking.firewall.allowedTCPPorts = [ 22 ]`.

2. **Firewall Policy**:
   - Default: All incoming ports blocked unless explicitly declared.
   - Any opened port must be documented in module configuration with its justification.

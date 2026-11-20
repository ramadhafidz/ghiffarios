---
name: dev-environments
description: Conventions for project dev shells, direnv with nix-direnv caching, and reproducible developer tooling.
---

# Dev Environments

Conventions for development tooling and reproducible project environments on GhiffariOS.

## Philosophy

- **No Global Language Runtimes**: Avoid installing Node.js, Go, Rust toolchains globally unless required system-wide.
- **Isolated Shells**: Every project should declare its toolchains and libraries using a per-project `flake.nix` `devShell`.
- **Fast Activation**: Use `direnv` with `nix-direnv` for instant environment loading and GC-root caching.

## Configuration & Tools

1. **Direnv Integration**:
   - Declaratively enabled via `home/ghiffari/modules/development/direnv.nix`:
     ```nix
     programs.direnv = {
       enable = true;
       nix-direnv.enable = true;
     };
     ```
   - Shell hooks are automatically injected into Zsh/Bash.

2. **Global Modern CLI Utilities**:
   - Maintained in `home/ghiffari/modules/development/tools.nix`:
     - Git / GitHub: `lazygit`, `gh`
     - Modern shell coreutils: `eza`, `ripgrep`, `fd`, `bat`, `jq`
     - Build basics: `gcc`, `gnumake`, `python3`

3. **Project Scaffolding (`nix-dev-init`)**:
   - Quick generator script for `flake.nix` + `.envrc`:
     - Run `nix-dev-init [rust|go|python|node|cpp|general]` inside an empty project folder.
     - Automatically creates `.envrc` (`use flake`), `.gitignore` entry for `.direnv`, and a flake template.
     - Run `direnv allow` to activate.

4. **Direnv Workflow**:
   - Create `.envrc` with:
     ```bash
     use flake
     ```
   - Ensure `.direnv` is added to `.gitignore`.
   - Run `direnv allow` in terminal.

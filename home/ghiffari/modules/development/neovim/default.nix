{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      plenary-nvim
      telescope-nvim
      oil-nvim

      (nvim-treesitter.withPlugins (
        p: with p; [
          nix
          lua
          python
          javascript
          typescript
          rust
          bash
          json
          yaml
          markdown
        ]
      ))

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets

      lualine-nvim
      bufferline-nvim
      which-key-nvim
      gitsigns-nvim
      nvim-autopairs
      comment-nvim
    ];

    extraPackages = with pkgs; [
      ripgrep
      fd
      fzf
      nil
      nixfmt
      lua-language-server
      stylua
      pyright
      ruff
      typescript-language-server
      rust-analyzer
      rustfmt
      marksman
    ];

    initLua = builtins.readFile ./config/init.lua;
  };

  xdg.configFile."nvim/lua".source = ./config;
}

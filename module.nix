inputs: {
  wlib,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [wlib.wrapperModules.neovim];

  config.specs.general = with pkgs.vimPlugins; [
    # plugins which are loaded at startup (start) ...
  ];
  config.specs.lazy = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      # plugins which are not loaded until you vim.cmd.packadd them (opt) ...
      #
      # vim-nix # fix indentation for ft=nix
      #
      # vim-startuptime

      # themes
      gruvbox-material
      onedark-nvim
      kanagawa-paper-nvim

      vim-sleuth
      mini-nvim
      bufferline-nvim
      blink-indent
      snacks-nvim

      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-treesitter-context

      nvim-lspconfig
      nvim-lint
      conform-nvim
      blink-cmp
      friendly-snippets

      nvim-dap
      nvim-dap-view
      nvim-dap-python
    ];
  };
  config.extraPackages = with pkgs; [
    # lsps, formatters, etc...
    # Formatters
    # others should be installed in devshell
    stylua
    # nix tooling always available
    alejandra
    nixd

    yaml-language-server

    # fuzzy pickers
    ripgrep
    fd

    wl-clipboard
  ];
  config.settings.dont_link = true;

  options.settings.base16palette = lib.mkOption {
    type = lib.types.nullOr (lib.types.attrsOf lib.types.str);
    default = null;
  };
}

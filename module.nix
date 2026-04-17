inputs: {
  wlib,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [wlib.wrapperModules.neovim];

  specs.general = with pkgs.vimPlugins; [
    # plugins which are loaded at startup (start) ...
  ];
  specs.lazy = {
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
      conform-nvim
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-lspconfig
      nvim-lint
      blink-cmp
      friendly-snippets
      bufferline-nvim
      nvim-dap
      nvim-dap-view
    ];
  };
  extraPackages = with pkgs; [
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
  settings.dont_link = true;
}

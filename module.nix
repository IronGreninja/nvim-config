inputs: {
  wlib,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [wlib.wrapperModules.neovim];

  specs.general = with pkgs.vimPlugins; [
    # plugins which are loaded at startup ...
    lz-n # lazy-loading
    vim-sleuth # auto set shiftwidth & expandtab
    plenary-nvim # dep library for some plugins
    nui-nvim # ui-library
    snacks-nvim # some plugins need early-start
    nvim-notify
    friendly-snippets # provids a bunch of snippets for diff languages

    mini-icons
    mini-files

    # themes
    kanagawa-paper-nvim
    onedark-nvim
    gruvbox-material

    # lang
    vim-nix # fix indentation
  ];
  specs.lazy = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      # plugins which are not loaded until you vim.cmd.packadd them ...
      blink-cmp # Completion
      nvim-lspconfig # LSP
      nvim-lint # Linter
      conform-nvim # Formatter
      nvim-treesitter.withAllGrammars

      which-key-nvim
      lualine-nvim
      bufferline-nvim
      indent-blankline-nvim
      fidget-nvim
      noice-nvim

      telescope-nvim
      telescope-fzf-native-nvim

      nvim-colorizer-lua
      gitsigns-nvim

      mini-pairs
      mini-surround
      mini-comment

      vim-startuptime
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

    # Telescope deps
    ripgrep
    fd

    wl-clipboard
  ];
  settings.dont_link = true;
}

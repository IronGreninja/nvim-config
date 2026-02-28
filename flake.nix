{
  description = "IronGreninja's neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    wrappers,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux"];
    module = nixpkgs.lib.modules.importApply ./module.nix inputs;
    wrapper = wrappers.lib.evalModule module;
  in {
    wrapperModules = {
      neovim = module;
      default = self.wrapperModules.neovim;
    };
    wrappers = {
      neovim = wrapper.config;
      default = self.wrappers.neovim;
    };
    packages = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};
        lib = pkgs.lib;
      in {
        default = self.packages.${system}.neovim;
        neovim = wrapper.config.wrap {
          inherit pkgs;
          settings.config_directory = ./.;
          settings.aliases = ["nv"];
        };
        test = wrapper.config.wrap {
          inherit pkgs;
          settings.config_directory =
            lib.generators.mkLuaInline
            "vim.fs.joinpath(vim.uv.os_homedir(), 'nvim-config')";
          binName = "nvim-test";
          settings.aliases = ["nvt"];
        };
      }
    );
  };
}

return {
  { import = "plugins.mini" },
  {
    "indent-blankline.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("ibl").setup { indent = { char = "│" }, scope = { enabled = true } }
    end,
  },
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("which-key").setup {
        preset = "modern",
        delay = 400,
        spec = wk_specs,
      }
    end,
  },
  {
    "nvim-colorizer.lua",
    event = "DeferredUIEnter",
    after = function()
      require("colorizer").setup {
        user_default_options = { css_fn = true, mode = "virtualtext", names = true, virtualtext = "■" },
      }
    end,
  },
  {
    "vim-startuptime",
    cmd = { "StartupTime" },
    before = function()
      vim.g.startuptime_event_width = 0
      vim.g.startuptime_tries = 10
      vim.g.startuptime_exe_path = require("nix-info").progpath
    end,
  },
  {
    "fidget.nvim",
    event = "DeferredUIEnter",
    -- keys = "",
    after = function()
      require("fidget").setup {}
    end,
  },
}

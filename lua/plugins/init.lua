-- Early setup (No lazy loading) stuff
require("mini.icons").setup {}
MiniIcons.mock_nvim_web_devicons()

require "plugins.mini.files"
--
--
return {
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
      vim.g.startuptime_exe_path = require("nixCats").packageBinPath
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

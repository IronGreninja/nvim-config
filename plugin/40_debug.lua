Config.later(function()
  Util.plugAdd "mfussenegger/nvim-dap"

  require("overseer").enable_dap()

  local dap = require "dap"

  dap.defaults.fallback.external_terminal = {
    command = "wezterm",
    args = { "-e" },
  }
  -- dap.defaults.fallback.force_external_terminal = true
  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

  --[[ Adapter config ]]
  dap.adapters.codelldb = {
    type = "executable",
    command = vim.env.CODELLDB_PATH,
  }

  --[[ Debugee config ]]
  -- Note: use ./.vscode/launch.json for custom configs. An example is included in this repo.

  -- additional plugins that provide nvim-dap configs:
  Util.plugAdd "mfussenegger/nvim-dap-python"
  require("dap-python").setup()
end)

Config.later(function()
  Util.plugAdd "igorlfs/nvim-dap-view"
  --
  require("dap-view").setup {
    winbar = {
      sections = {
        "breakpoints",
        "watches",
        "scopes",
        "exceptions",
        "threads",
        "repl",
        "console",
      },
      default_section = "scopes",
      controls = {
        enabled = true,
        buttons = {
          "play",
          "step_into",
          "step_over",
          "step_out",
          "step_back",
          "terminate",
        },
      },
    },
    windows = { position = "below", size = 0.3 },
    auto_toggle = "keep_terminal",
    virtual_text = { enabled = true, position = "eol" },
  }
end)

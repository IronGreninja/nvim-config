Config.later(function()
  Util.plugAdd "mfussenegger/nvim-dap"

  local dap = require "dap"

  dap.defaults.fallback.external_terminal = {
    command = "kitty",
  }

  dap.adapters.codelldb = {
    type = "executable",
    command = vim.env.CODELLDB_PATH,
  }

  dap.configurations.c = {
    {
      name = "Launch(codelldb)",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      args = {}, -- provide arguments if needed
      cwd = "${workspaceFolder}",
      -- stdio = { "input.txt", nil, nil },
      terminal = "integrated",
      -- terminal = "external",
    },
  }
  dap.configurations.cpp = dap.configurations.c

  Util.plugAdd "mfussenegger/nvim-dap-python"
  require("dap-python").setup()
end)

Config.later(function()
  Util.plugAdd "igorlfs/nvim-dap-view"
  --
  require("dap-view").setup {
    -- winbar = { controls = { enabled = true } },
    auto_toggle = "keep_terminal",
    -- virtual_text = { enabled = true },
  }
end)

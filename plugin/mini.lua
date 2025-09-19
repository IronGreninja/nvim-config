local lzn = require "lz.n"
lzn.load {
  "mini.nvim",
  event = "DeferredUIEnter",
  before = function()
    lzn.trigger_load "which-key.nvim"
  end,
  after = function()
    require("mini.icons").setup {}
    MiniIcons.mock_nvim_web_devicons()

    require("mini.comment").setup {}

    require("mini.files").setup {
      content = {
        filter = function(fs_entry)
          local hidden = { [".git"] = 1, [".direnv"] = 1 }
          return not hidden[fs_entry.name]
        end,
      },
      options = { permanent_delete = false, use_as_default_explorer = true },
      windows = { preview = true },
    }

    require("mini.surround").setup {}
    require("mini.pairs").setup {}

    require("which-key").add {
      "<leader>e",
      group = "+Explorer",
      icon = "󰙅 ",
    }

    local map = require("utils").map
    map("n", "<leader>eo", ":lua MiniFiles.open()<CR>", "Open File Explorer")
    map("n", "<leader>eF", ":lua MiniFiles.open(nil, false)<CR>", "Open fresh explorer in cwd")
    map(
      "n",
      "<leader>eF",
      ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>",
      "Open fresh explorer in directory of current file"
    )
  end,
}

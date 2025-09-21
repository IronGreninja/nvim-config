local opts = {
  content = {
    filter = function(fs_entry)
      local hidden = { [".git"] = 1, [".direnv"] = 1 }
      return not hidden[fs_entry.name]
    end,
  },
  options = { permanent_delete = false, use_as_default_explorer = true },
  windows = { preview = true },
}

require("mini.files").setup(opts)

table.insert(wk_specs, {
  "<leader>e",
  group = "+Explorer",
  icon = "󰙅 ",
})

local map = require("utils").map
map("n", "<leader>eo", ":lua MiniFiles.open()<CR>", "Open File Explorer")
map("n", "<leader>eF", ":lua MiniFiles.open(nil, false)<CR>", "Open fresh explorer in cwd")
map(
  "n",
  "<leader>eC",
  ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>",
  "Open fresh explorer in directory of current file"
)

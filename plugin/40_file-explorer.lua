Config.now_if_args(function()
  -- Enable directory/file preview
  require("mini.files").setup {
    windows = { preview = true },
    options = { permanent_delete = false, use_as_default_explorer = true },
    content = {
      filter = function(fs_entry)
        local hidden = { [".git"] = 1, [".direnv"] = 1 }
        return not hidden[fs_entry.name]
      end,
    },
  }

  -- Add common bookmarks for every explorer. Example usage inside explorer:
  -- - `g?` to see available bookmarks
  local add_marks = function()
    MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
  end
  Config.new_autocmd("User", "MiniFilesExplorerOpen", add_marks, "Add bookmarks")
end)

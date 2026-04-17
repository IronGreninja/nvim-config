vim.g.autoformat = true

Config.later(function()
  Util.plugAdd "stevearc/conform.nvim"

  -- See:
  -- - `:h Conform`
  -- - `:h conform-options`
  -- - `:h conform-formatters`
  require("conform").setup {
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
      if not (vim.g.autoformat or vim.b[bufnr].autoformat) then return end

      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
      _ = { "squeeze_blanks", "trim_whitespace" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      lua = { "stylua" },
      markdown = { "mdformat" },
      nix = { "alejandra" },
      python = { "ruff_organize_imports", "ruff_format" },
      go = { "gofmt" },
      java = { "google-java-format" },
    },
    log_level = vim.log.levels.WARN,
    notify_no_formatters = true,
    notify_on_error = true,
  }
end)

Config.new_usercmd("FormatDisable", function(args)
  if args.bang then
    vim.b.autoformat = false
    vim.notify(
      "Automatic formatting on save is now disabled for this buffer.",
      vim.log.levels.INFO
    )
  else
    vim.g.autoformat = false
    vim.notify("Automatic formatting on save is now disabled.", vim.log.levels.INFO)
  end
end, { bang = true, desc = "Disable automatic formatting on save" })

Config.new_usercmd("FormatEnable", function(args)
  if args.bang then
    vim.b.autoformat = true
    vim.notify(
      "Automatic formatting on save is now enabled for this buffer.",
      vim.log.levels.INFO
    )
  else
    vim.g.autoformat = true
    vim.notify("Automatic formatting on save is now enabled.", vim.log.levels.INFO)
  end
end, { bang = true, desc = "Enable automatic formatting on save" })

Config.new_usercmd("FormatToggle", function(args)
  if args.bang then
    vim.b.autoformat = not vim.b.autoformat

    if vim.b.autoformat then
      vim.notify(
        "Automatic formatting on save is now enabled for this buffer.",
        vim.log.levels.INFO
      )
    else
      vim.notify(
        "Automatic formatting on save is now disabled for this buffer.",
        vim.log.levels.INFO
      )
    end
  else
    vim.g.autoformat = not vim.g.autoformat

    if vim.g.autoformat then
      vim.notify("Automatic formatting on save is now enabled.", vim.log.levels.INFO)
    else
      vim.notify("Automatic formatting on save is now disabled.", vim.log.levels.INFO)
    end
  end
end, { bang = true, desc = "Toggle automatic formatting on save" })

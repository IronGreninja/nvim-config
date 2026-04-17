-- Language Server Protocol (LSP) is a set of conventions that power creation of
-- language specific tools. It requires two parts:
-- - Server - program that performs language specific computations.
-- - Client - program that asks server for computations and shows results.
--
-- Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
-- be installed separately based on your OS, CLI tools, and preferences.
--
-- Neovim's team collects commonly used configurations for most language servers
-- inside 'neovim/nvim-lspconfig' plugin.
--
-- Add it now if file (and not 'mini.starter') is shown after startup.
Config.now_if_args(function()
  Util.plugAdd "neovim/nvim-lspconfig"

  -- Use `:h vim.lsp.enable()` to automatically enable language server based on
  -- the rules provided by 'nvim-lspconfig'.
  -- Use `:h vim.lsp.config()` or 'after/lsp/' directory to configure servers.
  -- Tweak the following `vim.lsp.enable()` call to enable servers.
  vim.lsp.enable {
    "lua_ls",
    "clangd",
    "pyright",
    "nixd",
    "yamlls",
    "gopls",
  }
end)

-- Linters. Provide additional diagnostics, complementing the lsp
Config.now_if_args(function()
  Util.plugAdd "mfussenegger/nvim-lint"

  local for_c = { "clangtidy" }
  require("lint").linters_by_ft = {
    c = for_c,
    cpp = for_c,
    python = { "ruff" },
  }

  -- Lint on read, write & insert leave
  Config.new_autocmd(
    { "BufReadPost", "BufWritePost", "InsertLeave" },
    nil,
    function() require("lint").try_lint(nil, { ignore_errors = true }) end,
    "Lint"
  )
end)

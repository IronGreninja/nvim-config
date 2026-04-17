-- Tree-sitter is a tool for fast incremental parsing. It converts text into
-- a hierarchical structure (called tree) that can be used to implement advanced
-- and/or more precise actions: syntax highlighting, textobjects, indent, etc.
--
-- Tree-sitter support is built into Neovim (see `:h treesitter`). However, it
-- requires two extra pieces that don't come with Neovim directly:
-- - Language parsers: programs that convert text into trees. Some are built-in
--   (like for Lua), 'nvim-treesitter' provides many others.
--   NOTE: It requires third party software to build and install parsers.
-- - Query files: definitions of how to extract information from trees in
--   a useful manner (see `:h treesitter-query`). 'nvim-treesitter' also provides
--   these, while 'nvim-treesitter-textobjects' provides the ones for Neovim
--   textobjects (see `:h text-objects`, `:h MiniAi.gen_spec.treesitter()`).
--
-- Add these plugins now if file (and not 'mini.starter') is shown after startup.
--
-- Troubleshooting:
-- - Run `:checkhealth vim.treesitter nvim-treesitter` to see potential issues.
Config.now_if_args(function()
  -- (non-nix) Define hook to update tree-sitter parsers after plugin is updated.
  -- this is needed before vim.pack.add
  if not nixInfo.isNix then
    local ts_update = function() vim.cmd "TSUpdate" end
    Config.on_packchanged("nvim-treesitter", { "update" }, ts_update, ":TSUpdate")
  end

  Util.plugAdd "nvim-treesitter/nvim-treesitter"
  Util.plugAdd "nvim-treesitter/nvim-treesitter-textobjects"
  --[[ (non-nix) auto-install parsers (method 1)
  if not nixInfo.isNix then
    Util.plugAdd "lewis6991/ts-install.nvim"
    require("ts-install").setup { auto_install = true }
  end
  --]]

  local ts_start = function(args)
    local buf, filetype = args.buf, args.match
    local lang = vim.treesitter.language.get_lang(filetype) or filetype
    -- [[ (non-nix) auto-install parsers (method 2)
    -- Check if parser is installed
    local ok = pcall(vim.treesitter.query.get, lang, "highlights")
    if not ok and not nixInfo.isNix then
      -- Install the parser asynchronously
      require("nvim-treesitter").install(lang)
    end
    --]]

    if not lang then return end

    -- check if parser exists and load it
    if not vim.treesitter.language.add(lang) then return end
    -- enables syntax highlighting and other treesitter features
    vim.treesitter.start(buf, lang)

    -- enables treesitter based folds
    -- for more info on folds see `:help folds`
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"

    -- enables treesitter based indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end

  Config.new_autocmd("FileType", nil, ts_start, "Start tree-sitter")

  -- keymaps
  -- creating textobject selection mappings can be done with `mini.ai`
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { desc = desc })
  end

  local swap = require "nvim-treesitter-textobjects.swap"
  map(
    "n",
    "<leader>os",
    function() swap.swap_next "@parameter.inner" end,
    "Swap with next param"
  )
  map(
    "n",
    "<leader>oS",
    function() swap.swap_previous "@parameter.inner" end,
    "Swap with prev param"
  )

  local move = require "nvim-treesitter-textobjects.move"
  map(
    { "n", "x", "o" },
    "]m",
    function() move.goto_next_start("@function.outer", "textobjects") end,
    "Go to next method start"
  )
  map(
    { "n", "x", "o" },
    "[m",
    function() move.goto_previous_start("@function.outer", "textobjects") end,
    "Go to prev method start"
  )
end)

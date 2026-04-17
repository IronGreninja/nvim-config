-- Completion

Config.on_event("InsertEnter,CmdlineEnter", function()
  -- Config.now_if_args(function()
  Util.plugAdd "saghen/blink.cmp"
  require("blink-cmp").setup {
    keymap = { preset = "default" },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    appearance = { nerd_font_variant = "mono", use_nvim_cmp_as_default = true },
    completion = {
      keyword = { range = "full" },
      trigger = { show_on_trigger_character = true },
      documentation = {
        auto_show = true,
        -- auto_show_delay_ms = 500,
      },
      ghost_text = {
        enabled = true,
        show_with_menu = false, -- only show when menu is closed
      },
      menu = {
        auto_show = false, -- only show menu on manual <C-space>
        auto_show_delay_ms = 300,
        draw = {
          columns = {
            { "kind_icon", "label", "label_description", gap = 1 },
            { "source_id" },
            -- { "label", "label_description", gap = 1 },
            -- { "kind_icon", "kind", gap = 1 },
          },
          components = {
            -- source_name = {
            --   text = function(ctx) return string.format("[%s]", ctx.source_name) end,
            -- },
          },
        },
      },
    },
    signature = {
      enabled = true,
      -- window = { show_documentation = false },
    },
    snippets = { preset = "mini_snippets" },
    cmdline = {
      keymap = { preset = "inherit" },
      -- sources = { "cmdline" },
      completion = {
        menu = {
          auto_show = function(ctx)
            return vim.fn.getcmdtype() == ":"
            -- enable for inputs as well, with:
            -- or vim.fn.getcmdtype() == '@'
          end,
        },
      },
    },
  }
end)

-- Snippets

-- Manage and expand snippets (templates for a frequently used text).
-- Typical workflow is to type snippet's (configurable) prefix and expand it
-- into a snippet session.
--
-- How to manage snippets:
-- - 'mini.snippets' itself doesn't come with preconfigured snippets. Instead there
--   is a flexible system of how snippets are prepared before expanding.
--   They can come from pre-defined path on disk, 'snippets/' directories inside
--   config or plugins, defined inside `setup()` call directly.
--
-- How to expand a snippet in Insert mode:
-- - If you know snippet's prefix, type it as a word and press `<C-j>`. Snippet's
--   body should be inserted instead of the prefix.
-- - If you don't remember snippet's prefix, type only part of it (or none at all)
--   and press `<C-j>`. It should show picker with all snippets that have prefixes
--   matching typed characters (or all snippets if none was typed).
--   Choose one and its body should be inserted instead of previously typed text.
--
-- How to navigate during snippet session:
-- - Snippets can contain tabstops - places for user to interactively adjust text.
--   Each tabstop is highlighted depending on session progression - whether tabstop
--   is current, was or was not visited. If tabstop doesn't yet have text, it is
--   visualized with special "ghost" inline text: • and ∎ by default.
-- - Type necessary text at current tabstop and navigate to next/previous one
--   by pressing `<C-l>` / `<C-h>`.
-- - Repeat previous step until you reach special final tabstop, usually denoted
--   by ∎ symbol. If you spotted a mistake in an earlier tabstop, navigate to it
--   and return back to the final tabstop.
-- - To end a snippet session when at final tabstop, keep typing or go into
--   Normal mode. To force end snippet session, press `<C-c>`.
--
-- See also:
-- - `:h MiniSnippets-overview` - overview of how module works
-- - `:h MiniSnippets-examples` - examples of common setups
-- - `:h MiniSnippets-session` - details about snippet session
-- - `:h MiniSnippets.gen_loader` - list of available loaders
Config.later(function()
  -- snippet collection

  -- Define language patterns to work better with 'friendly-snippets'
  local latex_patterns = { "latex/**/*.json", "**/latex.json" }
  local lang_patterns = {
    tex = latex_patterns,
    plaintex = latex_patterns,
    -- Recognize special injected language of markdown tree-sitter parser
    markdown_inline = { "markdown.json" },
  }

  local snippets = require "mini.snippets"
  local config_path = vim.fn.stdpath "config"
  snippets.setup {
    snippets = {
      snippets.gen_loader.from_runtime "global.json",
      snippets.gen_loader.from_lang { lang_patterns = lang_patterns },
    },
  }
end)

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
Config.later(function() Util.plugAdd "rafamadriz/friendly-snippets" end)

-- Visualize and work with indent scope. It visualizes indent scope "at cursor"
-- with animated vertical line. Provides relevant motions and textobjects.
-- Example usage:
-- - `cii` - *c*hange *i*nside *i*ndent scope
-- - `Vaiai` - *V*isually select *a*round *i*ndent scope and then again
--   reselect *a*round new *i*indent scope
-- - `[i` / `]i` - navigate to scope's top / bottom
--
-- See also:
-- - `:h MiniIndentscope.gen_animation` - available animation rules
-- later(function() require("mini.indentscope").setup() end)

--[[
-- https://github.com/saghen/blink.indent/issues/49
later(function()
  Util.plugAdd "saghen/blink.indent"
  require("blink.indent").setup {
    static = { char = "│" },
    scope = {
      char = "│",
      -- stylua: ignore start
      highlights = {"BlinkIndentViolet", "BlinkIndentBlue", "BlinkIndentCyan", "BlinkIndentGreen",},
      underline = {
        enabled = true,
        highlights = {"BlinkIndentVioletUnderline", "BlinkIndentBlueUnderline", "BlinkIndentCyanUnderline", "BlinkIndentGreenUnderline",},
      -- stylua: ignore end
      },
    },
  }
end)
--]]

-- use snacks.{indent, scope}

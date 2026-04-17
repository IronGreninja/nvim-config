-- Tabline. Sets `:h 'tabline'` to show all listed buffers in a line at the top.
-- Buffers are ordered as they were created. Navigate with `[b` and `]b`.

-- Minimal:
-- Config.later(function() require("mini.tabline").setup() end)

-- More configurable:
Config.later(function()
  Util.plugAdd "akinsho/bufferline.nvim"
  require("bufferline").setup {
    options = {
      indicator = { icon = "▎", style = "icon" },
      numbers = function(opts)
        return string.format("%s|%s", opts.id, opts.raise(opts.ordinal))
      end,
      always_show_bufferline = false,
    },
  }
end)

-- All are installed, 1st is set at startup.
-- others can be set later with `:colo <theme-name>`
local enabledThemes = {
  "kanagawa-paper",
  -- "gruvbox-material",
  -- "onedark",
  -- "base16",
  --
}

local themes = {
  ["onedark"] = {
    "navarasu/onedark.nvim",
    setup = function() require("onedark").setup { style = "warmer" } end,
  },
  ["kanagawa-paper"] = {
    "thesimonho/kanagawa-paper.nvim",
    setup = function() require("kanagawa-paper").setup { cache = true } end,
  },
  ["gruvbox-material"] = {
    "sainnhe/gruvbox-material",
    setup = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_enable_bold = 1
    end,
  },
  ["base16"] = {
    "nvim-mini/mini.nvim",
    setup = function() end,
  },
}

for i, T in ipairs(enabledThemes) do
  if i == 1 then
    Util.plugAdd(themes[T][1])
    themes[T].setup()
    vim.cmd.colorscheme(T)
  else
    Config.later(function()
      Util.plugAdd(themes[T][1])
      themes[T].setup()
    end)
  end
end

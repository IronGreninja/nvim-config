local theme = "kanagawa"

if theme == "onedark" then
  Util.plugAdd "navarasu/onedark.nvim"
  require("onedark").setup {
    style = "warmer",
  }
  vim.cmd.colorscheme "onedark"
end

if theme == "kanagawa" then
  Util.plugAdd "thesimonho/kanagawa-paper.nvim"
  require("kanagawa-paper").setup {
    cache = true,
  }
  vim.cmd.colorscheme "kanagawa-paper"
end

if theme == "gruvbox" then
  Util.plugAdd "sainnhe/gruvbox-material"
  vim.g.gruvbox_material_background = "hard"
  vim.g.gruvbox_material_enable_bold = 1
  vim.cmd.colorscheme "gruvbox-material"
end

local p = nixInfo.settings.base16pallette
if p == nil then return end
require("mini.base16").setup { palette = p }

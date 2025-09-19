local M = {}

M.map = function(mode, key, action, desc)
  vim.keymap.set(mode, key, action, { desc = desc, noremap = true, silent = true })
end

return M

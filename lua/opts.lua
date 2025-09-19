local defIndent = 4
local options = {
  cursorline = true, -- highlight current line
  cursorlineopt = "line", -- highlight only the line no. of current line

  termguicolors = true, -- required for colorschemes & other plugins
  background = "dark", -- set dark as default for colorschemes w/ both light & dark variants

  -- line numbers
  relativenumber = true, -- show relative numbers
  number = true, -- show absolute line no. on cursorline (when relativenumber is on)

  -- hlsearch = true, -- set highlight on search
  mouse = "a", -- mouse support for noobs
  breakindent = true,

  -- tabs & indentation
  tabstop = defIndent, -- spaces for tabs
  shiftwidth = defIndent, -- spaces for indent width when using '>>' or '<<' on existing line
  softtabstop = defIndent,
  expandtab = true, -- expand tabs to spaces
  autoindent = true, -- copy indent from current line when starting new one
  smartindent = false,

  -- Case-insensitive searching UNLESS \C or capital in search
  ignorecase = true,
  smartcase = true,

  signcolumn = "yes",

  -- Decrease update time
  -- updatetime = 250,
  -- timeoutlen = 300,

  undofile = true, -- save undo history

  scrolloff = 10, -- min no. of screen lines above & below the cursor

  list = true,
  listchars = { nbsp = "␣", tab = "» ", trail = "·" },

  inccommand = "split", -- preview substitutions live; as you type

  -- Folds
  fillchars = { eob = " ", fold = " ", foldclose = "", foldopen = "", foldsep = "▕" },
  foldcolumn = "0",
  foldenable = true,
  foldlevel = 99,
  foldlevelstart = 99,

  winborder = "rounded",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.opt.clipboard = "unnamedplus" # sync clipboard b/w os and neovim
-- Syncing clutters the system clipboard with every yank and delete.
-- Instead; selectively copy/paste to/from system clipboard with the '+' register
-- Ex: "+yy   -> yank the line and send to '+' register (system clipboard)
-- Ex: "+p    -> paste from '+' register (system clipboard)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = require("utils").map
wk_specs = {}

map("n", "<leader>N", ":nohl<CR>", "Clear search highlights")

-- Window management
map("n", "<leader>wsv", "<C-w>v", "Window Split Vertically")
map("n", "<leader>wsh", "<C-w>h", "Window Split Horizontally")
map("n", "<leader>wss", "<C-w>r", "Window Swap Splits")
map("n", "<leader>wsx", ":close<CR>", "Window Split Close")
table.insert(wk_specs, { "<leader>w", group = "+Window", icon = " " })
table.insert(wk_specs, { "<leader>ws", group = "+Split", icon = " " })

-- Tabs
map("n", "<leader>to", ":tabnew<CR>", "Open New Tab")
map("n", "<leader>tx", ":tabclose<CR>", "Close Current Tab")
map("n", "<leader>tn", ":tabn<CR>", "Go to next Tab")
map("n", "<leader>tp", ":tabp<CR>", "Go to prev Tab")
map("n", "<leader>tf", ":tabnew %<CR>", "Open current buffer in new Tab")
table.insert(wk_specs, { "<leader>t", group = "+Tab", icon = "󰓩 " })

-- Move b/w windows
map("n", "<C-h>", "<C-w>h", "")
map("n", "<C-j>", "<C-w>j", "")
map("n", "<C-k>", "<C-w>k", "")
map("n", "<C-l>", "<C-w>l", "")
-- Terminal
map("t", "<C-h>", "<cmd>wincmd h<CR>", "")
map("t", "<C-j>", "<cmd>wincmd j<CR>", "")
map("t", "<C-k>", "<cmd>wincmd k<CR>", "")
map("t", "<C-l>", "<cmd>wincmd l<CR>", "")

-- Resize windows
map({ "n", "t" }, "<C-Up>", ":resize -2<CR>", "")
map({ "n", "t" }, "<C-Down>", ":resize +2<CR>", "")
map({ "n", "t" }, "<C-Left>", ":vertical resize -2<CR>", "")
map({ "n", "t" }, "<C-Right>", ":vertical resize -2<CR>", "")

-- Move b/w buffers
map("n", "<BS>", "<cmd>bnext<CR>", "Next buffer")
map("n", "<S-BS>", "<cmd>bprev<CR>", "Prev buffer")

local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })

map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer" })

map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })

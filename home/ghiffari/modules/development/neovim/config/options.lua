local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.smartindent = true
opt.wrap = false
opt.termguicolors = true

opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.splitright = true
opt.splitbelow = true

opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 250
opt.timeoutlen = 400
opt.undofile = true

opt.completeopt = { "menu", "menuone", "noselect" }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

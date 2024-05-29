------------------------------------------------------------ 
-- Global Config

local opt = vim.opt
opt.shell = "/usr/bin/zsh"
opt.termguicolors = true
vim.cmd.colorscheme 'catppuccin'

-- numbers
opt.number = true
opt.relativenumber = true

-- indentation
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
vim.o.breakindent = true
opt.ignorecase = true
opt.autoindent = true
opt.hlsearch = true
opt.cursorline = true
opt.laststatus = 2
opt.ruler = true
opt.syntax = "on"
opt.smartcase = true
opt.ignorecase = true
opt.list = true
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.splitright = true
opt.splitbelow = true
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'


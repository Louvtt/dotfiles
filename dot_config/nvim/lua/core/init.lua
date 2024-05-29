-- By default title is off. Needed for detecting window as neovim instance (sworkstyle)
-- some bits come from https://github.com/DamyrFr/ansible-personal-computer/blob/master/roles/dotfiles/files/init.lua

-- some global configs
vim.cmd "set title"
vim.g.mapleader = ","
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require("core.lazy")
require("core.theme")
require("core.options")
require("core.mappings")
require("core.lsp")
require("core.ui")
require("core.neovide")


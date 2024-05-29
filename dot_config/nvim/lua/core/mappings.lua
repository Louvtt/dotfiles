-- Mappings

local wk = require("which-key")

-- Globals
wk.register({
    ["<leader>"] = {
      ["?"] = { "<cmd>WhichKey<cr>", "which key" },
      f = {
        name = "file", -- optional group name
        f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
        n = { "New File" }, -- just a label. don't create any mapping
        e = "Edit File", -- same as above
        ["1"] = "which_key_ignore",  -- special label to hide it in the popup
      },
      e = { "<cmd>NvimTreeFocus<cr>", "Focus/Open File Tree" },
      t = { "<cmd>split | terminal<cr>", "Open terminal" },
    },
    ["<C-S>"] = { "<cmd>w<cr>", "Save File" },
    ["<C-tab>"] = {"<cmd>tabn<cr>", "Next Tab"},
})

-- lsp
wk.register ({
    ["<space>e"] = { vim.diagnostic.open_float, "List symbols"},
    ["[d"] = { vim.diagnostic.goto_prev, "Go to previous symbol" },
    ["]d"] = { vim.diagnostic.goto_next, "Go to next symbol" },
    ["<space>q"] = { vim.diagnostic.setloclist, "Update diagnostics symbols" },
}, { mode = 'n'})

-- terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

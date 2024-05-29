if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono NF:h8"

    local wk = require("which-key")
    wk.register({
      ["<C-=>"] = { ":lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1,  2.0)<CR>", "Zoom In" },
      ["<C-->"] = { ":lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1,  0.1)<CR>", "Zoom Out" },
      ["<C-0>"] = { ":lua vim.g.neovide_scale_factor = 0.5<CR>", "Zoom Reset" },
    }, {mode = 'n'})
end

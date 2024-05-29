--- Theme 
require("catppuccin").setup({
    flavor = "mocha",
    dim_inactive = { enabled = true },
    transparent_background = false,
    -- from https://github.com/axieax/dotconfig/blob/main/nvim/lua/axie/plugins/themes/catppuccin.lua
    custom_highlights = function(colours)
      local float_bg = colours.base
      local remaps = {
        NormalFloat = { bg = float_bg }, -- NOTE: catppuccin needs a bg colour
        ColorColumn = { link = "CursorLine" },
        SpellBad = { fg = colours.red, style = { "italic", "undercurl" } },
        SpellCap = { fg = colours.red, style = { "italic", "undercurl" } },
        SpellLocal = { fg = colours.red, style = { "italic", "undercurl" } },
        SpellRare = { fg = colours.red, style = { "italic", "undercurl" } },
        CmpItemMenu = { fg = colours.surface2 },
        ["@parameter"] = { fg = colours.flamingo },
        -- VertSplit = { fg = cp.overlay1 },
        -- SpellBad = { fg = cp.maroon },
        -- SpellCap = { fg = cp.peach },
        -- SpellLocal = { fg = cp.lavender },
        -- SpellRare = { fg = cp.teal },
      }

      --[[
      -- NvChad Telescope theme (adapted from https://github.com/olimorris/onedarkpro.nvim/issues/31#issue-1160545258)
      if require("axie.utils.config").nvchad_theme then
        local telescope_results = colours.base
        -- local telescope_prompt = cp.surface0
        local telescope_prompt = "#302D41" -- black3 from original palette
        local fg = colours.surface2
        remaps = vim.tbl_extend("force", remaps, {
          TelescopeBorder = { fg = telescope_results, bg = telescope_results },
          TelescopePromptBorder = { fg = telescope_prompt, bg = telescope_prompt },
          TelescopePromptCounter = { fg = fg },
          TelescopePromptNormal = { fg = fg, bg = telescope_prompt },
          TelescopePromptPrefix = { fg = colours.green, bg = telescope_prompt },
          TelescopePromptTitle = { fg = telescope_prompt, bg = colours.green },
          TelescopePreviewTitle = { fg = telescope_prompt, bg = colours.maroon },
          TelescopeResultsTitle = { fg = telescope_results, bg = telescope_results },
          TelescopeMatching = { fg = colours.green },
          TelescopeNormal = { bg = telescope_results },
          TelescopeSelection = { bg = telescope_prompt },
        })
      end
      --]]
      return remaps
    end,
})

--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '|',
    section_separators = '',
  },
}

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  current_line_blame = true -- Toggle with `:Gitsigns toggle_current_line_blame`
}

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false



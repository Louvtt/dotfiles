-- UI Extensions setup

-- Telescope
require('telescope').setup({
    defaults = {
      prompt_prefix = ' ',
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
      extensions = {
        fzf = { }
      },
      file_ignore_patterns = {
         "node_modules",
         ".venv",
         "build",
         "cmake.+"
      },
    },
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('dotfiles')
require('telescope').load_extension('workfiles')
require('telescope').load_extension('devfiles')
-- Enable telescope fzf native
-- require('telescope').load_extension 'fzf'

-----------------------------------
-- Other plugins
require("Comment").setup()
require("colorizer").setup()

-- Dashboard
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
   [[   ,--,                                                         ]],
   [[,---.'|                                                         ]],
   [[|   | :                                        ___      ___     ]],
   [[:   : |                                      ,--.'|_  ,--.'|_   ]],
   [[|   ' :      ,---.           ,--,            |  | :,' |  | :,'  ]],
   [[;   ; '     '   ,'\        ,'_ /|     .---.  :  : ' : :  : ' :  ]],
   [['   | |__  /   /   |  .--. |  | :   /.  ./|.;__,'  /.;__,'  /   ]],
   [[|   | :.'|.   ; ,. :,'_ /| :  . | .-' . ' ||  |   | |  |   |    ]],
   [['   :    ;'   | |: :|  ' | |  . ./___/ \: |:__,'| : :__,'| :    ]],
   [[|   |  ./ '   | .; :|  | ' |  | |.   \  ' .  '  : |__ '  : |__  ]],
   [[;   : ;   |   :    |:  | : ;  ; | \   \   '  |  | '.'||  | '.'| ]],
   [[|   ,/     \   \  / '  :  `--'   \ \   \     ;  :    ;;  :    ; ]],
   [['---'       `----'  :  ,      .-./  \   \ |  |  ,   / |  ,   /  ]],
   [[                     `--`----'       '---"    ---`-'   ---`-'   ]],
   [[                                                                ]],
}

dashboard.section.footer.val = {
    '',
    "  https://github.com/Louvtt"
}

dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "󰍉  > Find file", ":cd $HOME/Documents | Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "w", "󰏪  > Work"     , ":Telescope workfiles<CR>"),
    dashboard.button( "d", "  > Dotfiles" , ":Telescope dotfiles<CR>"),
    dashboard.button( "p", "  > DevFiles" , ":Telescope devfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "q", "⏻  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    math.randomseed(os.time())
    local fg_color = tostring(math.random(0, 12))
    local hi_setter = "hi AlphaHeader ctermfg="
    vim.cmd(hi_setter .. fg_color)
  end
})

--    project = {
--        enable = true,
--        limit = 8,
--        action = 'Telescope find_files cwd='
--    },
--    shortcut = {
--        { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
--        {
--          icon = '󰍉 ',
--          icon_hl = '@variable',
--          desc = 'Files',
--          group = 'Label',
--          action = 'Telescope find_files',
--          key = 'f',
--        },
--        {
--          icon = '󰏪 ',
--          desc = 'Work',
--          group = 'DiagnosticHint',
--          action = 'Telescope workfiles',
--          key = 'w',
--        },
--        {
--          icon = ' ',
--          desc = 'dotfiles',
--          group = 'Number',
--          action = 'Telescope dotfiles',
--          key = 'd',
--        },
--        {
--            icon = '⏻ ',
--            desc = "Quit Neovim", 
--            group = 'Label',
--            action =  "qa",
--            key = 'q'
--        }
--    },
--}

-- require("drop").setup { theme = "snow" }

local notify = require("notify")
notify.setup({
    render = "compact"
})
vim.notify = notify

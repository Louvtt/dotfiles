return {
    -- catpuccin themes (load first)
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, 
    { "rebelot/kanagawa.nvim" },
    { -- haskell lsp and more
       'mrcjkb/haskell-tools.nvim',
       version = '^3', -- Recommended
       ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    },
    { -- telescope ( fuzzy finder of list ) - file/buffers 
        "nvim-telescope/telescope.nvim", tag = '0.1.5',
        dependencies = { 
            "nvim-lua/plenary.nvim", 
            { 
                'nvim-telescope/telescope-fzf-native.nvim', 
                build = 'make'
            }
        }
    },
    "rcarriga/nvim-notify", -- better notifications
    -- "BurntSushi/ripgrep", -- grep finder for telescope
    "folke/which-key.nvim",
    "ranjithshegde/ccls.nvim", -- c/cpp lsp
    'nvim-lualine/lualine.nvim', -- Fancier statusline
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Add git related info in the signs columns and popups
    { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- Highlight, edit, and navigate code using a fast incremental parsing library
    'nvim-treesitter/nvim-treesitter',
    -- Additional textobjects for treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
    {
        'hrsh7th/nvim-cmp', -- Autocompletion plugin
        event = { "InsertEnter", "CmdlineEnter" },
    },
    'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim's built-in LSP
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words
    'onsails/lspkind-nvim', -- vscode-like pictograms
    'L3MON4D3/LuaSnip', -- Snippets plugin
    'williamboman/nvim-lsp-installer', -- Directly install form nvim
    'numToStr/FTerm.nvim', -- floating terminal 
    { 
        'nvim-tree/nvim-tree.lua',
        config = function()
            require("nvim-tree").setup({
                filters = {
                    dotfiles = false,
                },
            })
        end,
        dependencies = {'nvim-tree/nvim-web-devicons'} 
    },
    -- {
    --     'nvimdev/dashboard-nvim',
    --     event = 'VimEnter',
    --     dependencies = { 'nvim-tree/nvim-web-devicons' }
    -- },
    'fedepujol/move.nvim',
    {
        "folke/drop.nvim",
        event = "VimEnter",
    },
    -- coq setup
    -- {
    --     'whonore/Coqtail', -- for ftdetect, syntax, basic ftplugin, etc
    --     lazy = false,
    --     enabled = false,
    -- },
    -- 'tomtomjhj/vscoq.nvim',
    -- Utils
    {
        'numToStr/Comment.nvim',
        lazy = false,
    },
    { 
        'petertriho/nvim-scrollbar',
        config = function()
            require("scrollbar").setup()
        end
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
          'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
          'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        }
    },
    'NvChad/nvim-colorizer.lua',
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.dashboard'.config)
        end
    }
}

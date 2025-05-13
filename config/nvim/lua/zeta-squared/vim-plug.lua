local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- LSP - lsp.lua
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('WhoIsSethDaniel/mason-tool-installer.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('folke/lazydev.nvim', { ['for'] = 'lua' })

-- Completion - blink.lua/cmp.lua
Plug('saghen/blink.cmp', { ['tag'] = 'v1.*' })
Plug('L3MON4D3/LuaSnip', { ['do'] = 'make install_jsregexp' })
-- Plug('hrsh7th/nvim-cmp')
-- Plug('hrsh7th/cmp-nvim-lsp')
-- Plug('quangnguyen30192/cmp-nvim-ultisnips')
-- Plug('SirVer/ultisnips')
Plug('altermo/ultimate-autopair.nvim')
Plug('windwp/nvim-ts-autotag')

-- Syntax, formatting, and icons - syntax.lua
Plug('nvim-treesitter/nvim-treesitter')
Plug('prettier/vim-prettier')
Plug('echasnovski/mini.icons')
Plug('zeta-squared/sonokai')

-- UI/UX - ui.lua
Plug('ibhagwan/fzf-lua', {['branch'] = 'main'})
Plug('numToStr/FTerm.nvim')
Plug('lervag/vimtex')
Plug('nvim-lualine/lualine.nvim')
Plug('akinsho/bufferline.nvim')
Plug('haya14busa/is.vim')
Plug('nvim-tree/nvim-tree.lua')


-- Debugging - debugging.lua
Plug('mfussenegger/nvim-dap')
Plug('nvim-neotest/nvim-nio')
Plug('rcarriga/nvim-dap-ui')
Plug('mfussenegger/nvim-dap-python')
Plug('theHamsta/nvim-dap-virtual-text')

vim.call('plug#end')

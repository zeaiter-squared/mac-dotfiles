local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- LSP - lsp.lua
Plug('neovim/nvim-lspconfig')
Plug('mason-org/mason.nvim')
Plug('WhoIsSethDaniel/mason-tool-installer.nvim')
Plug('folke/lazydev.nvim', { ['for'] = 'lua' })

-- Completion - blink.lua/cmp.lua
Plug('saghen/blink.cmp', { ['tag'] = 'v1.*' })
Plug('L3MON4D3/LuaSnip', { ['do'] = 'make install_jsregexp' })
Plug('kylechui/nvim-surround')
Plug('altermo/ultimate-autopair.nvim')
Plug('windwp/nvim-ts-autotag')

-- Syntax, formatting, and icons - syntax.lua
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('nvim-treesitter/nvim-treesitter-textobjects')
Plug('echasnovski/mini.icons')
Plug('catppuccin/nvim', { ['tag'] = 'v1.10.0' })

-- UI/UX - ui.lua
Plug('ibhagwan/fzf-lua', {['branch'] = 'main'})
Plug('lervag/vimtex')
Plug('nvim-lualine/lualine.nvim')
Plug('akinsho/bufferline.nvim')
Plug('haya14busa/is.vim')
Plug('stevearc/oil.nvim')
Plug('folke/todo-comments.nvim')
Plug('tpope/vim-fugitive')

-- Debugging - debugging.lua
Plug('mfussenegger/nvim-dap')
Plug('nvim-neotest/nvim-nio')
Plug('rcarriga/nvim-dap-ui')
Plug('leoluz/nvim-dap-go')
Plug('mfussenegger/nvim-dap-python')

vim.call('plug#end')

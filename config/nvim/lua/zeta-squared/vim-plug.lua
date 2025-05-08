local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Functionality
Plug('nvim-treesitter/nvim-treesitter')
Plug('nvim-treesitter/playground')
Plug('lervag/vimtex')
Plug('vim-airline/vim-airline')
Plug('tpope/vim-fugitive')
Plug('haya14busa/is.vim')
Plug('SirVer/ultisnips')
Plug('ibhagwan/fzf-lua', {['branch'] = 'main'})
Plug('echasnovski/mini.icons') -- dependency for fzf-lua
Plug('williamboman/mason.nvim')
Plug('WhoIsSethDaniel/mason-tool-installer.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('onsails/lspkind.nvim')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('quangnguyen30192/cmp-nvim-ultisnips')
Plug('altermo/ultimate-autopair.nvim')
Plug('windwp/nvim-ts-autotag')
Plug('numToStr/FTerm.nvim')
Plug('prettier/vim-prettier')
Plug('mfussenegger/nvim-dap')
Plug('nvim-neotest/nvim-nio')
Plug('rcarriga/nvim-dap-ui')
Plug('mfussenegger/nvim-dap-python')
Plug('theHamsta/nvim-dap-virtual-text')

-- Colours
Plug('zeta-squared/sonokai')

vim.call('plug#end')

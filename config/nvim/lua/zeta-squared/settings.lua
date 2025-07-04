-- Disabled netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set <leader> to <Space>
vim.g.mapleader = ' '

-- Set to true if nerd font is installed
vim.g.have_nerd_font = true

-- Set cursor to be old block style in insert mode
vim.opt.guicursor = ''

-- Set all windows to have rounded borders
vim.opt.winborder = 'rounded' -- all floating windows have rounded border

-- Show line number of current line instead of relative line number
vim.opt.nu = true

-- Show relative numbers in the margin
vim.opt.relativenumber = true

-- Default tab behaviour and text width
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 110
vim.opt.expandtab = true

-- Use smart indent to indent newlines - helpful with maintaining
-- indents from previous line
vim.opt.smartindent = true

-- Highlight search and show all highlights incrementally as typing
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Enable 24 bit colour in terminal
vim.opt.termguicolors = true

-- Enable sign column to show diagnostic symbols
vim.opt.signcolumn = 'yes'

-- Connect to system clipboard if available
vim.opt.clipboard = 'unnamed'

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Timeout for combination keymaps, e.g. <leader>l
vim.opt.timeoutlen = 1000

-- Default direction for splitting horizontally and vertically
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Autocommand to autoread a file when either changing focus or entering a buffer
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = '*',
})

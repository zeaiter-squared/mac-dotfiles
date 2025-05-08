vim.g.python3_host_prog = os.getenv('HOME') .. '/.local/share/nvim/nvim_venv/bin/python'
vim.g.mapleader = ' '

vim.opt.guicursor = ''
vim.opt.winborder = 'rounded' -- all floating windows have rounded border

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 110
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = 'no'

vim.opt.clipboard = 'unnamed'
vim.opt.mouse = 'a'
vim.opt.timeoutlen = 1000
vim.opt.splitright = true
vim.opt.splitbelow = true

-- From V0.11 diagnostics are opt in. We opt in here.
vim.diagnostic.config({ virtual_text = true })

-- Treesitter Config
require('nvim-treesitter.configs').setup {
	ensure_installed = {"c", "java", "javascript", "typescript", "tsx", "vim",
		"python", "lua", "html", "json", "latex", "css", "yaml", "bash"},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
}

-- Prettier Config
vim.g['prettier#autoformat'] = 1
vim.g['prettier#autoformat_require_pragma'] = 0

-- Mini Config
local mini = require('mini.icons')

mini.setup({
    extension = {
        js = {
            glyph = '',
        },
        cjs = {
            glyph = '',
        },
        mjs = {
            glyph = '',
        },
        ts = {
            glyph = '',
        },
        sass = {
            glyph = '',
        },
        scss = {
            glyph = '',
        },
    }
})

-- Syntax Highlighting Config
vim.g.sonokai_transparent_background = 1
vim.g.sonokai_style = 'zeta-squared'
vim.cmd.colorscheme('sonokai')

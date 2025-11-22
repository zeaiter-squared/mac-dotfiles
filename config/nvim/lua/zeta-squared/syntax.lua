-- Treesitter Config
require('nvim-treesitter.configs').setup {
	ensure_installed = {"c", "java", "javascript", "typescript", "tsx", "vim",
		"python", "lua", "html", "json", "jsonc", "latex", "css", "scss", "yaml",
        "bash", "go", "make", "dockerfile", "gitignore"},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ar"] = "@return.outer",
                ["ir"] = "@return.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["ac"] = "@call.outer",
                ["ic"] = "@call.inner",
            }
        }
    }
}

-- Mini Config
local mini = require('mini.icons')
mini.mock_nvim_web_devicons()

mini.setup({
    extension = {
        js = { glyph = '' },
        cjs = { glyph = '' },
        mjs = { glyph = '' },
        ts = { glyph = '' },
        sass = { glyph = '' },
        scss = { glyph = '' },
        go = { glyph = '' },
        goaccess = { glyph = '' },
        godoc = { glyph = '' },
        gomod = { glyph = '' },
        gosum = { glyph = '' },
        gowork = { glyph = '' },
    }
})

-- Syntax Highlighting Config
-- vim.g.sonokai_transparent_background = 1
-- vim.g.sonokai_style = 'zeta-squared'
-- vim.cmd.colorscheme('sonokai')
local cat_config = require('zeta-squared.cat_config')
require('catppuccin').setup(cat_config)
vim.cmd.colorscheme('catppuccin-macchiato')

-- Folding
vim.wo.foldlevel = 3
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldtext = ''

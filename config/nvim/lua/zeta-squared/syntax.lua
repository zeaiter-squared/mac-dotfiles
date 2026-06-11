-- Treesitter Config
require('nvim-treesitter.configs').setup {
	ensure_installed = {"c", "java", "javascript", "typescript", "tsx", "vim",
		"python", "lua", "html", "json", "jsonc", "css", "scss", "yaml",
        "bash", "go", "make", "dockerfile", "gitignore"},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
    textobjects = {
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]of"] = "@function.outer",
                ["]if"] = "@function.inner",
                ["]or"] = "@return.outer",
                ["]ir"] = "@return.inner",
                ["]ob"] = "@block.outer",
                ["]ib"] = "@block.inner",
                ["]os"] = "@call.outer",
                ["]is"] = "@call.inner",
                ["]oc"] = "@conditional.outer",
                ["]ic"] = "@conditional.inner",
                ["]ol"] = "@loop.outer",
                ["]il"] = "@loop.inner",
                ["]z"] = "@fold",
            },
            goto_previous_start = {
                ["[of"] = "@function.outer",
                ["[if"] = "@function.inner",
                ["[or"] = "@return.outer",
                ["[ir"] = "@return.inner",
                ["[ob"] = "@block.outer",
                ["[ib"] = "@block.inner",
                ["[os"] = "@call.outer",
                ["[is"] = "@call.inner",
                ["[oc"] = "@conditional.outer",
                ["[ic"] = "@conditional.inner",
                ["[ol"] = "@loop.outer",
                ["[il"] = "@loop.inner",
                ["[z"] = "@fold",
            },
            goto_next_end = {
                ["}of"] = "@function.outer",
                ["}if"] = "@function.inner",
                ["}or"] = "@return.outer",
                ["}ir"] = "@return.inner",
                ["}ob"] = "@block.outer",
                ["}ib"] = "@block.inner",
                ["}os"] = "@call.outer",
                ["}is"] = "@call.inner",
                ["}oc"] = "@conditional.outer",
                ["}ic"] = "@conditional.inner",
                ["}ol"] = "@loop.outer",
                ["}il"] = "@loop.inner",
                ["}z"] = "@fold",
            },
            goto_previous_end = {
                ["{of"] = "@function.outer",
                ["{if"] = "@function.inner",
                ["{or"] = "@return.outer",
                ["{ir"] = "@return.inner",
                ["{ob"] = "@block.outer",
                ["{ib"] = "@block.inner",
                ["{os"] = "@call.outer",
                ["{is"] = "@call.inner",
                ["{oc"] = "@conditional.outer",
                ["{ic"] = "@conditional.inner",
                ["{ol"] = "@loop.outer",
                ["{il"] = "@loop.inner",
                ["{z"] = "@fold",
            },
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["of"] = "@function.outer",
                ["if"] = "@function.inner",
                ["or"] = "@return.outer",
                ["ir"] = "@return.inner",
                ["ob"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["os"] = "@call.outer",
                ["is"] = "@call.inner",
                ["oc"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",
                ["ol"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["z"] = "@fold",
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

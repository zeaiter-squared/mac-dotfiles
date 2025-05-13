-- Fzf-lua Config
local fzflua = require('fzf-lua')

fzflua.setup({
	fzf_opts = {
		['--layout'] = 'default',
	},
	keymap = {
		builtin = {
			true,
			-- ["<C-k>"] = "preview-page-up",
			-- ["<C-j>"] = "preview-page-down",
			-- ["<C-i>"] = "preview-up",
			-- ["<C-u>"] = "preview-down",
            -- ["<C-[>"] = "hide",
			["<C-u>"] = "preview-page-up",
			["<C-d>"] = "preview-page-down",
			["<C-y>"] = "preview-up",
			["<C-e>"] = "preview-down",
            ["<C-[>"] = "hide",
		},
	},
	files = {
		rg_opts = [[--color=never --files --hidden --follow -g "!.git" -g "!node_modules" -g "!venv" -g "!__pycache__"]],
	},
	grep = {
		rg_opts = [[-g "!.git" -g "!node_modules" -g "!venv" -g "!__pycache__" --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e]],
	},
})

vim.keymap.set('n', '<leader>pf', fzflua.files)
vim.keymap.set('n', '<leader>pb', fzflua.buffers )
vim.keymap.set('n', '<leader>pt', fzflua.tabs)
vim.keymap.set('n', '<leader>pr', fzflua.grep_visual)
vim.keymap.set('n', '<leader>pq', fzflua.lines)
vim.keymap.set('n', '<leader>pl', fzflua.blines)
vim.keymap.set('n', '<leader>pc', fzflua.git_commits)
vim.keymap.set('n', '<leader>pg', fzflua.git_status)

-- FTerm Config
local fterm = require('FTerm')

local term1 = fterm:new({
    cmd = 'bash',
    border = 'rounded',
    dimensions = {
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.2,
    },
})

local term2 = fterm:new({
    cmd = 'bash',
    border = 'rounded',
    dimensions = {
        height = 0.96,
        width = 0.5,
        x = 0.01,
        y = 0.2,
    },
})

local term3 = fterm:new({
    cmd = 'bash',
    border = 'rounded',
    dimensions = {
        height = 0.96,
        width = 0.5,
        x = 1.0,
        y = 0.2,
    }
})

local lazyterm = fterm:new({
    ft = 'fterm_lazygit',
    cmd = 'lazygit',
    border = 'rounded',
    dimensions = {
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.2,
    },
})

vim.keymap.set({'n', 't'}, '<leader>dt', function() term1:toggle() end)
vim.keymap.set({'n', 't'}, '<C-\\>', function() term2: toggle() end)
vim.keymap.set({'n', 't'}, '<A-\\>', function() term3:toggle() end)
vim.keymap.set({'n', 't'}, '<leader>lt', function() lazyterm:toggle() end)

-- Vimtex Config
vim.g.vimtex_view_method = 'zathura'

-- Lualine Config
require('lualine').setup({})

-- Bufferline Config
require('bufferline').setup({
    options = {
        mode = 'tabs',
        numbers = 'ordinal',
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
        },
    }
})

-- Nvim-tree Config

local api = require('nvim-tree.api')
vim.keymap.set({'n', 'v'}, '<leader>pd', api.tree.toggle)

local function on_attach(bufnr)
    api.config.mappings.default_on_attach(bufnr)

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait =true }
    end

    vim.keymap.set("n", "/", function()
		local fzf = require("fzf-lua")
		fzf.fzf_exec("fd -H -t f -E '.git/'", {
			prompt = ":",
			fzf_opts = { ["--padding"] = "5%,5%,15%,5%" },
			winopts = {
				height = 0.15,
				width = vim.fn.winwidth(0) - 2,
				row = 1,
				col = 1,
				title = " search tree ",
			},
			actions = {
				["default"] = {
					fn = function(selected)
						api.tree.find_file(selected[1])
					end,
					desc = "fuzzy find in tree",
				},
			},
		})
	end, opts("fuzzy find in tree"))
end

require('nvim-tree').setup({
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    sort = {
        sorter = "extension",
    },
    view = { adaptive_size = true, side = "right" },
    update_focused_file = { enable = true },
    on_attach = on_attach,

    ---markers
    renderer = {
        indent_markers = { enable = true },
        indent_width = 2,
        special_files = {},
    },
    diagnostics = { enable = false },
    git = { enable = false },
    filters = { dotfiles = true, custom = { "^__pycache__" } },
})

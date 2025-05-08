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
			["<C-k>"] = "preview-page-up",
			["<C-j>"] = "preview-page-down",
			["<C-i>"] = "preview-up",
			["<C-u>"] = "preview-down",
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

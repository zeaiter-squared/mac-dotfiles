-- Fzf-lua Config
local fzflua = require('fzf-lua')
local actions = require('fzf-lua').actions

fzflua.setup({
    fzf_colors = true,
	fzf_opts = {
		['--layout'] = 'default',
	},
	keymap = {
		builtin = {
			true,
			["<C-u>"] = "preview-page-up",
			["<C-d>"] = "preview-page-down",
			["<C-y>"] = "preview-up",
			["<C-e>"] = "preview-down",
            ["<C-[>"] = "hide",
		},
	},
	files = {
        fd_opts = [[--color=never --hidden --follow --type file --type symlink --exclude ".git" --exclude "node_modules" --exclude "venv" --exclude "__pycache__"]],
	},
	grep = {
		rg_opts = [[-g "!.git" -g "!node_modules" -g "!venv" -g "!__pycache__" --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e]],
	},
    actions = {
        files = {
            ["enter"] = actions.file_edit_or_qf,
            ["alt-q"] = actions.file_sel_to_qf,
            ["alt-Q"] = actions.file_sel_to_ll,
            ["alt-i"] = actions.toggle_ignore,
            ["alt-h"] = actions.toggle_hidden,
            ["alt-f"] = actions.toggle_follow,
            ['ctrl-h'] = actions.file_split,
            ['ctrl-s'] = actions.file_vsplit,
            ['ctrl-t'] = function(...)
                actions.file_tabedit(...)
                vim.cmd('$tabmove')
            end,
        },
    },
})

vim.keymap.set('n', '<leader>pf', fzflua.files)
vim.keymap.set('n', '<leader>pb', fzflua.buffers)
vim.keymap.set('n', '<leader>pt', fzflua.tabs)
vim.keymap.set('n', '<leader>pg', fzflua.grep_project)
vim.keymap.set('n', '<leader>pq', fzflua.lines)
vim.keymap.set('n', '<leader>pl', fzflua.blines)
-- Set FzfLua as the default ui select for neovim
fzflua.register_ui_select()

-- Vimtex Config
vim.g.vimtex_view_method = 'zathura'

-- Set transparent background to false for lualine and bufferline
local cat_config = require('zeta-squared.cat_config')
local cat_colors = cat_config.color_overrides.macchiato
cat_config.transparent_background = false
require('catppuccin').setup(cat_config)

-- Lualine Config
local function my_location()
    local lines = vim.fn.line('$')
    local line = vim.fn.line('.')
    local col = vim.fn.charcol('.')

    return string.format('%3d/%d:%-2d', line, lines, col)
end

local theme = require('lualine.themes.catppuccin')
theme.normal.c.bg = cat_colors.mantle
theme.inactive.a = { fg = cat_colors.subtext0, bg = cat_colors.mantle }
theme.inactive.b = { fg = cat_colors.subtext0, bg = cat_colors.mantle }
theme.inactive.c = { fg = cat_colors.subtext0, bg = cat_colors.mantle }
theme.inactive.x = { fg = cat_colors.subtext0, bg = cat_colors.mantle }

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = require('lualine.themes.catppuccin'),
        -- component_separators = { left = '', right = ''},
        component_separators = { left = '', right  = '' },
        -- section_separators = { left = '', right = ''},
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            'branch',
            'diff',
            {
                'diagnostics',
                diagnostics_color = {
                    error = 'LualineDiagnosticSignError',
                    warn = 'LualineDiagnosticSignWarn',
                    info = 'LualineDiagnosticSignInfo',
                    hint = 'LualineDiagnosticSignHint',
                },
            },
        },
        lualine_c = {
            {
                'filename',
                path = 1,
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { my_location }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                'filename',
                path = 1,
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
})

-- Bufferline Config

require('bufferline').setup({
    options = {
        mode = 'tabs',
        numbers = 'ordinal',
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
        },
    },
    highlights = require('catppuccin.groups.integrations.bufferline').get({
        custom = {
            macchiato = {
                duplicate = { fg = cat_colors.subtext0, bg = cat_colors.mantle },
            },
        },
    })
})

-- Oil Config
local oil = require('oil')
oil.setup()
vim.keymap.set("n", "<leader>pd", oil.toggle_float)

-- Todo Config
require('todo-comments').setup({
    search = {
        command = 'rg',
        args = {
            '--color=always',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--max-columns=4096',
            '-g "!.git"',
            '-g "!nmode_modules"',
            '-g "!venv"',
            '-g "!__pycache"',
            '-e',
        },
    },
})

local todo_fzf = require('todo-comments.fzf')
vim.keymap.set('n', '<leader>pc', function() todo_fzf.todo({ prompt = '>' }) end)

-- vim-fugitive Config
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')

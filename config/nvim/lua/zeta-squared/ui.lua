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
    actions = {
        files = {
            true,
            ['enter'] = actions.file_edit,
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
vim.keymap.set('n', '<leader>pg', fzflua.live_grep)
vim.keymap.set('n', '<leader>pq', fzflua.lines)
vim.keymap.set('n', '<leader>pl', fzflua.blines)

-- FTerm Config
local fterm = require('FTerm')

local term1 = fterm:new({
    cmd = 'bash',
    border = 'rounded',
    dimensions = {
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.3,
    },
})

local term2 = fterm:new({
    cmd = 'bash',
    border = 'rounded',
    dimensions = {
        height = 0.95,
        width = 0.5,
        x = 0.01,
        y = 0.3,
    },
})

local term3 = fterm:new({
    cmd = 'bash',
    border = 'rounded',
    dimensions = {
        height = 0.95,
        width = 0.5,
        x = 1.0,
        y = 0.3,
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
        y = 0.3,
    },
})

vim.keymap.set({'n', 't'}, '<leader>dt', function() term1:toggle() end)
vim.keymap.set({'n', 't'}, '<C-\\>', function() term2: toggle() end)
vim.keymap.set({'n', 't'}, '<A-\\>', function() term3:toggle() end)
vim.keymap.set({'n', 't'}, '<leader>lg', function() lazyterm:toggle() end)

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
            }
        },
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = { my_location }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
})

-- Bufferline Config
--
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

-- Nvim-tree Config
local api = require('nvim-tree.api')
vim.keymap.set({'n', 'v'}, '<leader>pd', api.tree.toggle)

local function on_attach(bufnr)
    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait =true }
    end

    vim.keymap.set("n", "/", function()
		local fzf = require("fzf-lua")
		fzf.fzf_exec("fd -H -t f -E '.git/'", {
			prompt = ":",
			fzf_opts = { ["--padding"] = "5%,5%,15%,5%" },
			winopts = {
				height = 0.20,
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

    vim.keymap.set("n", "<C-o>",          api.tree.change_root_to_node,       opts("CD"))
    -- vim.keymap.set("n", "<C-e>",          api.node.open.replace_tree_buffer,  opts("Open: In Place"))
    vim.keymap.set("n", "<C-k>",          api.node.show_info_popup,           opts("Info"))
    vim.keymap.set("n", "<C-r>",          api.fs.rename_sub,                  opts("Rename: Omit Filename"))
    vim.keymap.set("n", "<C-t>",          api.node.open.tab,                  opts("Open: New Tab"))
    vim.keymap.set("n", "<C-v>",          api.node.open.vertical,             opts("Open: Vertical Split"))
    vim.keymap.set("n", "<C-s>",          api.node.open.horizontal,           opts("Open: Horizontal Split"))
    vim.keymap.set("n", "<BS>",           api.node.navigate.parent_close,     opts("Close Directory"))
    vim.keymap.set("n", "<CR>",           api.node.open.edit,                 opts("Open"))
    vim.keymap.set("n", "<Tab>",          api.node.open.preview,              opts("Open Preview"))
    vim.keymap.set("n", ">",              api.node.navigate.sibling.next,     opts("Next Sibling"))
    vim.keymap.set("n", "<",              api.node.navigate.sibling.prev,     opts("Previous Sibling"))
    vim.keymap.set("n", ".",              api.node.run.cmd,                   opts("Run Command"))
    vim.keymap.set("n", "-",              api.tree.change_root_to_parent,     opts("Up"))
    vim.keymap.set("n", "a",              api.fs.create,                      opts("Create File Or Directory"))
    vim.keymap.set("n", "bd",             api.marks.bulk.delete,              opts("Delete Bookmarked"))
    vim.keymap.set("n", "bt",             api.marks.bulk.trash,               opts("Trash Bookmarked"))
    vim.keymap.set("n", "bmv",            api.marks.bulk.move,                opts("Move Bookmarked"))
    vim.keymap.set("n", "B",              api.tree.toggle_no_buffer_filter,   opts("Toggle Filter: No Buffer"))
    vim.keymap.set("n", "c",              api.fs.copy.node,                   opts("Copy"))
    vim.keymap.set("n", "C",              api.tree.toggle_git_clean_filter,   opts("Toggle Filter: Git Clean"))
    vim.keymap.set("n", "[c",             api.node.navigate.git.prev,         opts("Prev Git"))
    vim.keymap.set("n", "]c",             api.node.navigate.git.next,         opts("Next Git"))
    vim.keymap.set("n", "d",              api.fs.remove,                      opts("Delete"))
    vim.keymap.set("n", "D",              api.fs.trash,                       opts("Trash"))
    vim.keymap.set("n", "E",              api.tree.expand_all,                opts("Expand All"))
    vim.keymap.set("n", "e",              api.fs.rename_basename,             opts("Rename: Basename"))
    vim.keymap.set("n", "]e",             api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
    vim.keymap.set("n", "[e",             api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
    vim.keymap.set("n", "F",              api.live_filter.clear,              opts("Live Filter: Clear"))
    vim.keymap.set("n", "f",              api.live_filter.start,              opts("Live Filter: Start"))
    vim.keymap.set("n", "g?",             api.tree.toggle_help,               opts("Help"))
    vim.keymap.set("n", "gy",             api.fs.copy.absolute_path,          opts("Copy Absolute Path"))
    vim.keymap.set("n", "ge",             api.fs.copy.basename,               opts("Copy Basename"))
    vim.keymap.set("n", "H",              api.tree.toggle_hidden_filter,      opts("Toggle Filter: Dotfiles"))
    vim.keymap.set("n", "I",              api.tree.toggle_gitignore_filter,   opts("Toggle Filter: Git Ignore"))
    vim.keymap.set("n", "J",              api.node.navigate.sibling.last,     opts("Last Sibling"))
    vim.keymap.set("n", "K",              api.node.navigate.sibling.first,    opts("First Sibling"))
    vim.keymap.set("n", "L",              api.node.open.toggle_group_empty,   opts("Toggle Group Empty"))
    vim.keymap.set("n", "M",              api.tree.toggle_no_bookmark_filter, opts("Toggle Filter: No Bookmark"))
    vim.keymap.set("n", "m",              api.marks.toggle,                   opts("Toggle Bookmark"))
    vim.keymap.set("n", "o",              api.node.open.edit,                 opts("Open"))
    vim.keymap.set("n", "O",              api.node.navigate.parent_close,     opts("close Directory"))
    -- vim.keymap.set("n", "O",              api.node.open.no_window_picker,     opts("Open: No Window Picker"))
    vim.keymap.set("n", "p",              api.fs.paste,                       opts("Paste"))
    vim.keymap.set("n", "P",              api.node.navigate.parent,           opts("Parent Directory"))
    vim.keymap.set("n", "q",              api.tree.close,                     opts("Close"))
    vim.keymap.set("n", "r",              api.fs.rename_full,                 opts("Rename: Full Path"))
    -- vim.keymap.set("n", "r",              api.fs.rename,                      opts("Rename"))
    vim.keymap.set("n", "R",              api.tree.reload,                    opts("Refresh"))
    vim.keymap.set("n", "s",              api.node.run.system,                opts("Run System"))
    vim.keymap.set("n", "S",              api.tree.search_node,               opts("Search"))
    -- vim.keymap.set("n", "u",              api.fs.rename_full,                 opts("Rename: Full Path"))
    vim.keymap.set("n", "U",              api.tree.toggle_custom_filter,      opts("Toggle Filter: Hidden"))
    vim.keymap.set("n", "W",              api.tree.collapse_all,              opts("Collapse"))
    vim.keymap.set("n", "x",              api.fs.cut,                         opts("Cut"))
    vim.keymap.set("n", "y",              api.fs.copy.filename,               opts("Copy Name"))
    vim.keymap.set("n", "Y",              api.fs.copy.relative_path,          opts("Copy Relative Path"))
    vim.keymap.set("n", "<2-LeftMouse>",  api.node.open.edit,                 opts("Open"))
    vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node,       opts("CD"))
end

require('nvim-tree').setup({
    actions = {
        open_file = {
            quit_on_open = true,
            window_picker = {
                enable = false,
            },
        },
    },
    sort = {
        sorter = "extension",
    },
    view = {
        adaptive_size = true,
        side = 'right',
        number = true,
        relativenumber = true,
        signcolumn = 'no',
    },
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

require('todo-comments').setup({})

local todo_fzf = require('todo-comments.fzf')
vim.keymap.set('n', '<leader>pc', function() todo_fzf.todo({ prompt = '>' }) end)

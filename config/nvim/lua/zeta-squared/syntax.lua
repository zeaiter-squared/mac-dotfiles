-- Treesitter Config

-- Parsers to install
require('nvim-treesitter').install({
    'c', 'java', 'javascript', 'typescript', 'tsx', 'vim', 'python', 'lua', 'html', 'json',
    'css', 'scss', 'yaml', 'bash', 'go', 'make', 'dockerfile', 'gitignore'
})

-- Autocmd to load on filetype
vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        'c', 'java', 'javascript', 'typescript', 'typescriptreact', 'vim', 'python', 'lua',
        'html', 'json', 'css', 'scss', 'yaml', 'sh', 'go', 'make', 'dockerfile', 'gitignore'
    },
    callback = function()
        -- Highlighting
        vim.treesitter.start()

        -- Indenting
        vim.bo.indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'

        -- Folding
        vim.wo[0][0].foldlevel = 3
        vim.wo[0][0].foldmethod = 'expr'
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldtext = ''
    end,
})

require('nvim-treesitter-textobjects').setup({
    move = {
        set_jumps = true,
    },
})

local move = require('nvim-treesitter-textobjects.move')
local moveto_next_start = function (keybind, query_string)
    vim.keymap.set({'n', 'x', 'o'}, keybind, function ()
        move.goto_next_start(query_string, 'textobjects')
    end)
end
local moveto_previous_start = function (keybind, query_string)
    vim.keymap.set({'n', 'x', 'o'}, keybind, function ()
        move.goto_previous_start(query_string, 'textobjects')
    end)
end

-- Move to next start keymaps
moveto_next_start(']of', '@function.outer')
moveto_next_start(']if', '@function.inner')
moveto_next_start(']or', '@return.outer')
moveto_next_start(']ir', '@return.inner')
moveto_next_start(']ob', '@block.outer')
moveto_next_start(']ib', '@block.inner')
moveto_next_start(']os', '@call.outer')
moveto_next_start(']is', '@call.inner')
moveto_next_start(']oc', '@conditional.outer')
moveto_next_start(']ic', '@conditional.inner')
moveto_next_start(']ol', '@loop.outer')
moveto_next_start(']il', '@loop.inner')
moveto_next_start(']z', '@fold')
moveto_next_start(']v', '@assignment.lhs')

-- Move to previous start keymaps
moveto_previous_start('[of', '@function.outer')
moveto_previous_start('[if', '@function.inner')
moveto_previous_start('[or', '@return.outer')
moveto_previous_start('[ir', '@return.inner')
moveto_previous_start('[ob', '@block.outer')
moveto_previous_start('[ib', '@block.inner')
moveto_previous_start('[os', '@call.outer')
moveto_previous_start('[is', '@call.inner')
moveto_previous_start('[oc', '@conditional.outer')
moveto_previous_start('[ic', '@conditional.inner')
moveto_previous_start('[ol', '@loop.outer')
moveto_previous_start('[il', '@loop.inner')
moveto_previous_start('[z', '@fold')
moveto_previous_start('[v', '@assignment.lhs')

local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')

-- Repeat movement similar to default vim way with ; (]]) and ,([[)
vim.keymap.set({'n', 'x', 'o'}, ']]', ts_repeat_move.repeat_last_move)
vim.keymap.set({'n', 'x', 'o'}, '[[', ts_repeat_move.repeat_last_move_opposite)

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
local cat_config = require('zeta-squared.cat_config')
require('catppuccin').setup(cat_config)
vim.cmd.colorscheme('catppuccin-macchiato')


-- @deprecated moved to main branch config above
-- require('nvim-treesitter.configs').setup {
-- 	ensure_installed = {"c", "java", "javascript", "typescript", "tsx", "vim",
-- 		"python", "lua", "html", "json", "jsonc", "css", "scss", "yaml",
--         "bash", "go", "make", "dockerfile", "gitignore"},
-- 	highlight = {
-- 		enable = true,
-- 		additional_vim_regex_highlighting = false,
-- 	},
-- 	indent = {
-- 		enable = true,
-- 	},
--     textobjects = {
--         move = {
--             enable = true,
--             set_jumps = true,
--             goto_next_start = {
--                 ["]v"] = "@assignment.lhs",
--                 ["]of"] = "@function.outer",
--                 ["]if"] = "@function.inner",
--                 ["]or"] = "@return.outer",
--                 ["]ir"] = "@return.inner",
--                 ["]ob"] = "@block.outer",
--                 ["]ib"] = "@block.inner",
--                 ["]os"] = "@call.outer",
--                 ["]is"] = "@call.inner",
--                 ["]oc"] = "@conditional.outer",
--                 ["]ic"] = "@conditional.inner",
--                 ["]ol"] = "@loop.outer",
--                 ["]il"] = "@loop.inner",
--                 ["]z"] = "@fold",
--             },
--             goto_previous_start = {
--                 ["[v"] = "@assignment.lhs",
--                 ["[of"] = "@function.outer",
--                 ["[if"] = "@function.inner",
--                 ["[or"] = "@return.outer",
--                 ["[ir"] = "@return.inner",
--                 ["[ob"] = "@block.outer",
--                 ["[ib"] = "@block.inner",
--                 ["[os"] = "@call.outer",
--                 ["[is"] = "@call.inner",
--                 ["[oc"] = "@conditional.outer",
--                 ["[ic"] = "@conditional.inner",
--                 ["[ol"] = "@loop.outer",
--                 ["[il"] = "@loop.inner",
--                 ["[z"] = "@fold",
--             },
--             goto_next_end = {
--                 ["}of"] = "@function.outer",
--                 ["}if"] = "@function.inner",
--                 ["}or"] = "@return.outer",
--                 ["}ir"] = "@return.inner",
--                 ["}ob"] = "@block.outer",
--                 ["}ib"] = "@block.inner",
--                 ["}os"] = "@call.outer",
--                 ["}is"] = "@call.inner",
--                 ["}oc"] = "@conditional.outer",
--                 ["}ic"] = "@conditional.inner",
--                 ["}ol"] = "@loop.outer",
--                 ["}il"] = "@loop.inner",
--                 ["}z"] = "@fold",
--             },
--             goto_previous_end = {
--                 ["{of"] = "@function.outer",
--                 ["{if"] = "@function.inner",
--                 ["{or"] = "@return.outer",
--                 ["{ir"] = "@return.inner",
--                 ["{ob"] = "@block.outer",
--                 ["{ib"] = "@block.inner",
--                 ["{os"] = "@call.outer",
--                 ["{is"] = "@call.inner",
--                 ["{oc"] = "@conditional.outer",
--                 ["{ic"] = "@conditional.inner",
--                 ["{ol"] = "@loop.outer",
--                 ["{il"] = "@loop.inner",
--                 ["{z"] = "@fold",
--             },
--         },
--         select = {
--             enable = true,
--             lookahead = true,
--             keymaps = {
--                 ["of"] = "@function.outer",
--                 ["if"] = "@function.inner",
--                 ["or"] = "@return.outer",
--                 ["ir"] = "@return.inner",
--                 ["ob"] = "@block.outer",
--                 ["ib"] = "@block.inner",
--                 ["os"] = "@call.outer",
--                 ["is"] = "@call.inner",
--                 ["oc"] = "@conditional.outer",
--                 ["ic"] = "@conditional.inner",
--                 ["ol"] = "@loop.outer",
--                 ["il"] = "@loop.inner",
--                 ["z"] = "@fold",
--             }
--         }
--     }
-- }

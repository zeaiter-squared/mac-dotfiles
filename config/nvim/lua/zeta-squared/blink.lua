-- Snippets
local ls = require('luasnip')

vim.keymap.set('i', '<C-k>', function() ls.expand() end, { silent = true })
vim.keymap.set({'i', 's'}, '<C-l>', function() ls.jump(1) end, { silent = true })
vim.keymap.set({'i', 's'}, '<C-j>', function() ls.jump(-1) end, { silent = true })

require('luasnip.loaders.from_snipmate').lazy_load()

-- Auto completion for html tags
require('nvim-ts-autotag').setup({})

-- Auto completion for brackets
local ua = require('ultimate-autopair')
local configs = {ua.extend_default({
    fastwarp = {
        rmap = '<A-a>',
        rcmap = '<A-a>',
    },
    tabout = {
        enable = true,
        map = '<A-t>',
        cmap = '<A-t>',
    },
})}
ua.init(configs)

-- Auto completion  engine
require('blink.cmp').setup({
    keymap = {
        preset = 'default',
        ['<C-n>'] = {
            "select_next",
            "show",
            "fallback",
        },
        ['<Tab>'] = {
            "select_and_accept",
            "fallback",
        },
    },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
    },
    snippets = {
        preset = 'luasnip',
    },
    sources = {
        default = { 'lsp', 'path', 'buffer', 'snippets' },
        per_filetype = {
            lua = { inherit_defaults = true, 'lazydev' },
        },
        providers = {
            lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
    },
    completion = {
        menu = {
            draw = {
                treesitter = { 'lsp' },
                columns = {
                    { 'label', 'label_description', gap = 1 },
                    { 'kind_icon', 'kind' , gap = 1},
                },
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                            return kind_icon
                        end,
                        -- (optional) use highlights from mini.icons
                        highlight = function(ctx)
                            local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                            return hl
                        end,
                    },
                    kind = {
                        -- (optional) use highlights from mini.icons
                        highlight = function(ctx)
                            local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                            return hl
                        end,
                    },
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 250,
            treesitter_highlighting = true,
        },
        accept = {
            auto_brackets = {
                enabled = false,
            },
        },
    },
    fuzzy = {
        implementation = 'rust',
        sorts = {
            'score',
            'sort_text',
        },
    },
    signature = {
        enabled = false,
    },
})

-- Lazydev lua_ls configuration
require('lazydev').setup({
    library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
})

local servers = {
    ['basedpyright'] = {
        lsp = 'basedpyright',
        config = {},
    },
    ['ruff'] = {
        lsp = 'ruff',
        config = {},
    },
    ['lua-language-server'] = {
        lsp = 'lua_ls',
        config = {
            settings = {
                Lua = {
                    completion = {
                        callSnippet = 'Replace',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        },
    },
    texlab = {
        lsp = 'texlab',
        config = {},
    },
    ['typescript-language-server'] = {
        lsp = 'ts_ls',
        config = {
            init_options = {
                preferences = {
                    quotePreference = 'single',
                },
            },
        },
    },
    ['yaml-language-server'] = {
        lsp = 'yamlls',
        config = {},
    },
    ['gopls'] = {
        lsp = 'gopls',
        config = {},
    },
    ['eslint-lsp'] = {
        lsp = 'eslint',
        config = {
            settings = {
                workingDirectory = { mode = 'auto' },
            },
        },
    },
}

require('mason').setup({})

require('mason-tool-installer').setup({
    ensure_installed  = vim.list_extend(vim.tbl_keys(servers or {}), {
        'debugpy',
        'js-debug-adapter',
        'delve',
    })
})

for _, settings in pairs(servers) do
    if settings.lsp == 'eslint' then
        local base_on_attach = vim.lsp.config.eslint.on_attach
        vim.lsp.config('eslint', {
            on_attach = function(client, bufnr)
                if not base_on_attach then return end

                base_on_attach(client, bufnr)
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    command = 'LspEslintFixAll',
                })
            end,
            settings = settings.config.settings,
        })
        vim.lsp.enable('eslint')
    elseif settings.lsp == 'ruff' then
        vim.lsp.config('ruff', {
            on_attach = function(_, bufnr)
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format()
                    end,
                })

                vim.api.nvim_create_autocmd('BufWritePost', {
                    buffer = bufnr,
                    command = 'silent! !~/.local/share/nvim/mason/packages/ruff/venv/bin/ruff check --select I --fix %',
                })
            end,
            settings = settings.config.settings,
        })
        vim.lsp.enable('ruff')
    else
        vim.lsp.config(settings.lsp, settings.config)
        vim.lsp.enable(settings.lsp)
    end
end

-- Diagnostic Config
vim.diagnostic.config({
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    } or {},
    virtual_text = true,
})

-- LSP custom pickers
local fzflua = require('fzf-lua')
vim.keymap.set('n', 'grd', fzflua.lsp_definitions, { desc = 'LSP: [G]oto [D]efinition' })
vim.keymap.set('n', 'grD', fzflua.lsp_declarations, { desc = 'LSP: [G]oto [D]eclaration' })
vim.keymap.set('n', 'grr', fzflua.lsp_references, { desc = 'LSP: [G]oto [R]eferences' })

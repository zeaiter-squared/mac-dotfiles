-- This function gets run when an LSP attaches to a particular buffer.
-- That is to say, every time a new file is opened that is associated with
-- an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
-- function will be executed to configure the current buffer.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        -- We create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us
        -- each time.
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        local fzflua = require('fzf-lua')

        -- Opens a popup that displays documentation about the word under your
        -- cursor. See `:help K` for why this keymap.
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable or function was first defined, etc.
        --  To jump back, press <C-T>.
        map('gd', fzflua.lsp_definitions, '[G]oto [D]efitinion')

        -- This is not goto definition.
        --  For example, in C this would take you to the header.
        map('gD', fzflua.lsp_declarations, '[G]oto [D]eclaration')

        -- Jump to implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gi', fzflua.lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('gt', fzflua.lsp_typedefs, '[G]oto [T]ype Definition')

        -- Find references for the word under your cursor.
        map('gr', fzflua.lsp_references, '[G]oto [R]eferences')

        -- Rename the variable under your cursor.
        --  Most Language Server support renaming across files, etc.
        map('gR', vim.lsp.buf.rename, '[R]ename')
        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('ga', fzflua.lsp_code_actions, '[G]oto Code [A]ction', { 'n', 'x' })
    end
})

-- Capabilities for nvim-cmp
-- local capabilities = require('lspconfig').util.default_config.capabilities
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- Capabilities for blink.cmp
local capabilities = require('blink.cmp').get_lsp_capabilities()


-- Lazydev lua_ls configuration
require('lazydev').setup({
    library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
})

local servers = {
    pyright = {},
    lua_ls = {
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
    texlab = {},
    ts_ls = {
        settings = {
            init_options = {
                preferences = {
                    quotePreference = 'single',
                },
            },
        },
    },
    yamlls = {},
}

require('mason').setup({})

require('mason-tool-installer').setup({
    ensure_installed  = vim.list_extend(vim.tbl_keys(servers or {}), {
        'debugpy',
        'js-debug-adapter',
        'chrome-debug-adapter',
    })
})

require('mason-lspconfig').setup({
    ensure_installed = {},
    automatic_installation = false,
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed by the servers
            -- configuratio above. Useful when disabling certain feature of an LSP
            -- (for example, turning off formatting for tsserver).
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
        end,
    },
})


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

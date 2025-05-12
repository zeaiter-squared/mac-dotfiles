-- Snippets
vim.g.UltiSnipsSnippetDirectories = {os.getenv('HOME') .. '/.local/share/nvim/UltiSnips'}
vim.g.UltiSnipsEditSplit = 'vertical'
vim.g.UltiSnipsExpandTrigger = '<Tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'

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

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
-- local lspconfig_defaults = require('lspconfig').util.default_config
-- lspconfig_defaults.capabilities = vim.tbl_deep_extend(
--   'force',
--   lspconfig_defaults.capabilities,
--   require('cmp_nvim_lsp').default_capabilities()
-- )

-- Auto completion engine
local cmp = require('cmp')

cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
        {name = 'ultisnips'},
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.confirm({select = true})
            else
                fallback()
            end
        end
    }),
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered({
            border = 'rounded',
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
        }),
        documentation = cmp.config.window.bordered({
            border = 'rounded',
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
        }),
    },
    formatting = {
        format = function(_, vim_item)
            local icon, hl = require('mini.icons').get('lsp', vim_item.kind)
            vim_item.kind = icon .. ' ' .. vim_item.kind
            vim_item.kind_hl_group = hl
            return vim_item
        end,
    },
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'cmp_docs',
    callback = function()
        local prev_win = vim.fn.win_getid(vim.fn.winnr('#'))
        if prev_win ~= 0 then
            local bufnr = vim.api.nvim_win_get_buf(prev_win)
            local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
            return vim.treesitter.start(0, 'typescript')
        end
        return vim.treesitter.start(0, 'typescript')
    end,
})

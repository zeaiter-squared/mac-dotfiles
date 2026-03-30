require('render-markdown').setup({
    file_types = { "markdown", "codecompanion" },
})

require('codecompanion').setup({
    interactions = {
        chat = {
            adapter = "ollama",
            model = "codegemma:7b",
            opts = {
                completion_provider = "blink",
            },
        },
    },
    display = {
        chat = {
            window = {
                buflisted = false, -- List the chat buffer in the buffer list?
                sticky = false, -- Chat window follows when switching tabs

                layout = "vertical", -- float|vertical|horizontal|tab|buffer
                full_height = true, -- for vertical layout
                position = "right", -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)

                width = 0.3, ---@return number|fun(): number
                height = 1.0, ---@return number|fun(): number

                border = "single",
                relative = "editor",

                -- Ensure that long paragraphs of markdown are wrapped
                opts = {
                    breakindent = true,
                    linebreak = true,
                    wrap = true,
                    relativenumber = false,
                    nu = false,
                },
            },
            icons = {
                buffer_sync_all = "󰪴 ",
                buffer_sync_diff = " ",
                chat_context = " ",
                chat_fold = " ",
                tool_pending = "  ",
                tool_in_progress = "  ",
                tool_failure = "  ",
                tool_success = "  ",
            },
            fold_context = true,
            fold_reasoning = false,
            show_reasoning = false,
        },
    },
    opts = {
        log_level = "DEBUG",
    },
})

local languages = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
}
local dap = require('dap')
local dapui = require('dapui')

dapui.setup()
require('nvim-dap-virtual-text').setup()
require('dap-python').setup(os.getenv("HOME") .. '/.local/share/nvim/mason/packages/debugpy/venv/bin/python')

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = 8123,
    executable = {
        command = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/js-debug-adapter",
    },
}

dap.adapters["firefox"] = {
    type = "executable",
    command = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/firefox-debug-adapter",
}

dap.adapters["chrome"] = {
    type = "executable",
    command = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/chrome-debug-adapter",
}

for _, language in ipairs(languages) do
    dap.configurations[language] = {
        {
            name = "Launch file",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
        },
        {
            name = "Next.js: debug server-side",
            type = "pwa-node",
            request = "launch",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "npm",
            runtimeArgs = { "run", "dev" },
            sourceMaps = true,
        },
        {
            name = "Next.js: debug full stack",
            type = "pwa-node",
            request = "launch",
            program = "${workspaceFolder}/node_modules/next/dist/bin/next",
            runtimeArgs = { "--inspect" },
            skipFiles = { "<node_internals>/**" },
            serverReadyAction = {
                action = "debugWithChrome",
                killOnServerStop = true,
                pattern = "- Local:.+(https?://.+)",
                uriFormat = "%s",
                webRoot = "${workspaceFolder}",
            },
            cwd = "${workspaceFolder}",
        },
    }
end

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>dl', dap.step_into)
vim.keymap.set('n', '<leader>dj', dap.step_over)
vim.keymap.set('n', '<leader>dh', dap.step_out)
vim.keymap.set('n', '<leader>dk', dap.step_back)
vim.keymap.set('n', '<leader>dr', dap.restart)

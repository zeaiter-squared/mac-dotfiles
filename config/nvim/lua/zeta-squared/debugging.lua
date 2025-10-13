local dap = require('dap')
local dapui = require('dapui')
local js_debug_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
local go_debug_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/delve/dlv"
local py_debug_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

dapui.setup()
require('nvim-dap-virtual-text').setup()
require('dap-python').setup(py_debug_path)
require('dap-go').setup({
    delve = {
        path = go_debug_path,
    },
})

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = 9230,
    executable = {
        command = "node",
        args = {
            js_debug_path, "9230"
        },
    },
}

local languages = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
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
            type = "pwa-node",
            request = "launch",
            name = "Debug payload ingestion",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "pnpm",
            runtimeArgs = {"payload", "run", "src/payload/scripts/ingestion", "--", "--refresh"},
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            sourceMaps = true,
            skipFiles = {"<node_internals>/**", "node_modules/**"},
        },
        {
            name = "Attach to process",
            type = "pwa-node",
            request = "attach",
            port = 9230,
            restart = true,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = {"<node_internals>/**", "node_modules/**"},
        },
        {
            name = "Next.js: debug server",
            type = "pwa-node",
            request = "launch",
            runtimeExecutable = "node",
            program = "${workspaceFolder}/node_modules/next/dist/bin/next",
            args = {"dev"},
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal"
        },
    }
end

-- dap.listeners.before.attach.dapui_config = function()
--   dapui.open()
-- end
-- dap.listeners.before.launch.dapui_config = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated.dapui_config = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--   dapui.close()
-- end

local cat_config = require('zeta-squared.cat_config')
local cat_colours = cat_config.color_overrides.macchiato
vim.highlight['DapBreakpoint'] = {}
vim.highlight['DapBreakpointCondition'] = {}
vim.highlight['DapLogPoint'] = {}
vim.highlight['DapStopped'] = {}
vim.highlight['DapBreakpointRejected'] = {}

vim.fn.sign_define('DapBreakpoint', {text='', texthl='DapBreakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='DapBreakpointCondition', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='', texthl='DapLogPoint', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='DapStopped', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='DapBreakpointRejected', linehl='', numhl=''})

vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dB',
    function()
        local condition = vim.fn.input("Breakpoint condition (optional): ")
        local hit_condition = vim.fn.input("Hit count (optional): ")

        condition = condition ~= "" and condition or nil
        hit_condition = hit_condition ~= "" and hit_condition or nil
        dap.toggle_breakpoint(condition, hit_condition)
    end
)
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>dl', dap.step_into)
vim.keymap.set('n', '<leader>dj', dap.step_over)
vim.keymap.set('n', '<leader>dh', dap.step_out)
vim.keymap.set('n', '<leader>dk', dap.step_back)
vim.keymap.set('n', '<leader>dr', dap.restart)
vim.keymap.set('n', '<leader>dq', dap.terminate)
vim.keymap.set('n', '<leader>dt', dapui.toggle)

local fterm = require('FTerm')

local term1 = fterm:new({
    cmd = 'bash',
    border = 'rounded',
    dimensions = {
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.2,
    },
})

local term2 = fterm:new({
    cmd = 'bash',
    border = 'rounded',
    dimensions = {
        height = 0.96,
        width = 0.5,
        x = 0.01,
        y = 0.2,
    },
})

local term3 = fterm:new({
    cmd = 'bash',
    border = 'rounded',
    dimensions = {
        height = 0.96,
        width = 0.5,
        x = 1.0,
        y = 0.2,
    }
})

local term4 = fterm:new({
    ft = 'fterm_lazygit',
    cmd = 'lazygit',
    border = 'rounded',
    dimensions = {
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.2,
    },
})

function _term1_toggle()
    term1:toggle()
end

function _term2_toggle()
    term2:toggle()
end

function _term3_toggle()
    term3:toggle()
end

function _term4_toggle()
    term4:toggle()
end

vim.keymap.set({'n', 't'}, '<C-]>', '<cmd>lua _term1_toggle()<CR>')
vim.keymap.set({'n', 't'}, '<C-\\>', '<cmd>lua _term2_toggle()<CR>')
vim.keymap.set({'n', 't'}, '<A-\\>', '<cmd>lua _term3_toggle()<CR>')
vim.keymap.set({'n', 't'}, '<A-]>', '<cmd>lua _term4_toggle()<CR>')

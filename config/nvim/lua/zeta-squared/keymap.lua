-- Keymaps to open new split/tab and view the current buffer.
vim.keymap.set({'n', 'v'}, '<leader>ws', ':sp<CR>')
vim.keymap.set({'n', 'v'}, '<leader>wv', ':vs<CR>')
vim.keymap.set({'n', 'v'}, '<leader>wt', ':$tab split<CR>')

-- Keymaps for yanking to, and pasting from, clipboard.
vim.keymap.set({'n', 'v'}, '<leader>y', '\"+y')
vim.keymap.set({'n', 'v'}, '<leader>Y', '\"+Y')
vim.keymap.set({'n', 'v'}, '<leader>p', '\"+p')

-- Keymaps for scrolling or jumping through file.
vim.keymap.set('i', '<A-f>', '<C-Right>')
vim.keymap.set('i', '<A-b>', '<C-Left>')
vim.keymap.set('i', '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')

-- Keymap to recenter after scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Keymap to jump to previous file.
vim.keymap.set('n', '<C-q>', '<C-^>')

-- Keymaps for changing tabs.
vim.keymap.set('n', '<leader>1', '1gt')
vim.keymap.set('n', '<leader>2', '2gt')
vim.keymap.set('n', '<leader>3', '3gt')
vim.keymap.set('n', '<leader>4', '4gt')
vim.keymap.set('n', '<leader>5', '5gt')
vim.keymap.set('n', '<leader>6', '6gt')
vim.keymap.set('n', '<leader>7', '7gt')
vim.keymap.set('n', '<leader>8', '8gt')
vim.keymap.set('n', '<leader>9', '9gt')

-- Keymap to grab and change all words in the file that are currently
-- under the cursor.
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

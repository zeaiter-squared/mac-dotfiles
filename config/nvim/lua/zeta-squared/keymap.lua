-- Keymaps to go to Explore mode as well as open new split/tab and view
-- the current directory.
vim.keymap.set({'n', 'v'}, '<leader>pd', vim.cmd.Ex)
vim.keymap.set({'n', 'v'}, '<leader>pe', ':vs<CR>:Explore<CR>')
vim.keymap.set({'n', 'v'}, '<leader>ws', ':sp<CR>')
vim.keymap.set({'n', 'v'}, '<leader>wv', ':vs<CR>')
vim.keymap.set({'n', 'v'}, '<leader>wt', ':$tabnew<CR>')

-- Remap moving between lines to not ignore wrapped lines.
-- vim.keymap.set({'n', 'v'}, 'j', 'gj')
-- vim.keymap.set({'n', 'v'}, 'k', 'gk')

-- Keymaps for yanking to, and pasting from, clipboard.
vim.keymap.set({'n', 'v'}, '<leader>y', '\"+y')
vim.keymap.set({'n', 'v'}, '<leader>Y', '\"+Y')
vim.keymap.set({'n', 'v'}, '<leader>p', '\"+p')

-- Keymaps for scrolling or jumping through file.
-- vim.keymap.set({'n', 'v'}, '<C-j>', '<C-d>')
-- vim.keymap.set({'n', 'v'}, '<C-k>', '<C-u>')
-- vim.keymap.set({'n', 'v'}, '<C-u>', '<C-e>')
-- vim.keymap.set({'n', 'v'}, '<C-i>', '<C-y>')
vim.keymap.set('i', '<A-f>', '<C-Right>')
vim.keymap.set('i', '<A-b>', '<C-Left>')
vim.keymap.set('i', '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')

-- Keymaps for switching between splits.
vim.keymap.set('n', '<A-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<A-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<A-k>', ':wincmd k<CR>')

-- Keymaps for adding newlines below or above current line without
-- leaving normal mode.
vim.keymap.set('n', '<C-o>', 'o<Esc>')
vim.keymap.set('n', '<A-o>', 'O<Esc>')

-- Keymap to have <C-[> behave in terminal mode as it does in insert
-- mode.
vim.keymap.set('t', '<A-[>', '<C-\\><C-n>')

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

-- Keymaps to open floating window for diagnostics that go off screen.
-- Also mappings to jump to next or prev diagnostic in file.
vim.keymap.set('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>');
vim.keymap.set('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>');
vim.keymap.set('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>');

-- Keymaps for mac
-- vim.keymap.set('i', '<C-[>', '<Esc><Esc>')

-- Keymap to close quickfix list after selection
vim.api.nvim_create_autocmd(
    'FileType', {
        pattern = {'qf'},
        command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
    }
)

vim.g.mapleader = " "
vim.keymap.set("n", "<leader><leader>", vim.cmd.Ex)

-- move lines of code up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move up and down keep cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u", "<C-u>zz")


vim.keymap.set("x", "<leader>p", "\"_dP")


vim.g.mapleader = " "

-- COMMANDS REMAPS
vim.keymap.set("n", "<leader><leader>", vim.cmd.Ex)
vim.keymap.set("n", "<leader>q", function()
    vim.cmd("wqa")
  end,
  { desc = "Save and [Q]uit all" }
)
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndo Tree" })



-- HACKS
-- move lines of code up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move up and down keep cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u", "<C-u>zz")

-- paste without removing the previous buffer
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "[p]aste and preserve current buffer" })

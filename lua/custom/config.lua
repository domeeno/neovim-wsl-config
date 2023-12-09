vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.expandtab = true

vim.cmd('syntax on')

vim.wo.number = true

vim.wo.relativenumber = true

vim.o.clipboard = 'unnamedplus'

vim.o.mouse = 'a'

vim.cmd('autocmd FileType elixir colorscheme onedark')

vim.cmd([[colorscheme gruvbox]])

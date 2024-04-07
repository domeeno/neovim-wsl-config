-- Move to previous/next
vim.keymap.set('n', '<leader>,', '<cmd>BufferPrevious<cr>', { desc = "prev tab" } )
vim.keymap.set('n', '<leader>.', '<cmd>BufferNext<cr>', { desc = "next tab" } )
-- Re-order to previous/next
vim.keymap.set('n', '<leader><', '<cmd>BufferMovePrevious<cr>', { desc = "move prev tab" } )
vim.keymap.set('n', '<leader>>', '<cmd>BufferMoveNext<cr>', { desc = "move next tab" } )
-- Goto buffer in position...
vim.keymap.set('n', '<leader>1', '<cmd>BufferGoto 1<cr>', { desc = "go to tab 1" } )
vim.keymap.set('n', '<leader>2', '<cmd>BufferGoto 2<cr>', { desc = "go to tab 2" } )
vim.keymap.set('n', '<leader>3', '<cmd>BufferGoto 3<cr>', { desc = "go to tab 3" } )
vim.keymap.set('n', '<leader>4', '<cmd>BufferGoto 4<cr>', { desc = "go to tab 4" } )
vim.keymap.set('n', '<leader>5', '<cmd>BufferGoto 5<cr>', { desc = "go to tab 5" } )
vim.keymap.set('n', '<leader>6', '<cmd>BufferGoto 6<cr>', { desc = "go to tab 6" } )
vim.keymap.set('n', '<leader>7', '<cmd>BufferGoto 7<cr>', { desc = "go to tab 7" } )
vim.keymap.set('n', '<leader>8', '<cmd>BufferGoto 8<cr>', { desc = "go to tab 8" } )
vim.keymap.set('n', '<leader>9', '<cmd>BufferGoto 9<cr>', { desc = "go to tab 9" } )
vim.keymap.set('n', '<leader>0', '<cmd>BufferLast<cr>', { desc = "go to last" } )

-- Pin/unpin buffer
vim.keymap.set('n', '<leader>p', '<cmd>BufferPin<cr>', { desc = "pin tab" } )
-- Close buffer
vim.keymap.set('n', '<leader>c', '<cmd>BufferClose<cr>', { desc = "close tab" } )

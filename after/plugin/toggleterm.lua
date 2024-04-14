require('toggleterm').setup {
  size = function(term)
    return vim.o.columns * 0.3
  end,
  direction = 'float'
}

vim.keymap.set("n", "<leader>t", vim.cmd.ToggleTerm, { desc = "[T]erminal" })

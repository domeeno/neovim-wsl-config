

return {
  {'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },

      config = function()
        local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sw', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
  end,
  { desc = '[S]earch [W]ord' }
)
     end
    },


    }

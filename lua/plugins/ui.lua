return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
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

  {
    "akinsho/toggleterm.nvim",
    config = function()
      require('toggleterm').setup {
        size = function(term)
          return vim.o.columns * 0.3
        end,
        direction = 'float'
      }

      vim.keymap.set("n", "<leader>t", vim.cmd.ToggleTerm, { desc = "[T]erminal" })
    end
  },

  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {
        config = function()
          vim.o.timeout = true
          vim.o.timeoutlen = 300
          require("which-key").setup {
            triggers_blacklist = {
              -- list of mode / prefixes that should never be hooked by WhichKey
              -- this is mostly relevant for keymaps that start with a native binding
              i = { "j", "k", "h", "l" },
              v = { "j", "k" },
            },
          }
        end
      }
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  },
}

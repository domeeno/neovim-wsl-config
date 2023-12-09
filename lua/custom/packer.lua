-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- gruvbox
  use ({
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    as = "gruvbox", 
    config = function()
      vim.cmd.colorscheme 'gruvbox'
    end,
  })

  -- atom
  use ({
    'navarasu/onedark.nvim',
    as = "elixir",
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  })


  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('tpope/vim-fugitive')
  use('lewis6991/gitsigns.nvim')

end)

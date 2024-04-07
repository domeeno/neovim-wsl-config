-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- theme gruvbox
  use('ellisonleao/gruvbox.nvim')

  -- theme atom
  use('navarasu/onedark.nvim')


  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }) -- syntax highlighter
  use('tpope/vim-fugitive')                                     -- git integration
  use('lewis6991/gitsigns.nvim')                                -- git integration
  use('nvim-tree/nvim-web-devicons')                            -- icons
  use('romgrk/barbar.nvim')                                     -- nvim tabs manager
  use('folke/which-key.nvim')                                   -- command whisperer
  use('mbbill/undotree')                                        -- undo history

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      --- Uncomment these if you want to manage LSP servers from neovim
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- LSP Support
      { 'neovim/nvim-lspconfig' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' }
    }
  }



  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }                                     -- pretty status line

  use { 'windwp/nvim-autopairs' }       -- autopairs
  use { 'norcalli/nvim-colorizer.lua' } -- show hex color

  use { 'iamcco/markdown-preview.nvim' }
  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end }

  -- language specific plugins
  use({ 'elixir-tools/elixir-tools.nvim', tag = 'stable', requires = { 'nvim-lua/plenary.nvim' } }) -- elixir
  use('nvimtools/none-ls.nvim')                                                                     -- for nextjs/reactjs js/ts/tsx/jsx autoformatting
  use("windwp/nvim-ts-autotag")                                                                     -- html autotag completion
end)

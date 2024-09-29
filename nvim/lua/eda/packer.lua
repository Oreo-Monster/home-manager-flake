-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use "rebelot/kanagawa.nvim"

  use("nvim-treesitter/nvim-treesitter", {run = ':TSUpdate'})

  use("nvim-treesitter/playground")

  use('theprimeagen/harpoon')

  use('mbbill/undotree')

  use("tpope/vim-fugitive")

  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      requires = {
          --- Uncomment these if you want to manage LSP servers from neovim
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},

          -- LSP Support
          {'neovim/nvim-lspconfig'},
          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'L3MON4D3/LuaSnip'},
      }
  }

  use {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
  }

  use {
      'numToStr/Comment.nvim',
  }

  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use {'lewis6991/gitsigns.nvim'}

  use {'Pocco81/auto-save.nvim'}

  use { "catppuccin/nvim", as = "catppuccin" }

  use {'preservim/nerdtree'}

  use {'ryanoasis/vim-devicons'}

  use {'Xuyuanp/nerdtree-git-plugin'}

  use {'christoomey/vim-tmux-navigator'}

  use{ 'phpstan/vim-phpstan' }
end)

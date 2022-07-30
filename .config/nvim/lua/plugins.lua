return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- Telescope extensions
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- /Telescope extensions

  -- use 'gfanto/fzf-lsp.nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use 'neovim/nvim-lspconfig'

  -- Color schemes
  use 'arcticicestudio/nord-vim'
  -- use 'morhetz/gruvbox' -- Obsolete
  use { 'ellisonleao/gruvbox.nvim' }
  use 'rakr/vim-one'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'

  use 'onsails/lspkind-nvim'

  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'hrsh7th/cmp-vsnip'

  use 'bfredl/nvim-luadev'

  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }

  use 'ethanholz/nvim-lastplace'
end)

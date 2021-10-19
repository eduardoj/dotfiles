return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Telescope extensions
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- /Telescope extensions

  -- use 'gfanto/fzf-lsp.nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use 'neovim/nvim-lspconfig'

  -- Color schemes
  use 'arcticicestudio/nord-vim'
  use 'morhetz/gruvbox'
  use 'rakr/vim-one'

  -- TODO: https://github.com/SirVer/ultisnips
end)

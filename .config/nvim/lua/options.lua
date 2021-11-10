vim.opt.autoindent = true
vim.opt.background = 'dark'
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.number = true
vim.opt.smartindent = true
vim.opt.termguicolors = true

vim.cmd('colorscheme gruvbox')

vim.g.gruvbox_contrast_dark = 'hard'

local indent = 2
vim.opt.shiftwidth = indent
vim.opt.softtabstop = indent
vim.opt.tabstop = indent

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Used by :checkhealth
vim.g.python3_host_prog = '/usr/bin/python3.9'

vim.g.ruby_host_prog = '/usr/bin/neovim-ruby-host.ruby2.7'

vim.env.PERL_MB_OPT = "--install_base \"~/perl5\""
vim.env.PERL_MM_OPT = "INSTALL_BASE=~/perl5"

-- :help ft-ruby-omni
vim.g.rubycomplete_buffer_loading = 1
vim.g.rubycomplete_classes_in_global = 1
vim.g.rubycomplete_rails = 1

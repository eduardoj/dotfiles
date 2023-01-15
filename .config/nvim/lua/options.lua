vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.showmatch = true -- show matching brackets when text indicator is over them
vim.opt.mouse = 'a' -- Enable mouse for all modes
vim.opt.clipboard = "unnamedplus"
-- vim.opt.relativenumber = true -- Show line numbers...
vim.opt.number = true -- ... but show the actual number for the line we're on
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query
vim.opt.smartindent = true
vim.opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor
vim.opt.splitright = true -- Prefer windows splitting to the right
vim.opt.splitbelow = true -- Prefer windows splitting to the bottom
vim.opt.laststatus = 3 -- Add global statusline
vim.opt.cmdheight = 0 -- Hide the command line and gain an extra line


vim.opt.termguicolors = true
-- gruvbox
-- vim.opt.background = 'dark' -- or "light" for light mode
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd([[colorscheme gruvbox]])

-- one
--vim.opt.background = 'dark'
--vim.cmd('colorscheme one')

-- Transparent background: https://www.youtube.com/watch?v=w7i4amO_zaE
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none", fg = 'fg' })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = 'fg' })
-- vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })

local indent = 2
vim.opt.shiftwidth = indent
vim.opt.softtabstop = indent
-- Perl files keep 8 spaces for tabs
-- vim.opt.tabstop = indent

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Used by :checkhealth
vim.g.python3_host_prog = '/usr/bin/python3.9'

vim.g.ruby_host_prog = '/usr/bin/neovim-ruby-host.ruby3.1'

vim.env.PERL_MB_OPT = "--install_base \"~/perl5\""
vim.env.PERL_MM_OPT = "INSTALL_BASE=~/perl5"

-- :help ft-ruby-omni
vim.g.rubycomplete_buffer_loading = 1
vim.g.rubycomplete_classes_in_global = 1
vim.g.rubycomplete_rails = 1

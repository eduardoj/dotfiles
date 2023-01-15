-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
-- require('telescope').setup {
--   extensions = {
--     fzf = {
--       fuzzy = true,                    -- false will only do exact matching
--       override_generic_sorter = true,  -- override the generic sorter
--       override_file_sorter = true,     -- override the file sorter
--       case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
--                                        -- the default case_mode is "smart_case"
--     }
--   }
-- }

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      -- Defaults
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      -- Custom
      '--hidden',
      '--glob', '!**/.git/*',
    },
  },
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
    }
  }
}

require('telescope').load_extension('fzf')

-- https://github.com/nvim-telescope/telescope.nvim#usage
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})

require('nvim-web-devicons').setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { "bash", "css", "dockerfile", "go", "html", "javascript", "json",
                        "lua", "perl", "regex", "ruby", "vim", "yaml" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    -- Disable perl syntax: it doesn't work well with huge files
    disable = { 'perl' },
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}


-- Setup nvim-cmp.
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    -- { name = 'buffer', keyword_length = 3 },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format()
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  }
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline', keyword_length = 3 }
  })
})


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require('lspconfig')
local util = require('lspconfig.util')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
end

-- gopls requires: `go install golang.org/x/tools/gopls@latest`
-- nvim_lsp.gopls.setup{}
-- Commented. Done in the loop below.

-- perlpls requires: `cpanm -n PLS::Server`
-- nvim_lsp.perlpls.setup{}
-- Commented. Done in the loop below.

-- sumneko_lua requires: `zypper in lua-language-server`
-- nvim_lsp.sumneko_lua.setup{}
-- Commented. Done in the loop below.

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls', 'perlpls', 'solargraph', 'sumneko_lua' }
-- local servers = { 'gopls', 'perlpls', 'ruby_ls', 'sumneko_lua' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
    settings = {
      perl = {
        inc = { './src/backend', './src/backend/build', './src/backend/t/lib', },
      }
    }
  }
end

-- require'lspconfig'.solargraph.setup{
nvim_lsp.solargraph.setup{
  -- cmd = { 'solargraph', 'stdio' },
  cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
  filetypes = { 'ruby' },
  init_options = {
    formatting = true
  },
  -- root_dir = util.root_pattern('.git'),
  root_dir = util.root_pattern('Gemfile'),
  -- TODO: make retrieving this path dynamically
  -- cmd_cwd = util.root_pattern('Gemfile'),
  cmd_cwd = os.getenv('HOME')..'/github/open-build-service/src/api',
  settings = {
    solargraph = {
      diagnostics = true,
      -- logLevel = 'info',
      -- logLevel = 'debug',
      -- useBundler = true,
      -- bundlerPath = '/usr/bin/bundle'
    }
  },
  on_attach = on_attach,
}

-- nvim_lsp.ruby_ls.setup{
--   cmd = { 'bundle', 'exec', 'ruby-lsp' },
--   -- root_dir = util.root_pattern('Gemfile', '.git'),
--   root_dir = util.root_pattern('Gemfile'),
--   enabledFeatures = { "codeActions", "diagnostics", "documentHighlights", "documentSymbols", "formatting", "inlayHint" },
--   -- enabledFeatures = { 'diagnostics' },
--   cmd_cwd = os.getenv('HOME')..'/github/open-build-service/src/api',
--   on_attach = on_attach,
-- }

require('gitsigns').setup()

require('nvim-lastplace').setup()

require('Comment').setup()

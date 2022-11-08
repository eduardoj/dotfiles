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


require('telescope').load_extension('fzf')

-- https://tuckerchapman.com/2018/06/16/how-to-use-the-vim-leader-key/
-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
vim.api.nvim_set_keymap('n', '<Leader>ff', "<cmd>Telescope find_files<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>fg', "<cmd>Telescope live_grep<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>fb', "<cmd>Telescope buffers<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>fh', "<cmd>Telescope help_tags<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>fo', "<cmd>Telescope oldfiles<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>fd', "<cmd>Telescope diagnostics<CR>", {noremap = true})

require('nvim-treesitter.configs').setup {
  ensure_installed = { "bash", "css", "dockerfile", "go", "html", "javascript", "json",
                        "lua", "perl", "regex", "ruby", "vim", "yaml" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    -- Disable perl syntax: it doesn't work well with huge files
    --disable = { 'perl' },
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}


-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')

-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--       -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--       -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--       -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
--     end,
--   },
--   mapping = {
--     ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
--     ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
--     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--     ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
--     ['<C-e>'] = cmp.mapping({
--       i = cmp.mapping.abort(),
--       c = cmp.mapping.close(),
--     }),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }),
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' }, -- For vsnip users.
--     -- { name = 'luasnip' }, -- For luasnip users.
--     -- { name = 'ultisnips' }, -- For ultisnips users.
--     -- { name = 'snippy' }, -- For snippy users.
--   }, {
--     { name = 'buffer', keyword_length = 3 },
--   }),
--   formatting = {
--     format = lspkind.cmp_format()
--   },
--   experimental = {
--     native_menu = false,
--     ghost_text = true,
--   }
-- })

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
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- gopls requires: `go install golang.org/x/tools/gopls@latest`
-- nvim_lsp.gopls.setup{}
-- Commented. Done in the loop below.

-- perlpls requires: `cpanm -n PLS::Server`
-- nvim_lsp.perlpls.setup{}
-- Commented. Done in the loop below.

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls', 'perlpls', 'solargraph' }
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

require('gitsigns').setup()

require('nvim-lastplace').setup()

require('Comment').setup()

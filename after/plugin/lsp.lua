local lsp = require('lsp-zero').preset({})

-- lsp.preset("recommended")
lsp.ensure_installed({
  'clangd',
  'rust_analyzer',
})
-- require("neoformat").setup()
-- require("vem-tabline").setup()
--
--  require'compe'.setup({
--     enabled = true,
--     source = {
--       path = true,
--       buffer = true,
--       nvim_lsp = true,
--     },
--   })
-- vim.o.completeopt = "menuone,noselect"
--

--
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   }
-- }
-- vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })

local cmp = require('cmp')
cmp.setup({
    mapping= {
     ['<tab>'] = cmp.mapping.confirm({ select = true }),
     ['<S-Space>'] = cmp.mapping.scroll_docs(),    -- Ctrl+Space to trigger completion menu
     ['space>'] = cmp.mapping.complete(),
    },
})
require("nvim-autopairs").setup()
function attach (client, bufnr)
 local opts = {buffer = bufnr, remap = false}
  -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>cs", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<C-d>", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>ce", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>ci", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "<leader>ct", function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set({"n", "i"}, "<C-Space>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set({"n", "i"}, "<S-Space>", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>gt", function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "<leader>td", "<cmd>Telescope diagnostics<CR>", opts)
 vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end, opts)
 vim.keymap.set("n", "<S-h>", "<cmd>CommentToggle<CR>", opts)

 vim.keymap.set("n", "<leader>h", require("lsp_lines").toggle, opts)


end
lsp.on_attach(attach)

require("lspconfig").clangd.setup({

})
require("lspconfig").pyright.setup({
  cmd = { "pyright-langserver", "--stdio" },
 })

-- require("rust-tools").setup({
   -- cmd = {"rustup", "run", "stable", "rust_analyzer"}
    -- on_attach= lsp.on_attach
-- })
-- require('rust-tools').inlay_hints.enable()
--lsp.setup_servers({"rust_analyzer"})
-- require("lspconfig").rust_analyzer.setup{
   -- cmd = {"rustup", "run", "stable", "rust_analyzer"},
   -- root_dir = require('lspconfig.util').root_pattern({'.git'})

-- }
--
-- require("lspconfig").rust_analyzer.setup{}
-- require("lspconfig").asm_lsp.setup{
--     cmd={"rustup", "run", "stable", "asm-lsp"},
--     filetypes= { "asm", "vmasm", "s", "S"}
-- }
lsp.skip_server_setup({'rust_analyzer'})
require("lspconfig").angularls.setup({
    root_dir = require('lspconfig.util').root_pattern({'.git'})

})
require("lspconfig").antlersls.setup({
root_dir = require('lspconfig.util').root_pattern({'.git'})
})
--
require("lspconfig").html.setup({})
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require("lspconfig").tsserver.setup({})
lsp.setup()

local rust_tools = require('rust-tools')

rust_tools.setup({
  server = {
    on_attach =function(client, bufnr)
        attach(client, bufnr)
      require("crates").setup()
      -- vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, {buffer = bufnr})
    end,
    -- capabilities = capabilities
  }
})

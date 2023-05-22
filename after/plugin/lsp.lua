local lsp = require('lsp-zero')

lsp.preset("recommended")
lsp.ensure_installed({
  'clangd',
  'rust_analyzer',
})
lsp.nvim_workspace()
-- code completion
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})
--cmp_mappings['<Tab>'] = nil
--cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})
    -- (Optional) Configure lua language server for neovim

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>dv", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require("lspconfig").clangd.setup({
     cmd = {
    'clangd',
    '--background-index',
    '--header-insertion=never',
    '--clang-tidy',
    '--completion-style=bundled',
    '--pch-storage=memory',
    '--header-insertion-decorators=0',
    '--clang-ipc-disable',
    '--query-driver=/usr/include/gtk-4.0/gtk',
  },
    on_attach = function (client,bufnr)
        print("hello from clangd")
    end
})

--require("lspconfig").vim_lsp.jedi_language_server.setup{
--  cmd = { "jedi-language-server" },
--  on_attach = function(client)
--    -- Customize on_attach if needed
--    print('LSP started!')
--  end
--}

require("lspconfig").pyright.setup{
  cmd = { "pyright-langserver", "--stdio" },
  on_attach = function(client, bufnr)
    -- Set the python.pythonPath configuration
  end,
}

lsp.setup()


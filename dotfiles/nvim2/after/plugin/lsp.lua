local lsp = require('lsp-zero').preset({})
local cmp = require('cmp')

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    lsp.default_keymaps(opts)
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require("lspconfig").tsserver.setup{
  settings = {
    implicitProjectConfiguration = {
      checkJs = true
    },
  }
}

lsp.setup()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', -- tag = '0.1.4',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({ 'rose-pine/neovim', as = 'rose-pine' })
  use {
    "phha/zenburn.nvim",
    config = function() require("zenburn").setup() end
}

  vim.cmd('colorscheme rose-pine')

  use(
        'nvim-treesitter/nvim-treesitter',
  { run = ':TSUpdate' }
  )
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
  use { -- Autocompletion
    "hrsh7th/nvim-cmp",     -- Required
    "hrsh7th/cmp-nvim-lsp", -- Required
    "L3MON4D3/LuaSnip" -- Required
}
use({ 'mfussenegger/nvim-lint', as = 'lint' })
use "IndianBoy42/tree-sitter-just"
end)

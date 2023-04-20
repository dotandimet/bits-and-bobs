vim.opt.directory = "/tmp"
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars = { trail = ".", tab = ">." }
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8

-- au BufRead,BufNewFile *.vue set ft=html syntax=html
-- au BufRead,BufNewFile Jenkinsfile set ft=groovy syntax=groovy
-- au BufRead,BufNewFile Rprofile set ft=R syntax=R
-- 
-- set hidden
-- let g:ackprg = 'rg --vimgrep --ignore-file=.gitignore'
-- 
-- vim.opt.foldmethod     = 'expr'
-- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
---WORKAROUND
vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod     = 'expr'
    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
    vim.opt.foldenable = false
  end
})
---ENDWORKAROUND

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
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
-- vim.opt.incsearch = true
vim.opt.scrolloff = 8

local mySetSyntax = function(pattern, file_type, syntax)
    vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"},
    { pattern = pattern, callback = function ()
        vim.opt.syntax = syntax
        vim.opt.filetype = file_type
    end })
end

-- au BufRead,BufNewFile *.vue set ft=html syntax=html
mySetSyntax({"*.vue"}, "html", "html")
-- au BufRead,BufNewFile Jenkinsfile set ft=groovy syntax=groovy
mySetSyntax({"Jenkinsfile"}, "groovy", "groovy")
-- au BufRead,BufNewFile Rprofile set ft=R syntax=R
mySetSyntax({"Rprofile"}, "R", "R")
-- 
-- set hidden
-- let g:ackprg = 'rg --vimgrep --ignore-file=.gitignore'
-- 
-- vim.opt.foldmethod     = 'expr'
-- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
---WORKAROUND
vim.api.nvim_create_autocmd({"BufEnter","BufAdd","BufNew","BufNewFile","BufWinEnter"}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod     = 'expr'
    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
    vim.opt.foldenable = false
  end
})
---ENDWORKAROUND

-- make ^X^F more useful, by looking in the directory of the current open file
-- from: https://superuser.com/questions/604122/vim-file-name-completion-relative-to-current-file
-- :autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
-- :autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

SaveCwd = vim.fn.getcwd()

vim.api.nvim_create_autocmd({"InsertEnter"}, {
    callback = function()
        SaveCwd = vim.fn.getcwd()
        vim.opt.autochdir = true
    end
})

vim.api.nvim_create_autocmd({"InsertLeave"}, {
    callback = function()
        vim.opt.autochdir = false
        vim.api.nvim_set_current_dir(SaveCwd)
    end
})


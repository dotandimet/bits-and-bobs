set directory=/tmp
"set t_Co=256
set tabstop=4
set expandtab
set shiftwidth=4
colorscheme zenburn
filetype plugin on
syntax enable

au BufRead,BufNewFile *.vue set ft=html syntax=html

set list
set listchars=trail:.,tab:>.
let g:ackprg = 'rg --vimgrep --ignore-file=.gitignore'

autocmd BufLeave,FocusLost * silent! wall
set guifont=Menlo\ Regular:h15 
set tabstop=2
set shiftwidth=2
set expandtab
colorscheme zenburn
syntax enable
autocmd BufRead *\.txt setlocal spell spelllang=en_us
autocmd BufRead *\.md setlocal spell spelllang=en_us syntax=markdown
set listchars=tab:▷⋅,trail:·
set list
set dir=~/tmp
set textwidth=120
set ruler

" Plugins!
call plug#begin(stdpath('data') .'/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'branch': 'yarn install --frozen-lockfile'}
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'doums/darcula'

" Initialize plugin system
call plug#end()

" coc config stuff:
source ~/.config/nvim/coc.vim
colorscheme darcula


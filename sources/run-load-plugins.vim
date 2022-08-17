" Definição dos plugins utilizados pelo Vim-Plug 
" ----------------------------------------------------------------
"
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : g:vi_dir . '/plugged')
    Plug 'preservim/nerdtree' |
        \ Plug 'Xuyuanp/nerdtree-git-plugin' |
        \ Plug 'ryanoasis/vim-devicons' |
        \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'mattn/emmet-vim'
    Plug 'tpope/vim-commentary'
    Plug 'majutsushi/tagbar'
    Plug 'dense-analysis/ale'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'majutsushi/tagbar'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'kien/ctrlp.vim'
    Plug 'tpope/vim-surround'
    Plug 'docteurklein/php-getter-setter.vim'
call plug#end()


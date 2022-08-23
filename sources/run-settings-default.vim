"
" ******** Custom functions loading ************************************
execute 'source ' . g:vi_dir . '/sources/run-functions.vim'

" Define the UTF-8 encoding
set encoding=utf8

" The predawn.vim file must be inside 'colors/' directory to vim
" detect this theme
colorscheme predawn

" Turn italic every comment
highlight Comment cterm=italic

set nocp

" Display autocomplete, in the horizontal-view way, in command-mode
set wildmenu

" If there are file modifications, ask if must save before close the file
set confirm

" Execute focus where the mouse click
set mouse=a

" Add the filename it's been edited, in terminal title
set title

" Display the 'line numbers'
set number

" Insert automatically the identation from upper line during 'newlines'
set autoindent

" Display used keys during the commands, on 'normal mode'
set showcmd

" Use '4 spaces' as tabulation como tab, as default
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Redirect the vim copy to clipboard e vice-versa
set clipboard=unnamedplus

" Define the view of no-printable characters
" Similar to 'cat -A' shell command
" tab:^I
" space:.
" eol:$
set listchars=trail:.,eol:$

" It serves for vim's built-in terminal open on the 'bottom' side
set splitbelow

if !empty(glob(g:vi_dir . '/markers/.devRunning'))
    "
    " Session saving routine from vim
    "
    call PersistSession()

    "
    " Session loading routine from vim
    "
    call LoadSession()
endif
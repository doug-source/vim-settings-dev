"
" ******** Loading das custom functions ************************************
execute 'source ' . g:vi_dir . '/sources/run-functions.vim'

" Define o encoding em UTF-8
set encoding=utf8

" O arquivo predawn.vim deve estar dentro da pasta '~/.vim/colors/' para o vim
" detectar esse theme
colorscheme predawn

" Torna itálico todos os comentários
highlight Comment cterm=italic

set nocp

" Exibe autocomplete, em horizontal-view, no command-mode
set wildmenu

" Se houver alterações no arquivo, pergunta se quer salvar antes de fechar arquivo
set confirm

" Realiza o foco no local onde houve o click do mouse/touchpad
set mouse=a

" Adiciona o filename, que está sendo editado, no título do terminal
set title

" Mostra os 'line numbers'
set number

" Insere automaticamente a identação da linha anterior durante 'newlines'
set autoindent

" Mostra as teclas utilizadas nos commands, durante o 'normal mode'
set showcmd

" Usa '4 spaces' como tabulação, como default
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Redireciona o copiar do vim para o clipboard e vice-versa
set clipboard=unnamedplus

" Define a visualização de no-printable characters
" Semelhante ao 'cat -A' shell command
" tab:^I
" space:.
" eol:$
set listchars=trail:.,eol:$

" Serve para que o built-in terminal do vim abra no 'bottom'
set splitbelow

"
" Rotina de salvamento de session do vim
"
call PersistSession()

"
" Rotina de carregamento de session do vim
"
call LoadSession()








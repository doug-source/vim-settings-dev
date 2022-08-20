"
" Executa o command se ele existir
"
function! ExecCommand(comm_name, ...)
    let l:command = ':' . a:comm_name
    if exists(l:command)
        if len(a:000) > 0
            execute l:command . ' ' . join(a:000, ' ')
        else
            execute l:command
        endif
    else
        execute ':echo "The command does not exist"'
    endif
endfunction

"
" Function utilitária para inserir o carregamento do pathname, do arquivo de configuração de dentro
" da pasta '/sources', presente no clipboard, no arquivo '.vimrc'
"
function! InsertRefSourceLine()
    let l:pl_name = substitute(@+, '^\v[^/]+/[^/]+/(.+)\.vim', '\1', '')
    let l:doc = '" ******** ' . l:pl_name . ' settings ************************************'
    let l:file_path = substitute(@+, '^\.vim\/', '', '')
    -1 put= ''
    . put= l:doc
    . put= 'execute ''source '' . g:vi_dir . ''/' . l:file_path . ''''
endfunction

"
" Definição de function solicitada pela documentação do plugin coc.nvim
"
function! CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"
" Realiza o 'save session' no fechamento do Vim
"
function! PersistSession()
    if empty(glob(g:vi_dir . '/markers/.devRunning'))
        return
    endif
    autocmd VimLeave * NERDTreeTabsClose
    execute 'autocmd VimLeave * mksession! ' . g:vi_dir . '/.session.vim'
    " Remove o arquivo que sinaliza que o vim abriu em 'development cycle'
    if g:is_linux
        autocmd VimLeave * silent execute '!rm -f ' . g:vi_dir . '/markers/.devRunning'
    endif
endfunction

"
" Realiza o 'load session' na abertura do Vim
"
function! LoadSession()
    if empty(glob(g:vi_dir . '/markers/.devRunning'))
        return
    endif
    silent execute 'source ' . g:vi_dir . '/.session.vim'
    autocmd VimEnter * call NERDTreeCustomOpening()
endfunction

"
" Abre a NERDTree de uma forma customizada
"
function! NERDTreeCustomOpening()
    NERDTree | OpenBookmark editor
    wincmd p
endfunction


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


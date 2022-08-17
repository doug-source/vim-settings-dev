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


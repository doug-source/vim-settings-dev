"
" Object used to manage system commands
"
let g:Cmd = {}

" ======================
" Methods
" ======================

"
" Executes all initial running from this class
"
fun g:Cmd.init(App)
    let self.App = a:App
endfu

"
" Creates a new folder, changes the current working directory to it and executes
" a command line statement into it
"
fun g:Cmd.command_into_new_folder(pathname, cmd_statement)
    if !isdirectory(a:pathname)
        let s:cmd_1 = 'mkdir ' . a:pathname
        let s:cmd_2 = 'cd ' . a:pathname
        execute '! ' . join([s:cmd_1, s:cmd_2, a:cmd_statement], ' && ')
        return 1
    endif
    return 0
endfu

fun g:Cmd.execute(commands)
    " if type(commands)
endfu

"
" Removes the present file(s) into a:filepath argument and optionally echo a message (second parameter)
"
fun g:Cmd.remove_file(filepath, msg = v:null) abort
    let l:cmd = self.App.is_windows() ? 'del' : 'rm'
    if type(a:filepath) is v:t_list
        let a:filepath = join(a:filepath, ' ')
    endif
    silent execute '!' . l:cmd . ' ' . a:filepath
    if a:msg isnot v:null
        echo a:msg
    endif
endfunction

call g:App.register('Cmd', g:Cmd)

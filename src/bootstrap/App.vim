"
" Main Application
"
let g:App = { 'items': {} }

" ======================
" Constructor
" ======================
fun g:App.new()
    let l:instance = copy(self)
    let l:instance.items = {}
    let l:instance.vi_dir = g:App.get_vi_dir()
    let l:instance.menu_register = {}

    let g:App = l:instance
endfu

" ======================
" Methods
" ======================

"
" Defines if the Operational System is Windows
"
fun g:App.is_windows()
    return &term == "win32" || "pcterm" || has("gui_win32") || has('win32')
endfu

"
" Defines if the Operational System is Linux
"
fun g:App.is_linux()
    return !self.is_windows()
endfu

"
" Defines the vi directory path.
" Ensures this dirname path (user's home directory) is really the correct.
" Depending of the current working directory (cwd) from command line where vim is
" started, the commands pwd() and expand('%:p:h') return the cwd and not the
" user's home directory (that it is the directory most correct and required in
" this context and for being where is the vim's setting file)
"
fun g:App.get_vi_dir()
    return self.get_home() . (self.is_windows() ? '/vimfiles' : '/.vim')
endfu

"
" Defines the user's home directory path
"
fun g:App.get_home()
    if self.is_windows()
        return trim(system('for %%F in ("' . $MYVIMRC . '") do set dirname=%%~dpF & echo %dirname%'))
    endif
    return trim(system('dirname ' . $MYVIMRC))
endfu

"
" Execute the command if it exists
"
fun g:App.exec_command(comm_name, ...)
    let l:command = ':' . a:comm_name
    if exists(l:command)
        if len(a:000) > 0
            execute l:command . ' ' . join(a:000, ' ')
        else
            execute l:command
        endif
    else
        execute ':echo "The command does not exist: ' . a:comm_name . '"'
    endif
endfu

"
" Defines if the vi was started from terminal
" Ensures the vim does not started if 'development cycle flag number 1' is already been right
"
fun g:App.is_started_by_terminal()
    return filereadable(self.vi_dir . '/markers/.devRunning')
endfu

"
" Registers another object instance into App
"
fun g:App.register(global_variable_name, instance)
    let self.items[a:global_variable_name] = a:instance
    if has_key(a:instance, 'init')
        call a:instance.init(self)
    endif
    execute 'unlet g:' . a:global_variable_name
endfu

"
" Registers an action to be called to build an especific menu
"
fun g:App.register_menu_subject(key, data)
    let self.menu_register[a:key] = a:data
endfu

call g:App.new()

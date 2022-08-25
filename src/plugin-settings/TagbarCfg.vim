"
" Object used to manage tagbar configurations
"
let g:TagbarCfg = {}

" ======================
" Constructor
" ======================
fun g:TagbarCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:TagbarCfg.init(App)
    let self.App = a:App
endfu

" ======================
" Methods
" ======================

"
" Executes the custom setting
"
" @keymaps
"
fun g:TagbarCfg.define()
    " Open TagbarToogle window
    nnoremap <silent> <F8> :call g:App.exec_command('TagbarToggle')<CR>
endfunction

call g:App.register('TagbarCfg', g:TagbarCfg.new())

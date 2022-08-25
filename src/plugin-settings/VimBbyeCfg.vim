"
" Object used to manage vim-bbye configurations
"
let g:VimBbyeCfg = {}

" ======================
" Constructor
" ======================
fun g:VimBbyeCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:VimBbyeCfg.init(App)
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
fun g:VimBbyeCfg.define()
    "
    " Delete the buffer where the cursor is active
    "
    nnoremap q :call g:App.exec_command('Bdelete')<CR>
endfu

call g:App.register('VimBbyeCfg', g:VimBbyeCfg.new())

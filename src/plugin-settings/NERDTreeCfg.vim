"
" Object used to manage NERDTree configurations
"
let g:NERDTreeCfg = {}

" ======================
" Constructor
" ======================
fun g:NERDTreeCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:NERDTreeCfg.init(App)
    let self.App = a:App
endfu

" ======================
" Methods
" ======================

"
" Executes the custom setting
"
fun g:NERDTreeCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins.nerdtree
    call self.App.items.PluginManager.define_variables(l:plugin_cfg)

    call self.define_keymaps()
endfunction

"
" Defines the keymaps relative to NERDTree
" @keymaps
"
fun g:NERDTreeCfg.define_keymaps()
    " Keyboard-shortcut to NERDTree reload
    nnoremap çç :call g:App.exec_command('NERDTreeRefreshRoot')<CR>

    " Keyboard-shortcut to expand NERDTree's directory tree of file focused
    nnoremap <silent> ,t :call g:App.exec_command('NERDTreeFind')<CR>

    " Open/Close the current NERDTree's directory tree
    nnoremap <silent> ;;; :call g:App.exec_command('NERDTreeToggle')<CR>
endfu

call g:App.register('NERDTreeCfg', g:NERDTreeCfg.new())

"
" Object used to manage emmet-vim configurations
"
let g:EmmetVimCfg = {}

" ======================
" Constructor
" ======================
fun g:EmmetVimCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:EmmetVimCfg.init(App)
    let self.App = a:App
endfu

" ======================
" Methods
" ======================

"
" Executes the custom setting
"
" @autocmd
"
fun g:EmmetVimCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins['emmet-vim']
    call self.App.items.PluginManager.define_variables(l:plugin_cfg)

    "
    " Define Emmet to execute only specific extensions
    "
    execute 'autocmd FileType '
\       . get(l:plugin_cfg, 'file-types', 'html,css')
\       . ' inoremap <buffer> <silent> <C-K> <Esc>:call emmet#expandAbbr(0,"")<CR>==gi'
endfunction

call g:App.register('EmmetVimCfg', g:EmmetVimCfg.new())

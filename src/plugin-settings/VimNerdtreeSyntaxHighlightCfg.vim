"
" Object used to manage vim-nerdtree-syntax-highlight configurations
"
let g:VimNerdtreeSyntaxHighlightCfg = {}

" ======================
" Constructor
" ======================
fun g:VimNerdtreeSyntaxHighlightCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:VimNerdtreeSyntaxHighlightCfg.init(App)
    let self.App = a:App
endfu

" ======================
" Methods
" ======================

"
" Executes the custom setting
"
" @todo Transfer data to ConfigJson (configurations)
"
fun g:VimNerdtreeSyntaxHighlightCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins['vim-nerdtree-syntax-highlight']
    call self.App.items.PluginManager.define_variables(l:plugin_cfg)
endfu

call g:App.register('VimNerdtreeSyntaxHighlightCfg', g:VimNerdtreeSyntaxHighlightCfg.new())

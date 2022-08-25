"
" Object used to manage vim-markdown configurations
"
let g:VimMarkdownCfg = {}

" ======================
" Constructor
" ======================
fun g:VimMarkdownCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:VimMarkdownCfg.init(App)
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
fun g:VimMarkdownCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins['vim-markdown']
    call self.App.items.PluginManager.define_variables(l:plugin_cfg)
endfu

call g:App.register('VimMarkdownCfg', g:VimMarkdownCfg.new())

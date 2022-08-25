"
" Object used to manage vim-devicons configurations
"
let g:VimDeviconsCfg = {}

" ======================
" Constructor
" ======================
fun g:VimDeviconsCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:VimDeviconsCfg.init(App)
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
fun g:VimDeviconsCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins['vim-devicons']
    call self.App.items.PluginManager.define_variables(l:plugin_cfg)
endfu

call g:App.register('VimDeviconsCfg', g:VimDeviconsCfg.new())

"
" Object used to manage vim-airline configurations
"
let g:VimAirlineCfg = {}

" ======================
" Constructor
" ======================
fun g:VimAirlineCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:VimAirlineCfg.init(App)
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
fun g:VimAirlineCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins['vim-airline']
    call self.App.items.PluginManager.define_variables(l:plugin_cfg)
endfunction

call g:App.register('VimAirlineCfg', g:VimAirlineCfg.new())

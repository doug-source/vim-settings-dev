"
" Object used to manage vim-airline-themes configurations
"
let g:VimAirlineThemesCfg = {}

" ======================
" Constructor
" ======================
fun g:VimAirlineThemesCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:VimAirlineThemesCfg.init(App)
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
fun g:VimAirlineThemesCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins['vim-airline-themes']
    call self.App.items.PluginManager.define_variables(l:plugin_cfg)
endfunction

call g:App.register('VimAirlineThemesCfg', g:VimAirlineThemesCfg.new())

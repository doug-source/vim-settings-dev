"
" Object used to manage fixjson configurations
"
let g:FixjsonCfg = {}

" ======================
" Constructor
" ======================
fun g:FixjsonCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:FixjsonCfg.init(App)
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
fun g:FixjsonCfg.define()
    let l:data = self.App.items.ConfigJson.data
    if index(l:data.env.langs, 'json') == -1
        return
    endif

    if get(g:, 'ale_fixers', v:null) is v:null
        return
    endif
    let g:ale_fixers.json = []
    call self.App.items.PluginManager.run_fixers(l:data.env.settings.json.fixers, g:ale_fixers.json, l:data.env.plugins)
endfu

call g:App.register('FixjsonCfg', g:FixjsonCfg.new())

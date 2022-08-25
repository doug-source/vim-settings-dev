"
" Object used to manage fixjson configurations
"
let g:AlePhpCfg = {}

" ======================
" Constructor
" ======================
fun g:AlePhpCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:AlePhpCfg.init(App)
    let self.App = a:App
endfu

" ======================
" Methods
" ======================

"
" Executes the custom setting
"
fun g:AlePhpCfg.define()
    let l:data = self.App.items.ConfigJson.data
    if index(l:data.env.langs, 'php') == -1
        return
    endif
    if get(g:, 'ale_fixers', v:null) is v:null
        return
    endif
    let g:ale_fixers.php = ['trim_whitespace']
    call self.App.items.PluginManager.run_fixers(l:data.env.settings.php.fixers, g:ale_fixers.php, l:data.env.plugins)
endfu

call g:App.register('AlePhpCfg', g:AlePhpCfg.new())


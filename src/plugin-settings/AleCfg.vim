"
" Object used to manage ale configurations
"
let g:AleCfg = {}

" ======================
" Constructor
" ======================
fun g:AleCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:AleCfg.init(App)
    let self.App = a:App
endfu

" ======================
" Methods
" ======================

"
" Executes the custom setting
"
" @keymaps
" @todo Transfer data to ConfigJson (configurations)
"
fun g:AleCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins.ale
    call self.App.items.PluginManager.define_variables(l:plugin_cfg)

    call self.define_keymaps()
endfu

"
" Defines the keymaps relative to ale
" @keymaps
"
fun g:AleCfg.define_keymaps()
    "
    " Key-mapping to jump to the next error inside file
    "
    nmap <silent> <leader>z1 <Plug>(ale_next_wrap)
endfu

call g:App.register('AleCfg', g:AleCfg.new())

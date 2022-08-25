"
" Object used to manage nerdtree-git-plugin configurations
"
let g:NerdtreeGitPluginCfg = {}

" ======================
" Constructor
" ======================
fun g:NerdtreeGitPluginCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:NerdtreeGitPluginCfg.init(App)
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
fun g:NerdtreeGitPluginCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins['nerdtree-git-plugin']
    call self.App.items.PluginManager.define_variables(l:plugin_cfg)
endfu

call g:App.register('NerdtreeGitPluginCfg', g:NerdtreeGitPluginCfg.new())

"
" Object used to manage the NerdFonts installations
"
let g:NerdFontsRunner = {}

" ======================
" Constructor
" ======================
fun g:NerdFontsRunner.new()
    let l:instance = copy(self)
    return l:instance
endfu

" ======================
" Methods
" ======================

fun g:NerdFontsRunner.init(App)
    let self.App = a:App
endfu

"
" Execute the 'NERD fonts' installation (once time)
"
" @see https://github.com/ryanoasis/nerd-fonts
" @see https://docs.fedoraproject.org/en-US/quick-docs/fonts/
" @todo Transfer data to ConfigJson
"
fun g:NerdFontsRunner.install()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins['nerd-fonts']
    if self.App.is_linux()
        call self.App.items.PluginManager.bash_install(l:plugin_cfg.script . l:plugin_cfg.version)
    endif    
endfu

call g:App.register('NerdFontsRunner', g:NerdFontsRunner.new())

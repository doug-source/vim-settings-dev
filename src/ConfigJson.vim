"
" Object used to manage the external json configurations
"
let g:ConfigJson = {}

" ======================
" Constructor
" ======================
fun g:ConfigJson.new()
    if !has_key(g:App.items, 'ConfigJson')
        let l:instance = copy(self)
        return l:instance
    endif
    return get(g:App.items, 'ConfigJson', v:null)
endfu

" ======================
" Methods
" ======================

"
" Executes all initial running from this class
" @todo Transfer data to ConfigJson (pathname)
"
fun g:ConfigJson.init(App)
    " antigo config_path
    let self.path = a:App.vi_dir . '/markers/.config.json'
    " antigo obj_config
    let self.data = json_decode(!empty(glob(self.path)) ? join(readfile(self.path), '') : '{}')
    let self.App = a:App
    let l:swap_path = a:App.vi_dir . self.data.paths.swap
    let self.swap_base = json_decode(!empty(glob(l:swap_path)) ? join(readfile(l:swap_path), '') : '{}')
endfu

"
" Creates the flag file starting the 'development cycle flag number 1'
"
fun g:ConfigJson.update_config(key, value = v:null)
    let l:data = get(self, 'data', v:null)
    if l:data is v:null
        return
    endif
    if a:value is v:null
        call remove(l:data, a:key)
    else
        let l:data[a:key] = a:value
    endif
    call self.persist_config()
endfu

"
" Persists the object data as a json string to json pathname
"
fun g:ConfigJson.persist_config()
    call writefile([json_encode(self.data)], self.path)
    call self.format_config_json()
endfu

"
" Executes the json formating from the 'configuration json file' using the 'vim-fix-json'
"
fun g:ConfigJson.format_config_json()
    let l:paths = g:App.items.ConfigJson.data.paths
    let l:fixjsonPath = g:App.vi_dir . l:paths.executables . l:paths.fixjson
    if filereadable(l:fixjsonPath)
        let l:devNULL = self.App.is_windows() ? ' > NULL' : ' >/dev/null'
        silent execute '!' . l:fixjsonPath . ' --write -i 4 ' . self.path . l:devNULL
    endif
endfu

"
" Defines if the application alreary was running
" Ensures the vim does not started if 'development cycle flag number 2' is not already been right
"
fun g:ConfigJson.is_running()
    return has_key(self.data, 'running') && self.data.running == 1
endfu

call g:App.register('ConfigJson', g:ConfigJson.new())


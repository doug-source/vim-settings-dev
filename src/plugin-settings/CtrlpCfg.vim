"
" Object used to manage ctrlp configurations
"
let g:CtrlpCfg = {}

" ======================
" Constructor
" ======================
fun g:CtrlpCfg.new()
    let l:instance = copy(self)
    let l:instance.vars = {
    \  'g:ctrlp_buffer_func': '{ ''enter'': { -> g:App.items.CtrlpCfg.ctrl_mapping_delete_buffer() } }'
    \}
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:CtrlpCfg.init(App)
    let self.App = a:App
endfu

" ======================
" Methods
" ======================

"
" Register the keymap to trigger the delete_buffer function
" @keymaps
"
fun g:CtrlpCfg.ctrl_mapping_delete_buffer()
    nnoremap <buffer> <silent> <C-@> :call g:App.items.CtrlpCfg.delete_buffer()<cr>
endfu

"
" Function with a Buffer line deletion logic used by CtrlP plugin
"
" @link https://gist.github.com/rainerborene/8074898
"
fun g:CtrlpCfg.delete_buffer()
  let path = fnamemodify(getline('.')[2:], ':p')
  let bufn = matchstr(path, '\v\d+\ze\*No Name')
  exec "bd" bufn ==# "" ? path : bufn
  exec "norm \<F5>"
endfu

"
" Executes the custom setting
"
fun g:CtrlpCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins.ctrlp
    call self.App.items.PluginManager.define_variables(l:plugin_cfg, self.vars)

    call self.define_keymaps()
endfu

"
" Defines the keymaps relative to ctrlp
" @keymaps
"
fun g:CtrlpCfg.define_keymaps()
    " Trigger the file search from Buffer panel
    nnoremap b :call g:App.exec_command('CtrlPBuffer')<cr>
endfu

call g:App.register('CtrlpCfg', g:CtrlpCfg.new())

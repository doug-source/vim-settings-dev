"
" Object used to manage phpactor configurations
"
let g:PhpactorCfg = {}

" ======================
" Constructor
" ======================
fun g:PhpactorCfg.new()
    let l:instance = copy(self)
    let l:instance.key = 'PhpactorCfg'
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:PhpactorCfg.init(App)
    let self.App = a:App
    call a:App.register_menu_subject(self.key, #{ check: { -> self.check() }, action: { -> self.build_menu() } })
endfu

" ======================
" Methods
" ======================

"
" Defines if the file when requesting the quickmenu is from php extension
"
fun g:PhpactorCfg.check()
    echo &filetype
    return &filetype == 'php'
endfu

"
" Executes the custom setting
"
" @autocmd
"
fun g:PhpactorCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins['phpactor']
    call self.App.items.PluginManager.define_variables(l:plugin_cfg)

    " nnoremap <silent><F7> :call g:quickmenu#toggle(0)<CR>
    " autocmd FileType php nnoremap <silent> <F7> :call g:quickmenu#toggle(g:App.items.VimPhpRefactoringToolboxCfg.quickmenu_mid)<CR>

    " nnoremap <silent><F7> :call g:quickmenu#toggle(g:App.items.VimPhpRefactoringToolboxCfg.quickmenu_mid)<CR>
    " autocmd FileType php nnoremap <silent><leader>pm3 :call g:App.items.PhpactorCfg.php_modify("implement_contracts")<CR>
endfu

"
" Executes the phpactor submenu creation
"
fun g:PhpactorCfg.build_menu()
    call g:quickmenu#header('Phpactor')
    call g:quickmenu#append('Add missing properties', ':call phpactor#Transform(''add_missing_properties'')')
    call g:quickmenu#append('Complete constructor', ':call phpactor#Transform(''complete_constructor'')')
    call g:quickmenu#append('Implement contracts', ':call phpactor#Transform(''implement_contracts'')')
    call g:quickmenu#append('Change visibility', ':call phpactor#ChangeVisibility()')
    call g:quickmenu#append('Extract expression', ':call phpactor#ExtractExpression()')
    call g:quickmenu#append('Extract method', ':call phpactor#ExtractMethod()')
    call g:quickmenu#append('Copy file', ':call phpactor#CopyFile()')
    call g:quickmenu#append('Context Menu', ':PhpactorContextMenu')
endfu

let s:instance = g:PhpactorCfg.new()

call g:App.register(s:instance.key, s:instance)
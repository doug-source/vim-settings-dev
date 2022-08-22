" 
" Custom setting for Emmet plugin
"
let g:user_emmet_install_global = 0
"
" Define Emmet to execute only specific extensions
"
autocmd FileType html,css EmmetInstall
"
" Custom keymap to trigger Emmet
"
let g:user_emmet_leader_key='<C-K>'

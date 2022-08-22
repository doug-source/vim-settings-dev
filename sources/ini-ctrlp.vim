" ******** custom functions loading ************************************
execute 'source ' . g:vi_dir . '/sources/run-functions.vim'

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0

" Trigger the file search from Buffer panel
nnoremap b :call ExecCommand('CtrlPBuffer')<cr>

" CtrlP does not clean the cache when exit from vim
let g:ctrlp_clear_cache_on_exit = 0

" Use the file directory from current file during search
let g:ctrlp_working_path_mode = 'c'

" ******** Custom functions loading ************************************
execute 'source ' . g:vi_dir . '/sources/run-functions.vim'

" Preserve the 'Natural sort' of directory and files
let NERDTreeNaturalSort=1
" Show 'hidden files'
let NERDTreeShowHidden=1

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="-"

" Keyboard-shortcut to NERDTree reload
nnoremap çç :call ExecCommand('NERDTreeRefreshRoot')<CR>

" Keyboard-shortcut to expand NERDTree's directory tree of file focused
nnoremap <silent> ,t :call ExecCommand('NERDTreeFind')<CR>

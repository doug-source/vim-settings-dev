" ******** Loading das custom functions ************************************
execute 'source ' . g:vi_dir . '/sources/run-functions.vim'

" Preserva a 'Natural sort' na ordenação dos arquivos e folders
let NERDTreeNaturalSort=1
" Mostra 'hidden files'
let NERDTreeShowHidden=1

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="-"

" Keyboard-shortcut para a reload do NERDTree
nnoremap çç :call ExecCommand('NERDTreeRefreshRoot')<CR>

" Keyboard-shortcut para a expand NERDTree no arquivo que está ativo
nnoremap <silent> ,t :call ExecCommand('NERDTreeFind')<CR>


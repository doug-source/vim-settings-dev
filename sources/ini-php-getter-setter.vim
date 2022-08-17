execute 'source ' . g:vi_dir . '/sources/run-functions.vim'

nnoremap g :call ExecCommand('InsertGetterOnly')<cr>
vnoremap g :call ExecCommand('InsertGetterOnly')<cr>

nnoremap s :call ExecCommand('InsertSetterOnly')<cr>
vnoremap s :call ExecCommand('InsertSetterOnly')<cr>

nnoremap gs :call ExecCommand('InsertBothGetterSetter')<cr>
vnoremap gs :call ExecCommand('InsertBothGetterSetter')<cr>

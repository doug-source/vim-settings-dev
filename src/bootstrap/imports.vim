
" Load only the App class
execute 'runtime src/bootstrap/App.vim'

if !g:App.is_started_by_terminal()
    finish
endif

let s:pathnames = split(glob(g:App.vi_dir . '/src/*.vim'), '\n')

call filter(s:pathnames, 'v:val !~ "/src/ConfigJson.vim"')

" Load only the ConfigJson class
execute 'source ' . g:App.vi_dir . '/src/ConfigJson.vim'

if g:App.items.ConfigJson.is_running()
    finish
endif

" Load the remain
for file in s:pathnames
    execute 'source ' . file
endfor
for file in split(glob(g:App.vi_dir . '/src/plugin-settings/*.vim'), '\n')
    execute 'source ' . file
endfor

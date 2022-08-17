" bash interpreter
let s:interpreter = '/bin/bash'
" skeletors folder
let s:skels_dir = g:vi_dir . '/skel'

" Carrega em todos os novos arquivos de extensão '.html', um template com 
" a a HTML markup básica
autocmd BufNewFile *.html execute '0r ' . s:skels_dir . '/skel.html' 
" Carrega em todos os novos arquivos de extensão '.sh', um template com a
" shebang na primeira linha do script (no caso de Linux-type system)
if g:is_linux
    autocmd BufNewFile *.sh 0put = '#!' . s:interpreter . nr2char(10) . nr2char(10)
endif

" Carrega em todos os novos arquivos de extensão '.html', um template com 
" a a HTML markup básica
autocmd BufNewFile *.php execute '0r ' . s:skels_dir . '/skel.php' 

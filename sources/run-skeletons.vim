" bash interpreter
let s:interpreter = '/bin/bash'
" skeletors folder
let s:skels_dir = g:vi_dir . '/skel'

" Load, every new files with .html extension, a template with 
" the basic HTML markup (version 5)
autocmd BufNewFile *.html execute '0r ' . s:skels_dir . '/skel.html' 

" Load, every new files with '.sh' extension, a template with
" shebang in the first line of scrip (in case Linux-type system)
if g:is_linux
    autocmd BufNewFile *.sh 0put = '#!' . s:interpreter . nr2char(10) . nr2char(10)
endif

" Load, every new files with '.php', a template with PHP's opening tags (only)
autocmd BufNewFile *.php execute '0r ' . s:skels_dir . '/skel.php'

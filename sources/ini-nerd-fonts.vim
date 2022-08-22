" ----------------------------------------------------------------
"
"  Execute the 'NERD fonts' installation (once time)
"
"  URL: https://github.com/ryanoasis/nerd-fonts
"  URL: https://docs.fedoraproject.org/en-US/quick-docs/fonts/
"
" ----------------------------------------------------------------

let s:font_version = 'v3.003'

if g:is_linux
    silent execute '!' . g:vi_dir . '/scripts/loadNerdfonts.sh ' . g:vi_dir . ' ' . s:font_version  
endif


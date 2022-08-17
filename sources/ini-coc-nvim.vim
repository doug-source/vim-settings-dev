
" Keyboard shortcut para utilização da 'TAB key' para seleção de autocomplete
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"

" Keyboard shortcut para utilização da 'Ctrl+space' para seleção de autocomplete
inoremap <silent><expr> <C-@> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"

" ---------------------------------------------------------------------------
"
" Para visualizar as extensions instaladas do coc.nvim:
" - :CocList extensions
"
" Para instalar novas Coc.nvim extensions:
" - :CocInstall extension-name
"
" Para remover Coc.nvim extensions:
" - :CocUninstall extension-name
"
" ---------------------------------------------------------------------------
"
" Extensions instaladas até o momento
" + coc-html
" + coc-ts-server
" + coc-sh
" + coc-phpls
" + coc-json
" + coc-css
"

" 
" The custom keymap from default Coc commands
"
nnoremap <silent> <leader>iw :CocCommand intelephense.index.workspace<cr> 
nnoremap <silent> <leader>ci :CocCommand intelephense.cancel.indexing<cr>
nnoremap <silent> <leader>cr :CocCommand intelephense.composer.runCommand<cr>
nnoremap <silent> <leader>crp :CocCommand intelephense.composer.runCommandPlus<cr>
nnoremap <silent> <leader>rsc :CocCommand intelephense.composer.runScriptCommand<cr>
nnoremap <silent> <leader>ar :CocCommand intelephense.artisan.runCommand<cr> 
nnoremap <silent> <leader>sr :CocCommand intelephense.symfony.runCommand<cr> 
nnoremap <silent> <leader>1pt :CocCommand intelephense.phpunit.projectTest<cr> 
nnoremap <silent> <leader>1ft :CocCommand intelephense.phpunit.fileTest<cr> 
nnoremap <silent> <leader>2pt :CocCommand intelephense.pest.projectTest<cr> 
nnoremap <silent> <leader>2ft :CocCommand intelephense.pest.fileTest<cr> 
nnoremap <silent> <leader>2st :CocCommand intelephense.pest.singleTest<cr> 
nnoremap <silent> <leader>fcn :CocCommand intelephense.fixClassName<cr> 
nnoremap <silent> <leader>fn :CocCommand intelephense.fixNamespace<cr> 
nnoremap <silent> <leader>cc :CocCommand intelephense.completeConstructor<cr> 

nnoremap <silent> <leader>pm1 <Plug>(coc-codeaction-line)
nnoremap <silent> <leader>pm2 <Plug>(coc-codeaction-cursor)

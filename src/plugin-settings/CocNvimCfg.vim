"
" Object used to manage coc-nvim configurations
"
let g:CocNvimCfg = {}

" ======================
" Constructor
" ======================
fun g:CocNvimCfg.new()
    let l:instance = copy(self)
    return l:instance
endfu

"
" Executes all initial running from this class
"
fun g:CocNvimCfg.init(App)
    let self.App = a:App
endfu

" ======================
" Methods
" ======================

"
" Function definition requested for coc.nvim plugin documentation
"
fun g:CocNvimCfg.check_back_space()
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfu

"
" Function definition requested for coc.nvim plugin documentation
"
fun g:CocNvimCfg.show_documentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfu

"
" Executes the custom setting
"
" @autocmd
" @keymaps
" @todo Transfer data to ConfigJson (configurations)
"
fun g:CocNvimCfg.define()
    let l:plugin_cfg = self.App.items.ConfigJson.data.env.plugins['coc-nvim']
    call self.App.items.PluginManager.define_variables(l:plugin_cfg)

    call self.define_keymaps()

    call self.define_autocommands()

    call self.redefine_commands()

    let l:options = self.App.items.ConfigJson.data.env.plugins['coc-nvim'].options
    for val in l:options.set
        execute 'set ' . val
    endfor
endfu

"
" Defines the keymaps relative to coc-nvim
"
fun g:CocNvimCfg.define_autocommands()
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end
endfu

"
" Defines the keymaps relative to coc-nvim
" @keymaps
"
fun g:CocNvimCfg.define_keymaps()
    " Keyboard shortcut to using of 'TAB key' to autocomplete selection
    inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() :
        \ coc#pum#visible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ?
        \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ g:App.items.CocNvimCfg.check_back_space() ? "\<TAB>" :
        \ coc#refresh()

    " Keyboard shortcut to using of 'Ctrl+space' to autocomplete selection
    inoremap <silent><expr> <C-@> coc#pum#visible() ? coc#pum#confirm() : "\<C-@>"

    " Keyboard shortcut to using of 'Enter' to autocomplete selection
    inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

    " ===================================================================================

    " GoTo code navigation.
    nnoremap <silent> gd <Plug>(coc-definition)
    nnoremap <silent> gy <Plug>(coc-type-definition)
    nnoremap <silent> gi <Plug>(coc-implementation)
    nnoremap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call g:App.items.CocNvimCfg.show_documentation()<CR>

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    nmap <leader>fs <Plug>(coc-format-selected)
    vmap <leader>fs <Plug>(coc-format-selected)

    " Applying codeAction to the selected region.
    " Example: `<leader>a` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Run the Code Lens action on the current line.
    nmap <leader>cl  <Plug>(coc-codelens-action)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
        nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
        vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>

    " Manage extensions.
    nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>

    " Show commands.
    nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>

    " Find symbol of current document.
    nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>

    " Search workspace symbols.
    nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

    " Do default action for next item.
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>

    " Do default action for previous item.
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>

    " Resume latest coc list.
    nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

    " Open the options menu version 1
    nnoremap <silent> <leader>pm1 <Plug>(coc-codeaction-line)

    " Open the options menu version 2
    nnoremap <silent> <leader>pm2 <Plug>(coc-codeaction-cursor)
endfu

"
" Redefines some commands
"
fun g:CocNvimCfg.redefine_commands()
    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocActionAsync('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call CocActionAsync('runCommand', 'editor.action.organizeImport')
endfu

call g:App.register('CocNvimCfg', g:CocNvimCfg.new())

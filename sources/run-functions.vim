"
" Execute the command if it exists 
"
function! ExecCommand(comm_name, ...)
    let l:command = ':' . a:comm_name
    if exists(l:command)
        if len(a:000) > 0
            execute l:command . ' ' . join(a:000, ' ')
        else
            execute l:command
        endif
    else
        execute ':echo "The command does not exist"'
    endif
endfunction

"
" Utility method to insert the pathname loading text of settings file existing inside
" '/sources' directory, from clipboard, into '.vimrc' file
"
function! InsertRefSourceLine()
    let l:pl_name = substitute(@+, '^\v[^/]+/[^/]+/(.+)\.vim', '\1', '')
    let l:doc = '" ******** ' . l:pl_name . ' settings ************************************'
    let l:file_path = substitute(@+, '^\.vim\/', '', '')
    -1 put= ''
    . put= l:doc
    . put= 'execute ''source '' . g:vi_dir . ''/' . l:file_path . ''''
endfunction

"
" Function definition requested for coc.nvim plugin documentation
"
function! CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"
" Execute the 'save session' in Vim closing
"
function! PersistSession()
    if empty(glob(g:vi_dir . '/markers/.devRunning'))
        return
    endif
    autocmd VimLeave * call ExecCommand('NERDTreeTabsClose')
    execute 'autocmd VimLeave * mksession! ' . g:vi_dir . '/.session.vim'
    " Remove o arquivo que sinaliza que o vim abriu em 'development cycle'
    if g:is_linux
        autocmd VimLeave * silent execute '!rm -f ' . g:vi_dir . '/markers/.devRunning'
    endif
endfunction

"
" Execute the 'load session' in Vim opening
"
function! LoadSession()
    if empty(glob(g:vi_dir . '/markers/.devRunning'))
        return
    endif
    let l:session_filepath = g:vi_dir . '/.session.vim'
    if empty(glob(l:session_filepath))
        autocmd VimEnter * call NERDTreeCustomOpening()
        return
    endif
    " ----------------------------------------------
    " To cases that vim persist its session file
    " in the wrong way causing loading errors
    " ----------------------------------------------
    try
        silent execute 'source ' . l:session_filepath
    catch /.*/
        let l:cmd = g:is_windows ? 'del' : 'rm'
        silent execute '!' . l:cmd . ' ' . l:session_filepath
        echo 'Error during the loading of vim''s session file!'
    endtry
    autocmd VimEnter * call NERDTreeCustomOpening()
endfunction

"
" Returns the 'NERDTree bookmark name' defined into bookmarkActive file, or a 'v:null' value
"
function! PickBookmark()
    let l:bookmarkFilepath = g:vi_dir . '/markers/bookmarkActive'
    if empty(glob(l:bookmarkFilepath))
        return v:null
    endif
    return trim(join(readfile(l:bookmarkFilepath), ''))
endfunction

"
" Open NERDTree in a custom way
"
function! NERDTreeCustomOpening()
    if !exists(':NERDTree')
        return
    endif
    let l:bookmark = PickBookmark()
    if l:bookmark is v:null || !g:NERDTreeBookmark.BookmarkExistsFor(l:bookmark)
        NERDTree
    else
        execute 'NERDTree | OpenBookmark ' . l:bookmark 
    endif
    wincmd p
endfunction


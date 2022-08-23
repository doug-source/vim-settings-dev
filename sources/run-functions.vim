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
    autocmd VimLeave * call ExecCommand('NERDTreeTabsClose')
    execute 'autocmd VimLeave * mksession! ' . g:vi_dir . '/.session.vim'
    " Remove the file that signals that vim externally started the 'development cycle flag number 1'
    autocmd VimLeave * call RemoveFile(g:vi_dir . '/markers/.devRunning')
    " Remove the file that signals that vim internally started the 'development cycle flag number 2'
    autocmd VimLeave * call RemoveFile(g:vi_dir . '/markers/.vimRunning')
endfunction

"
" Execute the 'load session' in Vim opening
"
function! LoadSession()
    call CreateVimOpenMarker(g:vi_dir)
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
        call RemoveFile(l:session_filepath, 'Error during the loading of vim''s session file!')
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

"
" Register the keymap to trigger the DeleteBuffer function
"
" Used by:
"   - sources/ini-ctrlp.vim
"
function! CtrlPMappings()
    nnoremap <buffer> <silent> <C-@> :call DeleteBuffer()<cr>
endfunction

"
" Function with a Buffer line deletion logic used by CtrlP plugin
"
" @link https://gist.github.com/rainerborene/8074898
"
function! DeleteBuffer()
  let path = fnamemodify(getline('.')[2:], ':p')
  let bufn = matchstr(path, '\v\d+\ze\*No Name')
  exec "bd" bufn ==# "" ? path : bufn
  exec "norm \<F5>"
endfunction

"
" Creates the flag file starting the 'development cycle flag number 1'
"
function! CreateVimOpenMarker(vim_dir) abort
    let l:cmd = g:is_windows ? 'echo ' : 'echo -e '
    silent execute '!' . l:cmd . '''\nProjects structure loaded\!\n'' > ' . a:vim_dir . '/markers/.vimRunning'
endfunction

"
" Removes the present file(s) into a:filepath argument and optionally echo a message (second parameter)
"
function RemoveFile(filepath, ...) abort
    let l:cmd = g:is_windows ? 'del' : 'rm'
    if type(a:filepath) is v:t_list
        let a:filepath = join(a:filepath, ' ')
    endif
    silent execute '!' . l:cmd . ' ' . a:filepath
    if a:0 == 2
        echo a:2
    endif
endfunction

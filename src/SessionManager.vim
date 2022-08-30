"
" Object used to manage the external json configurations
"
let g:SessionManager = {}

" ======================
" Constructor
" ======================
fun g:SessionManager.new()
    if !has_key(g:App.items, 'SessionManager')
        let l:instance = copy(self)
        return l:instance
    endif
    return get(g:App.items, 'SessionManager', v:null)
endfu

" ======================
" Methods
" ======================

"
" Executes all initial running from this class
"
fun g:SessionManager.init(App)
    let self.App = a:App
endfu

"
" Execute the 'load session' in Vim opening
" @autocmd
"
fun g:SessionManager.load_session()
    let l:data = self.App.items.ConfigJson.data

    call self.App.items.ConfigJson.update_config('running', 1)
    let l:bookmark = get(l:data, 'bookmark', v:null)

    if l:bookmark isnot v:null
        let l:bookmark = '''' . l:bookmark . ''''
    endif

    let l:session_filepath = self.App.vi_dir . l:data.paths.session
    if empty(glob(l:session_filepath))
        execute 'autocmd VimEnter * call g:App.items.SessionManager.NERDTree_custom_opening(' . l:bookmark . ')'
        return
    endif

    " ----------------------------------------------
    " To cases that vim persist its session file
    " in the wrong way causing loading errors
    " ----------------------------------------------
    try
        silent execute 'source ' . l:session_filepath
    catch /.*/
        call self.App.items.Cmd.remove_file(l:session_filepath, 'Error during the loading of vim''s session file!')
    endtry
    execute 'autocmd VimEnter * call g:App.items.SessionManager.NERDTree_custom_opening(' . l:bookmark . ')'
endfu

"
" Execute the 'save session' in Vim closing
" @autocmd
" @todo Transfer data to ConfigJson (pathname)
"
fun g:SessionManager.persist_session()
    let l:data = self.App.items.ConfigJson.data
    autocmd VimLeave * call g:App.items.SessionManager.close_explorer()
    execute 'autocmd VimLeave * mksession! ' . self.App.vi_dir . l:data.paths.session
    " Remove the file that signals that vim externally started the 'development cycle flag number 1'
    execute 'autocmd VimLeave * call g:App.items.Cmd.remove_file(''' . self.App.vi_dir . '/markers/.devRunning'')'
    " Remove the signal that vim internally started the 'development cycle flag number 2'
    execute 'autocmd VimLeave * call g:App.items.ConfigJson.update_config(''running'')'
endfu

"
" Close the NERDTree's explorer if it is open
"
fun g:SessionManager.close_explorer()
    if exists('g:NERDTree') && g:NERDTree.IsOpen()
        call self.App.exec_command('NERDTreeClose')
    endif
endfu

"
" Open NERDTree in a custom way
"
fun g:SessionManager.NERDTree_custom_opening(bookmark)
    if !exists(':NERDTree')
        return
    endif
    if a:bookmark is v:null || !g:NERDTreeBookmark.BookmarkExistsFor(a:bookmark)
        NERDTree
    else
        execute 'NERDTree | OpenBookmark ' . a:bookmark
    endif
    wincmd p
endfu

call g:App.register('SessionManager', g:SessionManager.new())

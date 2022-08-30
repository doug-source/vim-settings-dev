"
" Object used to manage the vim's initial default settings
"
let g:SettingsDefaultRunner = {}

" ======================
" Constructor
" ======================
fun g:SettingsDefaultRunner.new()
    if !has_key(g:App.items, 'SettingsDefaultRunner')
        let l:instance = copy(self)
        return l:instance
    endif
    return get(g:App.items, 'SettingsDefaultRunner', v:null)
endfu

" ======================
" Methods
" ======================

"
" Executes all initial running from this class
"
fun g:SettingsDefaultRunner.init(App)
    let self.App = a:App
    let l:options = a:App.items.ConfigJson.data.env.settings.options

    for val in l:options.set
        execute 'set ' . val
    endfor

    execute 'colorscheme ' . l:options.colorscheme
    execute 'highlight Comment cterm=' . l:options.highlight.Comment.cterm
endfu

"
" Executes all initial methods relative to session management
" @todo Transfer data to ConfigJson (pathname)
"
fun g:SettingsDefaultRunner.dispatch_session()
    if !empty(glob(self.App.vi_dir . '/markers/.devRunning'))
        "
        " Session loading routine from vim
        "
        call self.App.items.SessionManager.load_session()

        "
        " Session saving routine from vim
        "
        call self.App.items.SessionManager.persist_session()
    endif
    return self
endfu

"
" Defines all custom native keymaps
" @keymaps
"
fun g:SettingsDefaultRunner.load_custom_remaps()
    " Nota:
    " To verify which shortcuts already were mapped, use the following command:
    " :verbose map shortcut
    " :verbose imap shortcut
    " :verbose vmap shortcut

    " Keyboard shortcut to tab switch from NERDTree
    " This uses only right-to-left sense
    nnoremap <silent>  :bnext<CR>

    " Keyboard shortcut to tab switch in right-to-left sense (split-windows)
    " Ctrl-w-w does it on opposite way
    nnoremap <silent> <C-q> <c-w>h

    " Remove the editor's text highlight after the search
    " The space key does it
    :nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

    " Moviment of entire lines to up or to down
    " mode: normal, insert, visual
    " source: Sublime-text
    nnoremap <C-Down> :m .+1<CR>==
    nnoremap <C-Up> :m .-2<CR>==
    inoremap <C-Down> <Esc>:m .+1<CR>==gi
    inoremap <C-Up> <Esc>:m .-2<CR>==gi
    vnoremap <C-Down> :m '>+1<CR>gv=gv
    vnoremap <C-Up> :m '<-2<CR>gv=gv

    " Start a 'multiple-edition' using a search on the word from cursor,
    " removing the word e staying waiting the edition.
    " Next steps: Press Esc key and press n to go until next
    " 'matched word' and (optional) press . to apply the edition
    nnoremap <silent> <C-d> /<C-r><C-w><cr><S-n>cgn

    " Open a new tab visualizing the 'file explorer' in user's home directory
    nnoremap <S-t> :Tex ~<cr>

    " Keyboard-shortcut to auto-load operation from .vimrc and from NERDTree
    nnoremap <C-s> :source $MYVIMRC<cr>

    " Keyboard-shortcut to copy to clipboard the full pathname from active file
    nnoremap <silent> fp :let @+=@%<cr>

    " -------------------------------------------------------------------------------------------------------
    "
    " The 'c+d' keyboard-shortcut cause the passing of NERDTree directory tree's node's basename with focus
    " to NERDTree's CWD variable
    "
    " The Keyboard-shortcut below opens the vim's buit-in terminal
    "
    " -------------------------------------------------------------------------------------------------------
    nnoremap <silent> t :term<cr>

    "
    " Save the file edited in the vim
    " (Ctrl+Shift+s)
    "
    nnoremap <silent> <c-S> :w<cr>

    "
    " Removes the Ctrl-z
    " Ctrl-z executes the vim's abort that exit with the markers' remotion required
    "
    nnoremap <C-z> <Nop>
    inoremap <C-z> <Nop>
    vnoremap <C-z> <Nop>
endfu

"
" Load all basic template used by new files created by vi
" @autocmd
" @todo Transfer data to ConfigJson (pathname)
"
fun g:SettingsDefaultRunner.run_skeletons()
    " bash interpreter
    let s:interpreter = '/bin/bash'
    " skeletors folder
    let s:skels_dir = self.App.vi_dir . '/skel'

    " Load, every new files with .html extension, a template with
    " the basic HTML markup (version 5)
    autocmd BufNewFile *.html execute '0r ' . s:skels_dir . '/skel.html'

    " Load, every new files with '.sh' extension, a template with
    " shebang in the first line of scrip (in case Linux-type system)
    if self.App.is_linux()
        autocmd BufNewFile *.sh 0put = '#!' . s:interpreter . nr2char(10) . nr2char(10)
    endif

    " Load, every new files with '.php', a template with PHP's opening tags (only)
    autocmd BufNewFile *.php execute '0r ' . s:skels_dir . '/skel.php'
endfu

call g:App.register('SettingsDefaultRunner', g:SettingsDefaultRunner.new())

"
" Initial loading of Vim's Plug
"
let s:plug_filename = g:vi_dir . '/autoload/plug.vim'
if empty(glob(s:plug_filename))
    let s:commands =<< trim END
        !curl -fLo
        DATADIR
        --create-dirs
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
END
    let s:commands[1] = s:plug_filename
    silent execute join(s:commands, ' ')
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

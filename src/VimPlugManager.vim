"
" Object used to manage the Vim's Plug's installations
"
let g:VimPlugManager = {}

" ======================
" Constructor
" ======================
fun g:VimPlugManager.new()
    let l:instance = copy(self)
    return l:instance
endfu

" ======================
" Methods
" ======================

fun g:VimPlugManager.init(App)
    let self.App = a:App
endfu

"
" Initial instalation of Vim's Plug
" @autocmd
" @todo Transfer data to ConfigJson
"
fun g:VimPlugManager.install()
    let s:plug_filename = self.App.vi_dir . '/autoload/plug.vim'
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
endfu

fun g:VimPlugManager.build_plugins_path()
    let l:data = self.App.items.ConfigJson.data
    if has('nvim')
        return stdpath('data') . l:data.paths['vim-plug']
    endif
    return self.App.vi_dir . l:data.paths['vim-plug']
endfu

"
" Installs all plugins managed by Vim-Plug 
" @todo Transfer data to ConfigJson
fun g:VimPlugManager.load_plugins()
    let l:data = self.App.items.ConfigJson.data
    call plug#begin(self.build_plugins_path())
        for package in l:data['vim-plug'].plugins
            if type(package) is v:t_list
                execute 'Plug ''' . join(package, ''' | Plug ''') . ''''
            elseif type(package) is v:t_dict
                execute 'Plug ''' . package.pack . ''', ' . string(package.cfg)
            else
                execute 'Plug ''' . package . ''''
            endif
        endfor
    call plug#end()
endfu

call g:App.register('VimPlugManager', g:VimPlugManager.new())

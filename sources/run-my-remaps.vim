" Nota:
" To verify which shortcuts already were mapped, use the following command:
" :verbose map shortcut
" :verbose imap shortcut
" :verbose vmap shortcut

" Keyboard shortcut to tab switch from NERDTree
" This uses only right-to-left sense
nnoremap <silent>  :bnext<CR>

" Open/Close the current NERDTree's directory tree
nnoremap ;;; :NERDTreeToggle<CR>

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

" Automatically close the parentheses and bracket (square)
" in insert mode
imap ( ()<left>
imap [ []<left>

" Keyboard-shortcut to auto-load operation from .vimrc and from NERDTree
nnoremap <C-s> :source ~/.vimrc<cr>

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

" Insert the setting file's loading from some plugin pre-copied on the clipboard into '.vimrc'
" More information: sources/run-functions.vim
nnoremap <silent> rf :call InsertRefSourceLine()<cr>

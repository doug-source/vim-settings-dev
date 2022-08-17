" Nota:
" Para verificar quais atalhos já foram mapeados, utilize o seguinte comando:
" :verbose map shortcut
" :verbose imap shortcut
" :verbose vmap shortcut

" Keyboard shortcut para os commands de troca de aba do NERDTree
" Usa somente o sentido right-to-left
nnoremap <silent>  :bnext<CR>

" Fecha o buffer onde o cursor esteja ativo
nnoremap .. :bd<CR>
" Abre/Fecha o NERDTree no directory atual
nnoremap ;;; :NERDTreeToggle<CR>

" Shortcut para trocar right-to-left em split-windows
" Ctrl-w-w faz isso no sentido contrário
nnoremap <silent> <C-q> <c-w>h

" Remove o text highlight do editor após o search
" A tecla 'space' faz isso
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Movimento de linhas inteiras para cima ou para baixo
" mode: normal, insert, visual
" source: Sublime-text
nnoremap <C-Down> :m .+1<CR>==
nnoremap <C-Up> :m .-2<CR>==
inoremap <C-Down> <Esc>:m .+1<CR>==gi
inoremap <C-Up> <Esc>:m .-2<CR>==gi
vnoremap <C-Down> :m '>+1<CR>gv=gv
vnoremap <C-Up> :m '<-2<CR>gv=gv

" Inicia uma 'multiple-edition' usando um search na word sob o cursor,
" removendo a word e ficando no aguardo da edição.
" Próximos passos: Aperte Esc e aperte n para ir até a próxima
" 'matched word' e (opcional) aperte . para aplicar a edição
nnoremap <C-d> /<C-r><C-w><cr><S-n>cgn

" Abre uma aba nova visualizando o 'file explorer' no 'home directory' do user
nnoremap <S-t> :Tex ~<cr>

" Fecha automaticamente braches, parentheses e bracket (square)
" no insert mode
imap { {}<left>
imap ( ()<left>
imap [ []<left>

" Keyboard-shortcut para a auto-load do .vimrc e do NERDTree
nnoremap <C-s> :source ~/.vimrc<cr>










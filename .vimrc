" retarded bell
set belloff=all

" tabshit
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartcase

" dont flood with my dirs with shit
set undofile
set undodir=/tmp//
set backupdir=/tmp//
set directory=/tmp//

" cursor static
set guicursor+=a:blinkon0
set guicursor+=a:block-Cursor

" mouse
set mouse=a

" no autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" **** binds ****
" system register
nnoremap <c-p> "+p
nnoremap <c-y> "+y
vnoremap <c-p> "+p
vnoremap <c-y> "+y
" easier indenting
nnoremap > >>
nnoremap < <<

" This is only necessary if you use "set termguicolors".
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" style
set guifont=Consolas\ 12
set guioptions-=T
set termguicolors
colorscheme quiet

syntax on
hi cComment guifg=#d2b550

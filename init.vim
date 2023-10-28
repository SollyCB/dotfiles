" ** Basic **
" tabshit
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartcase

" cursor static
set guicursor=""

" ** Binds **
let mapleader = " "

nnoremap <c-p> "+p
nnoremap <c-y> "+y
vnoremap <c-p> "+p
vnoremap <c-y> "+y
nnoremap > >>
nnoremap < <<

" ** Theme **
set termguicolors
colorscheme stb_dark

" ** Auto Commands **
" no auto comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Clear trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

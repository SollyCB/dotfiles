if !has('nvim')

    set nocompatible

    " dont flood with my dirs with shit
    set undofile
    set undodir=/tmp//
    set backupdir=/tmp//
    set directory=/tmp//

    " tmux colors
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum

    " fix ctrl and shift left and right arrow keys
    map <ESC>[1;5D <c-left>
    map! <ESC>[1;5D <c-left>
    map <ESC>[1;5C <c-right>
    map! <ESC>[1;5C <c-right>
    map <ESC>[1;2D <s-left>
    map! <ESC>[1;2D <s-left>
    map <ESC>[1;2C <s-right>
    map! <ESC>[1;2C <s-right>

endif

" retarded bell
set belloff=all

" tabshit
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set cindent

set ignorecase
set smartcase
set nowrap

" cursor static
set guicursor+=a:block
set guicursor+=a:blinkoff0

set incsearch
set timeoutlen=1000 ttimeoutlen=0

" dont align preprocessor
set cinkeys=0{,0},0),:,!^F,o,O,e

" mouse
set mouse=a

" open/save config
nnoremap <leader>ev :vs ~/.config/dotfiles/config.vim<cr>
nnoremap <leader>el :vs ~/.config/dotfiles/config.lua<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

source ~/.config/dotfiles/netrw.vim
source ~/.config/dotfiles/splash.vim
source ~/.config/dotfiles/autocmd.vim
source ~/.config/dotfiles/funcs.vim
source ~/.config/dotfiles/config.vim

lua require('config')

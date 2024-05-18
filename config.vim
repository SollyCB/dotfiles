command Netrw :e ~/.config/dotfiles/netrw.vim
command Splash :e ~/.config/dotfiles/splash.vim
command Autocmd :e ~/.config/dotfiles/autocmd.vim
command Funcs :e ~/.config/dotfiles/funcs.vim
command Vimrc :e ~/.config/dotfiles/.vimrc

" prgs
set grepprg=rg\ --vimgrep

" theme
syntax on
set termguicolors

if $NIGHT
    colo foot
else
    colo stb
endif

" lsp docs highlight underscores without this...
hi clear Error

" system register
nnoremap <leader>p "+p
nnoremap <leader>y "+y
vnoremap <leader>p "+p
vnoremap <leader>y "+y

" tabs
nnoremap <Tab>e :tabe<space>
nnoremap <Tab>n :tabn<cr>
nnoremap <Tab>p :tabp<cr>
nnoremap <Tab>o :tabo<cr>
nnoremap <Tab>c :tabc<cr>
nnoremap <Tab>m :tabm<space>

nnoremap <Tab>$ :tabnext $<cr>
nnoremap <Tab>1 :tabnext 1<cr>
nnoremap <Tab>2 :tabnext 2<cr>
nnoremap <Tab>3 :tabnext 3<cr>
nnoremap <Tab>4 :tabnext 4<cr>
nnoremap <Tab>5 :tabnext 5<cr>
nnoremap <Tab>6 :tabnext 6<cr>
nnoremap <Tab>7 :tabnext 7<cr>
nnoremap <Tab>8 :tabnext 8<cr>
nnoremap <Tab>9 :tabnext 9<cr>

" list dir
nnoremap <leader>e. :e .<cr>

" no hlsearch until next search
nnoremap <c-l> :noh<cr>

" easier indenting
nnoremap > >>
nnoremap < <<

" windows
nnoremap <c-w>f :vertical wincmd f<cr>

" execute q macro
nnoremap Q @q

" save
nnoremap <c-s> :w<cr>

" C
command C :normal i#define SOL_DEF<cr>#include "../solh/sol.h"<cr><cr>int main() {<cr><cr>return 0;<cr>}<esc>kk

" vulkan
nnoremap <leader>vks aVK_STRUCTURE_TYPE<esc>
nnoremap <leader>vkc aVK_STRUCTURE_TYPE__CREATE_INFO<esc>11hi
nnoremap <leader>vkd oDEBUG_VK_OBJ_CREATION(, check);<esc>8hi

" dont type copen
nnoremap <F2> :copen<cr>

nnoremap <leader>q :call QuickCompile()<cr>
nnoremap <c-n> :cn<cr>
nnoremap <c-p> :cp<cr>


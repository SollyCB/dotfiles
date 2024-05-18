augroup make
    autocmd!
    autocmd BufEnter,BufWinEnter *.vert,*.frag,*.glsl nnoremap <F1> :call BuildGlsl()<cr>
    autocmd BufEnter,BufWinEnter *.c,*.h nnoremap <F1> :call BuildC()<cr>
augroup END

" no autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

augroup c_syntax
autocmd!
autocmd BufEnter *.c,*.h,*.cpp,*.hpp,*.cc,*.cxx setlocal syntax=c
augroup END

" Clear trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

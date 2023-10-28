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

nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>

" no autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Clear trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

lua << EOF

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}


    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }

    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.4',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- ** Themes **
    use 'ellisonleao/gruvbox.nvim'
    use 'navarasu/onedark.nvim'
    use "rebelot/kanagawa.nvim"
    use "savq/melange-nvim"
    use 'jacoborus/tender.vim'


end) -- packer startup

require("gruvbox").setup({
  italic = { strings = false, emphasis = false, comments = false, operators = false, },
})
require('onedark').setup {
    style = 'darker'
}
vim.cmd("set termguicolors");
vim.cmd("colorscheme stb_dark")
--vim.cmd("hi cComment guifg=#d2b550");
--vim.cmd("hi Visual gui=bold");

--[[
require('nvim-treesitter.configs').setup({
  ensure_installed = {"c", "cpp", "lua"},

  ignore_install = { "all" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}) -- treesitter config
--]]

require('telescope').setup({
    defaults   = { },
    pickers    = { },
    extensions = { },
})


EOF

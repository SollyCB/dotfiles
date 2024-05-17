set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "stb"

" #081c15

hi Normal     gui=none guifg=#f0f0f0 guibg=#081c15
hi NonText    gui=none guifg=#f0f0f0
hi MatchParen gui=none guifg=#f0f0f0 guibg=#081c15
hi comment    gui=none guifg=darkgrey

hi ErrorMsg	  guifg=#f0f0f0 guibg=#081c15
hi WarningMsg guifg=purple  guibg=#081c15
hi Error      guifg=red     guibg=#081c15

hi ModeMsg guifg=#f0f0f0
hi MoreMsg guifg=#f0f0f0

hi Todo      guifg=#f0f0f0 guibg=#081c15
hi Cursor    guifg=#f0f0f0 guibg=#081c15
hi Search    guifg=#f0f0f0 guibg=#182c25
hi IncSearch guifg=#182c25 guibg=yellow
hi title     guifg=#f0f0f0
hi NonText   guifg=lightgrey

hi StatusLine	gui=bold guifg=black     guibg=lightgrey
hi StatusLineNC	gui=none guifg=black     guibg=lightgrey
hi VertSplit	gui=none guifg=lightgrey guibg=#081c15

hi TabLineFill guibg=grey    guifg=grey
hi TabLine     guibg=grey    gui=none
hi TabLineSel  guibg=#081c15 guifg=#f0f0f0 gui=bold

hi Visual guifg=#f0f0f0 guibg=#182c25


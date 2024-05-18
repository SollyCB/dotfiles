set background=light
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "stb"

hi Normal     gui=none guifg=black guibg=#f0f0f0
hi NonText    gui=none guifg=black
hi MatchParen gui=none guifg=black guibg=#f0f0f0
hi comment    gui=none guifg=#006a00

hi ErrorMsg	  guifg=black  guibg=#f0f0f0
hi WarningMsg guifg=purple guibg=#f0f0f0
hi Error      guifg=red    guibg=#f0f0f0

hi ModeMsg guifg=black
hi MoreMsg guifg=black

hi Todo      guifg=black guibg=#f0f0f0
hi title     guifg=black
hi NonText   guifg=lightgrey

hi Search    guifg=blue guibg=#f0f0f0
hi IncSearch guifg=#f0f0f0  guibg=darkyellow

hi StatusLine	gui=bold guifg=black guibg=lightgrey
hi StatusLineNC	gui=none guifg=black guibg=lightgrey
hi VertSplit	gui=none guifg=lightgrey guibg=#f0f0f0

hi TabLineFill guibg=grey    guifg=grey
hi TabLine     guibg=grey    gui=none
hi TabLineSel  guibg=#f0f0f0 guifg=black gui=bold

hi Visual guifg=black guibg=lightgrey

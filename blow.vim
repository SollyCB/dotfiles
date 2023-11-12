set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "blow"

hi Normal       gui=none guifg=#afaa95	guibg=#062625
hi NonText      gui=none guifg=#afaa95
hi MatchParen   gui=none guifg=none    guibg=none
hi comment      gui=none guifg=#fFdF00
hi constant     gui=none guifg=#C8D8DA
hi identifier	gui=none guifg=#afaa95
hi statement	gui=none guifg=#C8D8DA
hi preproc      gui=none guifg=#ffce62
hi type         gui=none guifg=#ffce62
hi special      gui=none guifg=#afaa95
hi Underlined	gui=none guifg=#afaa95	gui=underline
hi label        gui=none guifg=#afaa95
hi operator     gui=none guifg=#afaa95	gui=none

hi ErrorMsg	    guifg=#afaa95	guibg=#062625
hi WarningMsg	guifg=#afaa95	guibg=#062625     gui=none
hi ModeMsg      guifg=#afaa95	gui=NONE
hi MoreMsg      guifg=#afaa95	gui=NONE
hi Error        guifg=#afaa95	guibg=darkBlue	gui=underline

hi Todo         guifg=#afaa95	guibg=#062625
hi Cursor       guifg=#ffce62	guibg=#062625
hi Search       guifg=#afaa95	guibg=#062625
hi IncSearch	guifg=#afaa95	guibg=#062625
hi LineNr       guifg=cyan
hi title        guifg=#afaa95	guibg=#062625

hi StatusLine	gui=none	guifg=black     guibg=#988772
hi StatusLine	gui=none	guifg=black     guibg=#988772
hi VertSplit	gui=none	guifg=#867462	guibg=#062625

hi Visual	    guibg=#0000df

hi DiffChange	guibg=#062625	guifg=#afaa95
hi DiffText     guibg=#062625	guifg=#afaa95
hi DiffAdd      guibg=#062625	guifg=#afaa95
hi DiffDelete   guibg=#062625	guifg=#afaa95

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "stb_dark"

hi Normal       gui=none guifg=#E1D9D1	guibg=#292522
hi NonText      gui=none guifg=#E1D9D1
hi MatchParen   gui=none guifg=#E1D9D1    guibg=grey
hi comment      gui=none guifg=#00af00
hi constant     gui=none guifg=#E1D9D1
hi identifier	gui=none guifg=#E1D9D1
hi statement	gui=none guifg=#E1D9D1
hi preproc      gui=none guifg=#E1D9D1
hi type         gui=none guifg=#E1D9D1
hi special      gui=none guifg=#E1D9D1
hi Underlined	gui=none guifg=#E1D9D1	gui=underline
hi label        gui=none guifg=#E1D9D1
hi operator     gui=none guifg=#E1D9D1	gui=none

hi ErrorMsg	    guifg=#E1D9D1	guibg=#292522
hi WarningMsg	guifg=#E1D9D1	guibg=#292522     gui=none
hi ModeMsg      guifg=#E1D9D1	gui=NONE
hi MoreMsg      guifg=#E1D9D1	gui=NONE
hi Error        guifg=#E1D9D1	guibg=darkBlue	gui=underline

hi Todo         guifg=#E1D9D1	guibg=#292522
hi Cursor       guifg=#E1D9D1	guibg=#292522
hi Search       guifg=#E1D9D1	guibg=#292522
hi IncSearch	guifg=#E1D9D1	guibg=#292522
hi LineNr       guifg=#E1D9D1
hi title        guifg=#E1D9D1	guibg=#292522

hi StatusLineNC	gui=NONE	guifg=#E1D9D1  guibg=#292522
hi StatusLine	gui=bold	guifg=#E1D9D1	guibg=#292522
hi VertSplit	gui=none	guifg=#E1D9D1	guibg=#292522

hi Visual	    guifg=none	    guibg=#333333

hi DiffChange	guibg=#292522	guifg=#E1D9D1
hi DiffText     guibg=#292522	guifg=#E1D9D1
hi DiffAdd      guibg=#292522	guifg=#E1D9D1
hi DiffDelete   guibg=#292522	guifg=#E1D9D1

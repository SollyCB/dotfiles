set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "stb_dark"

hi Normal       gui=none guifg=white	      guibg=black
hi NonText      gui=none guifg=white
hi MatchParen   gui=none guifg=white        guibg=grey
hi comment      gui=none guifg=#00af00
hi constant     gui=none guifg=white
hi identifier	  gui=none guifg=white
hi statement	  gui=none guifg=white
hi preproc      gui=none guifg=white
hi type         gui=none guifg=white
hi special      gui=none guifg=white
hi Underlined	  gui=none guifg=white	      gui=underline
hi label        gui=none guifg=white
hi operator     gui=none guifg=white	      gui=none

hi ErrorMsg	    guifg=white	guibg=black
hi WarningMsg	  guifg=white	guibg=black     gui=none
hi ModeMsg      guifg=white	gui=NONE
hi MoreMsg      guifg=white	gui=NONE
hi Error        guifg=white	guibg=darkBlue	gui=underline

hi Todo         guifg=white	guibg=black
hi Cursor       guifg=white	guibg=black
hi Search       guifg=white	guibg=black
hi IncSearch	  guifg=white	guibg=black
hi LineNr       guifg=white
hi title        guifg=white	guibg=black

hi StatusLineNC	gui=NONE	guifg=white guibg=black
hi StatusLine	  gui=bold	guifg=white	guibg=black
hi VertSplit	  gui=none	guifg=white	guibg=black

hi Visual	      guifg=none	    guibg=#333333

hi DiffChange	  guibg=black	guifg=white
hi DiffText     guibg=black	guifg=white
hi DiffAdd      guibg=black	guifg=white
hi DiffDelete   guibg=black	guifg=white


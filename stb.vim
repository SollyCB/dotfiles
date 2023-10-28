set background=light
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "stb"

hi Normal       gui=none guifg=black	  guibg=white
hi NonText      gui=none guifg=black
hi MatchParen   gui=none guifg=black    guibg=grey
hi comment      gui=none guifg=#00af00
hi constant     gui=none guifg=black
hi identifier	  gui=none guifg=black
hi statement	  gui=none guifg=black
hi preproc      gui=none guifg=black
hi type         gui=none guifg=black
hi special      gui=none guifg=black
hi Underlined	  gui=none guifg=black	  gui=underline
hi label        gui=none guifg=black
hi operator     gui=none guifg=black	  gui=none

hi ErrorMsg	    guifg=black	guibg=white
hi WarningMsg	  guifg=black	guibg=white     gui=none
hi ModeMsg      guifg=black	gui=NONE
hi MoreMsg      guifg=black	gui=NONE
hi Error        guifg=black	guibg=darkBlue	gui=underline

hi Todo         guifg=black	guibg=white
hi Cursor       guifg=black	guibg=white
hi Search       guifg=black	guibg=white
hi IncSearch	  guifg=black	guibg=white
hi LineNr       guifg=cyan
hi title        guifg=black	guibg=white

hi StatusLine	  gui=none	guifg=black guibg=lightgrey
hi StatusLineNC	gui=none	guifg=white	guibg=lightgrey
hi VertSplit	  gui=none	guifg=black	guibg=white

hi Visual	    guifg=white	guibg=black

hi DiffChange	  guibg=white	guifg=black
hi DiffText     guibg=white	guifg=black
hi DiffAdd      guibg=white	guifg=black
hi DiffDelete   guibg=white	guifg=black


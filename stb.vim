set background=light
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "stb"

hi Normal	guifg=black	guibg=white
hi NonText	guifg=black
hi comment	guifg=#d2b550
hi constant	guifg=black
hi identifier	guifg=black
hi statement	guifg=black
hi preproc	guifg=black
hi type		guifg=black
hi special	guifg=black
hi Underlined	guifg=black	gui=underline
hi label	guifg=black
hi operator	guifg=black	gui=none

hi ErrorMsg	guifg=black	guibg=white
hi WarningMsg	guifg=black	guibg=white     gui=none
hi ModeMsg	guifg=black	gui=NONE
hi MoreMsg	guifg=black	gui=NONE
hi Error	guifg=black	guibg=darkBlue	gui=underline

hi Todo		guifg=black	guibg=white		
hi Cursor	guifg=black	guibg=white
hi Search	guifg=black	guibg=white
hi IncSearch	guifg=black	guibg=white
hi LineNr	guifg=cyan
hi title	guifg=black	guibg=white gui=bold

hi StatusLineNC	gui=NONE	guifg=black     guibg=white
hi StatusLine	gui=bold	guifg=black	guibg=white
hi VertSplit	gui=none	guifg=black	guibg=white

hi Visual	guifg=black	guibg=#f9eff5

hi DiffChange	guibg=white	guifg=black
hi DiffText	guibg=white	guifg=black
hi DiffAdd	guibg=white	guifg=black
hi DiffDelete   guibg=white	guifg=black

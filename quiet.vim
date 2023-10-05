set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "quiet"

hi Normal	guifg=white	guibg=#1f2023 
hi NonText	guifg=white
hi comment	guifg=#d2b550
hi constant	guifg=white
hi identifier	guifg=white
hi statement	guifg=white
hi preproc	guifg=white
hi type		guifg=white
hi special	guifg=white
hi Underlined	guifg=white	gui=underline
hi label	guifg=white
hi operator	guifg=white	gui=none

hi ErrorMsg	guifg=white	guibg=#1f2023
hi WarningMsg	guifg=white	guibg=#1f2023
hi ModeMsg	guifg=white	gui=NONE
hi MoreMsg	guifg=white	gui=NONE
hi Error	guifg=white	guibg=darkBlue	  gui=underline

hi Todo		guifg=#ff0000	guibg=#1f2023
hi Cursor	guifg=white	guibg=#1f2023
hi Search	guifg=white	guibg=#1f2023
hi IncSearch	guifg=white	guibg=#1f2023
hi LineNr	guifg=cyan	
hi title	guifg=white	guibg=#1f2023       gui=bold

hi StatusLineNC	gui=NONE	guifg=white       guibg=#1f2023
hi StatusLine	gui=bold	guifg=white	  guibg=#1f2023
hi VertSplit	gui=none	guifg=white	  guibg=#1f2023

hi Visual	guifg=white	guibg=#402034

hi DiffChange	guibg=#1f2023	guifg=white
hi DiffText	guibg=#1f2023	guifg=white
hi DiffAdd	guibg=#1f2023	guifg=white
hi DiffDelete   guibg=#1f2023	guifg=white

" C bitch.

if exists("b:current_syntax")
  finish
endif

syn region	cCommentL start="//" skip="\\$" end="$" keepend
syn region	cComment start="/\*" end="\*/"

hi def link cCommentL cComment
hi def link cComment Comment

let b:current_syntax = "c"

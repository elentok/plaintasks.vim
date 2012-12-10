" Vim syntax file
" Language: PlainTasks
" Maintainer: David Elentok
" Filenames: *.TODO
"
if exists("b:current_syntax")
  finish
endif

hi def link ptTask Function
hi def link ptCompleteTask Comment
hi def link ptSection Statement

syn match ptSection "^.*: *$"
syn match ptTask "^ *☐.*"
syn match ptCompleteTask "^ *✔.*"

" Vim filetype plugin
" Language: PlainTasks
" Maintainer: David Elentok

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

map \tn _i☐ <esc>
map \tt :call ToggleComplete()<cr>

function! ToggleComplete()
  let line = getline('.')
  if line =~ "^ *✔"
    s/^\( *\)✔/\1☐/
    s/ *@done.*$//
  else
    s/^\( *\)☐/\1✔/
    let text = " @done (" . strftime("%Y-%m-%d %H:%M") .")"
    exec "normal A" . text
    normal _
  endif
endfunc

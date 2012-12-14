" Vim filetype plugin
" Language: PlainTasks
" Maintainer: David Elentok

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

nmap <buffer> + :call NewTask()<cr>A
nmap = :call ToggleComplete()<cr>

" when pressing enter within a task it creates another task
setlocal comments+=n:☐

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

function! NewTask()
  let line=getline('.')
  if line =~ "^ *$"
    normal A☐ 
  else
    normal I☐ 
  end
endfunc

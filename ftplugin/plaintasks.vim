"Vim filetype plugin
" Language: PlainTasks
" Maintainer: David Elentok
" ArchiveTasks() added by Nik van der Ploeg

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> + :call NewTask()<cr>A
nnoremap <buffer> = :call ToggleComplete()<cr>
nnoremap <buffer> <C-M> :call ToggleCancel()<cr>
nnoremap <buffer> - :call ArchiveTasks()<cr>
abbr -- <c-r>=Separator()<cr>

" when pressing enter within a task it creates another task
setlocal comments+=n:☐

function! ToggleComplete()
  let line = getline('.')
  if line =~ "^ *✔"
    s/^\( *\)✔/\1☐/
    s/ *@done.*$//
  elseif line =~ "^ *☐"
    s/^\( *\)☐/\1✔/
    let text = " @done (" . strftime("%Y-%m-%d %H:%M") .")"
    exec "normal A" . text
    normal _
  endif
endfunc

function! ToggleCancel()
  let line = getline('.')
  if line =~ "^ *✘"
    s/^\( *\)✘/\1☐/
    s/ *@cancelled.*$//
  elseif line =~ "^ *☐"
    s/^\( *\)☐/\1✘/
    let text = " @cancelled (" . strftime("%Y-%m-%d %H:%M") .")"
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

function! ArchiveTasks()
    let orig_line=line('.')
    let orig_col=col('.')
    let archive_start = search("^Archive:")
    if (archive_start == 0)
        call cursor(line('$'), 1)
        normal 2o
        normal iArchive:
        normal o＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
        let archive_start = line('$') - 1
    endif
    call cursor(1,1)

    let found=0
    let a_reg = @a
    if search("✔", "", archive_start) != 0
        call cursor(1,1)
        while search("✔", "", archive_start) > 0
            if (found == 0)
                normal "add
            else
                normal "Add
            endif
            let found = found + 1
            call cursor(1,1)
        endwhile

        call cursor(archive_start + 1,1)
        normal "ap
    endif

    "clean up
    let @a = a_reg
    call cursor(orig_line, orig_col)
endfunc

function! Separator()
    let line = getline('.')
    if line =~ "^-*$"
      return "--- ✄ -----------------------"
    else
      return "--"
    end
endfunc

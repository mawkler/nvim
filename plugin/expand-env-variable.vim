" Expands the environment variable to the left of the cursor
function! s:ExpEnvVar()
  let line = getcmdline()
  let pos = getcmdpos() - 1

  let res = match(strpart(line, 0, pos), '\v\$\w+$')
  if res == -1
    return line
  endif

  let left = strpart(line, 0, res) . expand(strpart(line, res, pos-res))
  call setcmdpos(strlen(left) + 1)
  return left . strpart(line, pos)
endfunc

cnoremap <S-Tab> <C-\>e<SID>ExpEnvVar()<CR>

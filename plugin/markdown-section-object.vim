" -- Custom markdown text objects --

" Note: does not handle sections with just one empty line between both `---`'s
" because I'm lazy

" All text inside two `---`
fun! s:InSection()
  if s:FindPrevDashLine() != 0
    normal! 2j
    normal! 0v
  else
    " If we are in the first section of the buffer
    return s:InSectionTop()
  endif
  if s:FindNextDashLine() != 0
    normal! 2kg_
  else
    " Disable visual mode
    normal! v
    " If we are in the last section of the buffer
    return s:InSectionBottom()
  endif
endf

" All text inside two `---`, including the trailing `---`
fun! s:AroundSection()
  if s:FindPrevDashLine() != 0
    normal! 2jV
  else
    return s:AroundSectionTop()
  endif
  if s:FindNextDashLine() != 0
    call search('^[^$]', 'bW')
    normal! j
  else
    " Disable visual mode
    normal! v
    " If we are in the last section of the buffer
    return s:AroundSectionBottom()
  endif
endf

fun! s:FindPrevDashLine()
  return search('^---*$\n$', 'bceW')
endf

fun! s:FindNextDashLine()
  return search('$\n^---*$', 'ceW')
endf

fun! s:InSectionTop()
  normal! gg_v
  call s:FindNextDashLine()
  normal! 2kg_
endf

fun! s:InSectionBottom()
  normal! Gg_v
  call s:FindPrevDashLine()
  normal! 2j_
endf

fun! s:AroundSectionTop()
  normal! gg_v
  call s:FindNextDashLine()
  normal! j
endf

fun! s:AroundSectionBottom()
  normal! Gg_v
  call s:FindPrevDashLine()
  normal! k_
endf

autocmd Filetype markdown xnoremap <silent> iP :<c-u>call <SID>InSection()<CR>
autocmd Filetype markdown onoremap <silent> iP :<c-u>call <SID>InSection()<CR>
autocmd Filetype markdown xnoremap <silent> aP :<c-u>call <SID>AroundSection()<CR>
autocmd Filetype markdown onoremap <silent> aP :<c-u>call <SID>AroundSection()<CR>

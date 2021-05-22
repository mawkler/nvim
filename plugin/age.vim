" Like `aw`/`aW` but always includes leading whitespace instead of trailing

function! Age()
  call search('\>', 'bW')
  normal! v
  call search('\w\>', 'cW')
endfunction

function! AgE()
  call search('\>\s', 'bW')
  normal! v
  call search('\w\s', 'cW')
endfunction

onoremap age :<C-u>call Age()<CR>
onoremap agE :<C-u>call AgE()<CR>
xnoremap age :<C-u>call Age()<CR>
xnoremap agE :<C-u>call AgE()<CR>

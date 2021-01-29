" Appends `char` to current line or visual selection
function! VisualAppend(char)
  exe "normal! m0"
  exe "normal! A" . a:char
  exe "normal! `0"
endfunction

map <silent> <Plug>VisualAppend-. :call VisualAppend(".")<CR>
      \:call repeat#set("\<Plug>VisualAppend-.")<CR>
map <leader>. <Plug>VisualAppend-.
map <silent> <Plug>VisualAppend-, :call VisualAppend(",")<CR>
      \:call repeat#set("\<Plug>VisualAppend-,")<CR>
map <leader>, <Plug>VisualAppend-,
map <silent> <Plug>VisualAppend-; :call VisualAppend(";")<CR>
      \:call repeat#set("\<Plug>VisualAppend-;")<CR>
map <leader>; <Plug>VisualAppend-;
map <silent> <Plug>VisualAppend-! :call VisualAppend("!")<CR>
      \:call repeat#set("\<Plug>VisualAppend-!")<CR>
map <leader>! <Plug>VisualAppend-!
map <silent> <Plug>VisualAppend-? :call VisualAppend("?")<CR>
      \:call repeat#set("\<Plug>VisualAppend-?")<CR>
map <leader>? <Plug>VisualAppend-?

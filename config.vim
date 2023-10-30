if exists('g:goneovim') || exists('g:neovide') && !exists('g:font_set')
  set guifont=FiraCode\ Nerd\ Font:h11
  let g:font_set = v:true " Prevents goneovim from changing zoom level when reloading init.vim
endif

" -- Vim-easy-align --
xmap ga  <Plug>(EasyAlign)
nmap ga  <Plug>(EasyAlign)
nmap gaa gaiL

" -- For editing multiple files with `*` --
command! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"

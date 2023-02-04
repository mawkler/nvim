if exists('g:goneovim') || exists('g:neovide') && !exists('g:font_set')
  set guifont=FiraCode\ Nerd\ Font:h11
  let g:font_set = v:true " Prevents goneovim from changing zoom level when reloading init.vim
endif

" Tries to perform a regular `gf`, if that doesn't work try to call
" vim-markdown's Markdown_EditUrlUnderCursor
function MarkdownGf()
  set path-=**
  try
    normal! gf
  catch
    execute "normal \<Plug>Markdown_EditUrlUnderCursor"
  endtry
  set path+=**
endf
nnoremap gf :call MarkdownGf()<CR>

" Puts current file in trashcan using trash-cli
command! -bar -bang -nargs=? -complete=file Trash
      \ let s:file = fnamemodify(bufname(<q-args>),':p') |
      \ execute 'BufferClose<bang>' |
      \ execute 'silent !trash ' . s:file |
      \ unlet s:file

" Gets the highlight value of highlight group `name`
" Set `layer` to either 'fg' or 'bg'
function GetHiVal(name, layer)
  return synIDattr(synIDtrans(hlID(a:name)), a:layer . '#')
endf

" For toggling caps lock in insert mode
imap <S-Esc> <Plug>CapsLockToggle
imap <M-c>   <Plug>CapsLockToggle

" -- Vim-easy-align --
xmap ga  <Plug>(EasyAlign)
nmap ga  <Plug>(EasyAlign)
nmap gaa gaiL

" -- For editing multiple files with `*` --
command! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"

" Use <C-k>/<C-j> to move up/down in PUM selection
inoremap <silent> <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-o>O"
inoremap <silent> <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"

" -- vim-textobj-line --
let g:textobj_line_no_default_key_mappings = 1
xmap aL <Plug>(textobj-line-a)
omap aL <Plug>(textobj-line-a)
xmap iL <Plug>(textobj-line-i)
omap iL <Plug>(textobj-line-i)

" -- vim-printer --
let g:vim_printer_print_below_keybinding = 'gp'
let g:vim_printer_print_above_keybinding = 'gP'

" -- textobj-entire --
let g:textobj_entire_no_default_key_mappings = 1
" Allow `ie` and `ae` in all file types except `tex` files
omap <expr> ae &filetype=='tex' ? "<Plug>(vimtex-ae)" : "<Plug>(textobj-entire-a)"
xmap <expr> ae &filetype=='tex' ? "<Plug>(vimtex-ae)" : "<Plug>(textobj-entire-a)"
omap <expr> ie &filetype=='tex' ? "<Plug>(vimtex-ie)" : "<Plug>(textobj-entire-i)"
xmap <expr> ie &filetype=='tex' ? "<Plug>(vimtex-ie)" : "<Plug>(textobj-entire-i)"

" `iE` and `aE` work in all file types
omap aE <Plug>(textobj-entire-a)
xmap aE <Plug>(textobj-entire-a)
omap iE <Plug>(textobj-entire-i)
xmap iE <Plug>(textobj-entire-i)

" -- textobj-user --
call textobj#user#plugin('datetime', {
      \   'date': {
      \     'pattern': '\<\d\d\d\d-\d\d-\d\d\>',
      \     'select': ['ad', 'id'],
      \   }
      \ })

" -- Markdown --
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_auto_insert_bullets = 0
" Disables vim-markdown's default `ge` mapping
map <F13> <Plug>Markdown_EditUrlUnderCursor
" Disables vim-markdown's default `]c` mapping
map <F14> <Plug>Markdown_MoveToCurHeader

augroup toc_markdown
  autocmd!
  autocmd FileType markdown nmap <buffer> <leader>t :Toc<CR>
  autocmd FileType markdown setlocal keywordprg=:help
augroup END

" -- vim-textobj-markdown --
let g:__textobj_markdown_no_mappings = 1
augroup markdown
  autocmd!
  autocmd FileType markdown omap <buffer> ac <plug>(textobj-markdown-chunk-a)
  autocmd FileType markdown xmap <buffer> ac <plug>(textobj-markdown-chunk-a)
  autocmd FileType markdown omap <buffer> ic <plug>(textobj-markdown-chunk-i)
  autocmd FileType markdown xmap <buffer> ic <plug>(textobj-markdown-chunk-i)
  autocmd FileType markdown omap <buffer> aC <plug>(textobj-markdown-Bchunk-a)
  autocmd FileType markdown xmap <buffer> aC <plug>(textobj-markdown-Bchunk-a)
  autocmd FileType markdown omap <buffer> iC <plug>(textobj-markdown-Bchunk-i)
  autocmd FileType markdown xmap <buffer> iC <plug>(textobj-markdown-Bchunk-i)
augroup END

let g:vim_markdown_strikethrough = 1

" -- Scrollbar --
let g:scrollbar_right_offset = 0
let g:scrollbar_excluded_filetypes = ['NvimTree']
let g:scrollbar_highlight = {
      \ 'head': 'Scrollbar',
      \ 'body': 'Scrollbar',
      \ 'tail': 'Scrollbar',
      \ }
let g:scrollbar_shape = {
      \ 'head': '▖',
      \ 'body': '▌',
      \ 'tail': '▘',
      \ }

augroup configure_scrollbar
  autocmd!
  autocmd BufEnter                                         * call OnBufEnter()
  autocmd CursorMoved                                      * call ScrollbarShow()
  autocmd CursorHold,BufLeave,FocusLost,VimResized,QuitPre * call ScrollbarClear()
augroup end

function! ScrollbarShow()
  if !exists('b:previous_first_visible_linenum') | return | endif
  let first_visible_linenum = line('w0')
  if first_visible_linenum != b:previous_first_visible_linenum
    silent! lua require('scrollbar').show()
  end
  let b:previous_first_visible_linenum = first_visible_linenum
endf

function! OnBufEnter()
  if !exists('b:previous_first_visible_linenum')
    let b:previous_first_visible_linenum = line('w0')
  endif
endf

function! ScrollbarClear() abort
  silent! lua require('scrollbar').clear()
endf

" -- Grammarous --
let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#hooks = {}

function! g:grammarous#hooks.on_check(errs) abort
  nmap <buffer> ]s <Plug>(grammarous-move-to-next-error)
  nmap <buffer> [s <Plug>(grammarous-move-to-previous-error)
endf

function! g:grammarous#hooks.on_reset(errs) abort
  nunmap <buffer> ]s
  nunmap <buffer> [s
endf

nmap <silent> <leader>Gc :GrammarousCheck<CR>
nmap <leader>Gg <Plug>(grammarous-move-to-info-window)
nmap <leader>Gd <Plug>(grammarous-open-info-window)<Plug>(grammarous-move-to-info-window)
nmap <leader>GQ <Plug>(grammarous-reset)
nmap <leader>Gf <Plug>(grammarous-fixit)
nmap <leader>GF <Plug>(grammarous-fixall)
nmap <leader>Gq <Plug>(grammarous-close-info-window)
nmap <leader>Gr <Plug>(grammarous-remove-error)
nmap <leader>GD <Plug>(grammarous-disable-rule)

if !exists('g:vscode')
  " -- Peekaboo --
  let g:peekaboo_delay = 300
endif

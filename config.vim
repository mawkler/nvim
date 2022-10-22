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

if !$NVIM_MINIMAL
  " Git-timelapse
  nmap <leader>gt :call TimeLapse() <cr>
endif

" -- textobj-function --
let g:textobj_function_no_default_key_mappings = 1
xmap aF <Plug>(textobj-function-A)
omap aF <Plug>(textobj-function-A)
xmap iF <Plug>(textobj-function-i)
omap iF <Plug>(textobj-function-i)

" -- vim-textobj-line --
let g:textobj_line_no_default_key_mappings = 1
xmap aL <Plug>(textobj-line-a)
omap aL <Plug>(textobj-line-a)
xmap iL <Plug>(textobj-line-i)
omap iL <Plug>(textobj-line-i)

" -- exchange.vim --
xmap X <Plug>(Exchange)
nmap cX cx$

" -- Fzf --
function FZF_files(dir)
  echohl Comment
  echo 'Directory: ' . fnamemodify(a:dir, ':~')
  echohl None
  exe 'FilesWithDevicons ' .. a:dir
endf

let g:fzf_layout = {
      \ 'window': {
      \   'width': 0.9,
      \   'height': 0.8,
      \   'highlight': 'SpecialKey',
      \   'border': 'rounded'
      \ }}
" TODO: Check if we're in a git repo, if we are, use telescope
nmap <silent> <leader><C-p> :call FZF_files('~')<CR>
let $FZF_DEFAULT_COMMAND = 'rg --hidden --files --ignore-file-case-insensitive --ignore-file=$HOME/.config/nvim/.ignore-nvim'
let $FZF_DEFAULT_OPTS = '
      \ --multi
      \ --prompt ">>> "
      \ --pointer="▶"
      \ --info=inline
      \ --history=' . $HOME . '/.fzf_history
      \ --history-size=10000
      \ '

augroup fzf
  autocmd!
  autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
augroup END

let g:fzf_mru_case_sensitive = 0
let g:fzf_colors = {
      \ "fg":      ["fg", "Normal"],
      \ "fg+":     ["fg", "Question", "CursorColumn", "Normal"],
      \ "bg":      ["bg", "Normal"],
      \ "bg+":     ["bg", "CursorLine", "CursorColumn"],
      \ "hl":      ["fg", "ErrorMsg"],
      \ "hl+":     ["fg", "ErrorMsg"],
      \ "gutter":  ["bg", "Normal"],
      \ "pointer": ["fg", "Question"],
      \ "marker":  ["fg", "Title"],
      \ "border":  ["fg", "VisualNC"],
      \ "header":  ["fg", "WildMenu"],
      \ "info":    ["fg", "ErrorMsg"],
      \ "spinner": ["fg", "Question"],
      \ "prompt":  ["fg", "Question"]
      \ }

" -- vim-printer --
let g:vim_printer_print_below_keybinding = 'gp'
let g:vim_printer_print_above_keybinding = 'gP'

" -- LaTeX and Vimtex --
let g:tex_indent_items = 0      " Disables indent before new `\item`
let g:vimtex_indent_enabled = 0 " Disables indent before new `\item` by VimTex
let g:tex_comment_nospell = 1
let g:vimtex_view_method = 'zathura' " Zathura automatically reloads documents
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_complete_bib = {'simple': 1}
let g:vimtex_toc_config = {
      \ 'layer_status': { 'label': 0 }
      \ }

" Disable custom warnings based on regexp
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull \\hbox',
      \ ]
" Disables default mappings that start with `t`
let g:vimtex_mappings_disable = {
      \ 'x': ['tsf', 'tsc', 'tse', 'tsd', 'tsD'],
      \ 'n': ['tsf', 'tsc', 'tse', 'tsd', 'tsD'],
      \ }
let g:vimtex_toc_config = {
      \ 'todo_sorted': 1,
      \ 'split_width': 30,
      \ 'name': 'Table of contents (vimtex)',
      \ 'hotkeys_leader': '',
      \ 'show_numbers': 1,
      \ 'hotkeys_enabled': 1,
      \ 'hotkeys': 'acdeilmopuvwx',
      \ 'show_help': 0,
      \ 'layer_status': { 'label': 0, 'todo': 0},
      \ }
let g:vimtex_syntax_conceal = {'sections': 1}
let g:vimtex_syntax_conceal_cites = {
      \ 'type': 'icon',
      \ 'icon': '龎',
      \}
let g:vimtex_syntax_custom_cmds = [
      \ {'name': 'texttt', 'conceal': v:true},
      \]

augroup latex
  autocmd!
  " `:` counts as a separator
  autocmd FileType latex,tex setlocal iskeyword-=:
  autocmd FileType latex,tex nmap <buffer> <silent> <leader>t <Plug>(vimtex-toc-open)
  " Fixes issue with spell check only in comments
  autocmd FileType latex,tex syntax spell toplevel
  autocmd ColorScheme * call s:texHighlight()
augroup END

function! s:texHighlight() abort
  " Special highlight for \texttt{}
  " highlight link texCTextttArg String
  " highlight link texPartArgTitle DiffDelete
endf
call s:texHighlight()

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

" -- Thesaurus --
let g:tq_map_keys = 0
nnoremap <silent> <leader>T :ThesaurusQueryLookupCurrentWord<CR>

" Looks up the provided word(s) in a thesaurus
command! -nargs=+ -bar Thesaurus call thesaurusPy2Vim#Thesaurus_LookWord('<args>')

" -- vim-resize --
let g:vim_resize_disable_auto_mappings = 1
let g:resize_count = 3
nnoremap <silent> <Left>  :CmdResizeLeft<CR>
nnoremap <silent> <Right> :CmdResizeRight<CR>
nnoremap <silent> <Up>    :CmdResizeUp<CR>
nnoremap <silent> <Down>  :CmdResizeDown<CR>

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

  " -- Matchup --
  let g:matchup_matchparen_offscreen = {} " Disable displaying off-screen matches
  let g:matchup_delim_nomids = 1 " Don't include words like `return`
endif

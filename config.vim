" -- General --
set shortmess+=A  " Ignores swapfiles when opening file
set shortmess+=c  " Disable completion menu messages like 'match 1 of 2'
set shortmess+=s  " Disable 'Search hit BOTTOM, continuing at TOP' messages
set termguicolors " Use GUI colors in terminal as well
set winblend=4    " Transparent floating windows
set pumblend=4    " Transparent popup-menu
set noshowmode    " Don't write out `--INSERT--`, etc.
set linebreak     " Don't break lines in the middle of a word
set lazyredraw
set undofile
set viewoptions=cursor,folds,slash,unix
set fileformat=unix   " Use Unix eol format
set spelllang=en,sv   " Use both Engligh and Swedish spell check
set splitright        " Open vertical window splits to the right instead of left
set encoding=utf-8
set updatetime=500

if exists('g:goneovim') && !exists('g:font_set')
  set guifont=FiraCode\ Nerd\ Font:h11
  let g:font_set = v:true " Prevents goneovim from changing zoom level when reloading init.vim
endif

augroup filechanged
  autocmd!
  autocmd FocusGained * silent! checktime " Check if any file has changed when Vim is focused
augroup end

" -- Menu autocompletion --
set wildignorecase  " Case insensitive file- and directory name completion
set path+=**        " Lets `find` search recursively into subfolders
set cedit=<C-y>     " Enter Command-line Mode from command-mode

" -- Searching --
set ignorecase " Case insensitive searching
set smartcase  " Except for when searching in CAPS

" -- Custom filetypes --
augroup custom_filetypes
  autocmd!
  autocmd BufNewFile,BufRead *.dconf set syntax=sh
augroup END

" -- Key mappings --
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
map <S-space> <space>

nnoremap yp               yyp
noremap  <leader>y        "+y
map      <leader>Y        "+Y
noremap  <leader>d        "+d
noremap  <leader>D        "+D
noremap  <leader>p        "+p
noremap  <leader>P        "+P
map!     <M-v>            <C-r>+
map      <C-q>            :qa<CR>
map      -                3<C-W><
map      +                3<C-W>>
nmap     <M-+>            <C-W>+
nmap     <M-->            <C-W>-
nmap     <C-j>            o<Esc>
nmap     g<C-j>           i<CR><Esc>
nmap     <C-k>            O<Esc>
nmap     g<C-k>           DO<Esc>P_
nmap     gK               kjddkPJ<C-y>
nmap     <C-s>            :w<CR>
imap     <C-s>            <Esc>:w<CR>
vmap     <C-s>            <Esc>:w<CR>gv
smap     <C-s>            <Esc>:w<CR>
smap     <C-h>            <BS>
xmap     v                $h
nnoremap c_               c^
nnoremap d_               d^
nmap     <BS>             X
nmap     <M-BS>           db
map!     <M-BS>           <C-w>
map!     <M-p>            <C-r>"
smap     <M-p>            <C-g>pgv<C-g>
map      <M-a>            v<C-a>
map      <M-x>            v<C-x>
map!     <C-f>            <Right>
map!     <M-f>            <C-Right>
map!     <C-b>            <Left>
cmap     <M-l>            <Right>
cmap     <M-h>            <Left>
map!     <M-b>            <C-Left>
map!     <M-w>            <C-Right>
cmap     <C-a>            <Home>
nmap     <M-j>            :m .+1<CR>==
nmap     <M-k>            :m .-2<CR>==
xmap     <M-j>            :m '>+1<CR>gv=gv
xmap     <M-k>            :m '<-2<CR>gv=gv
imap     <M-j>            <Esc>:m .+1<CR>==gi
imap     <M-k>            <Esc>:m .-2<CR>==gi
nnoremap <C-w>T           :tab split<CR>
nnoremap <C-w>C           :tabclose<CR>
nnoremap <leader>wn       :tab split<CR>
nnoremap <leader>wc       :tabclose<CR>
nnoremap <leader>wo       :tabonly<CR>
nnoremap <leader>wl       :tabnext<CR>
nnoremap <leader>wh       :tabprevious<CR>
nmap     <Leader><Esc>    <Nop>
nmap     <leader>i        :source ~/.config/nvim/init.lua<CR>
nmap     <leader>I        :drop ~/.config/nvim/init.lua<CR>
nmap     <leader>V        :drop ~/.config/nvim/config.vim<CR>
nmap     <leader>Z        :drop ~/.zshrc<CR>
map      gX               :exec 'silent !brave %:p &'<CR>
xnoremap //               omsy/<C-R>"<CR>`s
nnoremap /                ms/
nnoremap *                ms*
nnoremap g*               msg*`s
nnoremap <leader>*        ms*`s
nnoremap <leader>g*       msg*`s
nnoremap #                ms#
nnoremap g#               msg#`s
nmap     `/               `s
nmap     <leader>/        :execute '/\V' . escape(input('/'), '\\/')<CR><C-r>+<CR>
nmap     g/               /\<\><Left><Left>
nmap     <leader>R        :%substitute/<C-R><C-W>//gci<Left><Left><Left><Left>
nmap      Q                @@
xmap      Q                @@
nmap      <leader>Q        qqqqq
xmap      <leader>Q        qqqqq
nnoremap cg*              *Ncgn
nnoremap dg*              *Ndgn
vnoremap gcn              //Ncgn
vnoremap gdn              //Ndgn
nnoremap g.               /\V\C<C-R>"<CR>cgn<C-a><Esc>
xnoremap g.               .

nmap     <leader>K        :vertical Man <C-R><C-W><CR>
xmap     <leader>K        y:vertical Man <C-R>"<CR>

map  <silent> <leader>S :setlocal spell!<CR>
map           g)        w)ge
omap <silent> g)        :silent normal vg)h<CR>
map           g(        (ge
omap <silent> g(        :silent normal vg(oh<CR>
nmap <silent> <C-W>N    :tabe<CR>

nmap <silent> <expr> <leader>z &spell ? "1z=" : ":setlocal spell<CR>1z=:setlocal nospell<CR>"
nmap <silent> <expr> ]s        &spell ? "]s" : ":setlocal spell<CR>]s"
nmap <silent> <expr> [s        &spell ? "[s" : ":setlocal spell<CR>[s"

" `;`/`,` always seach forward/backward, respectively
nnoremap <expr> ; getcharsearch().forward ? ';' : ','
xnoremap <expr> ; getcharsearch().forward ? ';' : ','
nnoremap <expr> , getcharsearch().forward ? ',' : ';'
xnoremap <expr> , getcharsearch().forward ? ',' : ';'

" Adds previous cursor location to jumplist if count is > 5
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

augroup vertical_help
  " Open :help in vertical split instead of horizontal
  autocmd!
  autocmd FileType help
        \ setlocal bufhidden=unload |
        \ wincmd L |
        \ vertical resize 80
augroup END

" Prints the syntax highlighting values under cursor
nmap <leader>H :TSHighlightCapturesUnderCursor<CR>

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

" Increases the font zise with `amount`
function! Zoom(amount) abort
  call ZoomSet(matchlist(&guifont, ':h\(\d\+\)')[1] + a:amount)
endf

" Sets the font size
function! ZoomSet(font_size) abort
  if !exists('g:goneovim')
    execute 'GuiFont! ' .  substitute(&guifont, ':h\d\+', ':h' . a:font_size, '')
  else
    execute 'set guifont=' .  substitute(substitute(&guifont, ':h\d\+', ':h' . a:font_size, ''), ' ', '\\ ', 'g')
  endif
endf

noremap <silent> <C-=> :call Zoom(v:count1)<CR>
noremap <silent> <C-+> :call Zoom(v:count1)<CR>
noremap <silent> <C--> :call Zoom(-v:count1)<CR>
noremap <silent> <C-0> :call ZoomSet(11)<CR>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-q> <Esc>
set cpoptions-=_ " Makes cw/cW include the whitespace after the word
set shada=!,'1000,<50,s10,h

if exists('$TMUX')
  set notermguicolors " Tmux screws up the colors if `set termguicolors` is used
endif

" -- Lines and cursor --
set number relativenumber
set cursorline                    " Cursor highlighting
set scrolloff=12                  " Cursor margin
set guicursor+=n:blinkwait0       " Disables cursor blinking in normal mode
set guicursor+=i:ver25-blinkwait0 " And in insert mode
set conceallevel=2                " Hide concealed characters completely
set concealcursor=nic             " Conceal characters on the cursor line
set breakindent                   " Respect indent when line wrapping

" -- Tab characters --
set expandtab                     " Use spaces for indentation
set shiftwidth=2                  " Width of indentation
set tabstop=4                     " Width of <Tab> characters
set list listchars=tab:\ \ ,nbsp:·
set shiftround                    " Round indent to multiple of shiftwdith
set cinkeys-=0#                   " Indent lines starting with `#`

" Puts current file in trashcan using trash-cli
command! -bar -bang -nargs=? -complete=file Trash
      \ let s:file = fnamemodify(bufname(<q-args>),':p') |
      \ execute 'BufferClose<bang>' |
      \ execute 'silent !trash ' . s:file |
      \ unlet s:file

" -- vim-plug --
augroup vim_plug
  autocmd!
  autocmd FileType vim nmap <buffer> <F5> :source ~/.config/nvim/init.vim \| :PlugInstall<CR>
augroup end

" -- Surround --
xmap s  <Plug>VSurround
xmap S  <Plug>VgSurround
nmap s  ys
nmap S  ys$
omap ir i]
omap ar a]
xmap ir i]
xmap ar a]

" surround noun `q` means `'`
nmap csq cs'
nmap dsq ds'
" noun `q` already means any quotes i.e. `/"/'
let g:surround_{char2nr('q')} = "'\r'"

" surround noun `Q` means `"`
nmap csQ cs"
nmap dsQ ds"
omap iQ  i"
omap aQ  a"
xmap iQ  i"
xmap aQ  a"
let g:surround_{char2nr('Q')} = "\"\r\""

" surround noun `A` means `
nmap csA cs`
nmap dsA ds`
omap iA  i`
omap aA  a`
xmap iA  i`
xmap aA  a`
let g:surround_{char2nr('A')} = "`\r`"

augroup language_specific
  autocmd!
  " Don't conceal current line in some file formats (LaTeX files' configs don't seem to be overwritten though)
  autocmd FileType markdown,latex,tex,json setlocal concealcursor=""
  " For adding a horizontal line below and entering insert mode below it
  autocmd FileType markdown nnoremap <buffer> <leader>- o<Esc>0Do<Esc>0C---<CR><CR>
  " Custom filetype indent settings
  autocmd FileType css,python,cs setlocal shiftwidth=4 tabstop=4
  " Start commit buffers in insert mode
  autocmd FileType gitcommit exec 'norm gg' | setlocal spell | startinsert!
  autocmd FileType lua setlocal keywordprg=:help
  autocmd FileType lua let b:surround_{char2nr('F')} = "function() return \r end"
augroup end

" -- Quickscope --
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
nmap <C-c> <cmd>call Esc()<CR>

" Doing this mapping in Lua breaks quickscope for some reason
function Esc() abort
  if &diff
    exec 'tabclose'
  else
    exec 'DiffviewClose'
  end
endfunction

" Gets the highlight value of highlight group `name`
" Set `layer` to either 'fg' or 'bg'
function GetHiVal(name, layer)
  return synIDattr(synIDtrans(hlID(a:name)), a:layer . '#')
endf

" For toggling caps lock in insert mode
imap <S-Esc> <Plug>CapsLockToggle
imap <M-c>   <Plug>CapsLockToggle

" -- Vim-easy-align --
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" -- For editing multiple files with `*` --
command! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"

" -- Targets.vim --
let g:targets_aiAI = 'aIAi' " Swaps meaning of `I` and `i`
augroup targets
  autocmd!
  " Resets ib/ab to Vim's default behaviour
  autocmd User targets#mappings#user call targets#mappings#extend({
        \ 'b': {'pair': [{'o':'(', 'c':')'}]}
        \ })
augroup end

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

" -- dsf.vim --
let g:dsf_no_mappings = 1
nmap dsf <Plug>DsfNextDelete
nmap dsF <Plug>DsfDelete
nmap csf <Plug>DsfNextChange
nmap csF <Plug>DsfChange

omap af <Plug>DsfTextObjectA
xmap af <Plug>DsfTextObjectA
omap if <Plug>DsfTextObjectI
xmap if <Plug>DsfTextObjectI

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
  " Add vim-surround noun `c`
  autocmd FileType latex,tex let b:surround_{char2nr('c')} = "\\\1command\1{\r}"
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

augroup markdown_surround
  autocmd!
  " Surround noun `c` turns target into markdown code block
  autocmd FileType markdown let b:surround_{char2nr('c')} = "```\n\r\n```"
augroup END

" -- togglelist.vim --
let g:toggle_list_no_mappings = 1
nmap <script> <silent> <leader>L :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>
augroup quickfix
  autocmd!
  autocmd FileType qf nmap <buffer><nowait> <Space> <CR><C-w>p
  autocmd FileType qf nmap <buffer><nowait> <CR> <CR>
  autocmd FileType qf xmap <buffer><nowait> <CR> <CR>
augroup END

" -- lens.vim --
let g:lens#disabled_filetypes = ['fzf', 'fugitiveblame', 'NvimTree', 'DiffviewFileHistory']

" -- Markdown --
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
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

" Fixes crash
nmap ]f <Nop>
nmap [f <Nop>

let g:vim_markdown_strikethrough = 1

" -- vim-highlighturl --
" Disable vim-highlighturl in Markdown files
augroup highlighturl_filetype
  autocmd!
  autocmd FileType markdown call highlighturl#disable_local()
augroup END
let g:highlighturl_guifg = '#61AFEF'

" -- undotree --
nmap <silent> <leader>u :UndotreeShow \| UndotreeFocus<CR>
augroup undotree
  autocmd!
  autocmd FileType undotree nmap <silent> <buffer> <Tab>     <Plug>UndotreeFocusTarget
  autocmd FileType undotree nmap <silent> <buffer> <leader>u <Plug>UndotreeClose
  autocmd FileType undotree nmap <silent> <buffer> <Esc>     <Plug>UndotreeClose
augroup end

" -- bullets --
map <silent> <leader>X :ToggleCheckbox<CR>
let g:bullets_nested_checkboxes = 0 " Don't toggle parent and child boxes automatically
let g:bullets_checkbox_markers  = ' x'

" -- Thesaurus --
let g:tq_map_keys = 0
nnoremap <silent> <leader>T :ThesaurusQueryLookupCurrentWord<CR>

" Looks up the provided word(s) in a thesaurus
command! -nargs=+ -bar Thesaurus call thesaurusPy2Vim#Thesaurus_LookWord('<args>')

" -- Startify --
let g:startify_session_dir = stdpath('data') .'/sessions/'
let g:startify_enable_special = 0 " Dont' show <empty buffer> or <quit>
let g:startify_custom_indices = 'asdfhlvnmytureowpqxz' " Use letters instead of numbers
let g:startify_files_number = 8
let g:startify_change_to_dir = 0 " Don't `cd` to selected file's directory
let g:startify_session_sort = 1  " Sort sessions based on mru rather than name
let g:startify_skiplist = ['COMMIT_EDITMSG']
let g:startify_lists = [
      \   {'type': 'sessions',  'header': ['   Sessions']},
      \   {'type': 'files',     'header': ['   Recent files']},
      \   {'type': 'bookmarks', 'header': ['   Bookmarks']},
      \   {'type': 'commands',  'header': ['   Commands']},
      \ ]
let g:startify_custom_header = [
      \ '    _____   __                                      ',
      \ '   (\    \ |  \                         __          ',
      \ '   | \    \|   :  ____    ____  ___  __[__]  _____  ',
      \ '   |  \    \   | / __ \  /  _ \ \  \/ /|  | /     \ ',
      \ '   |   \    \  |(  ___/ (  (_) ) \   / |  ||  Y Y  \',
      \ '   :   |\    \ | \_____) \____/   \_/  |__||__|_|__/',
      \ '    \__| \____\)----------------------------------- ',
      \ ]

" Disable q mapping
augroup Startify
  autocmd!
  autocmd User Startified nunmap <buffer> q
augroup END

" Use nvim-web-devicons
lua function _G.webDevIcons(path)
      \   local filename = vim.fn.fnamemodify(path, ':t')
      \   local extension = vim.fn.fnamemodify(path, ':e')
      \   return require('nvim-web-devicons').get_icon(filename, extension, { default = true })
      \ end

function! StartifyEntryFormat() abort
  return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endf

" -- vim-session --
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 1
let g:session_autosave_silent = 1
let g:session_default_overwrite = 1
let g:session_autoload = 'no'
let g:session_lock_enabled = 0
let g:session_directory = g:startify_session_dir

" -- vim-resize --
let g:vim_resize_disable_auto_mappings = 1
let g:resize_count = 3
nnoremap <silent> <Left>  :CmdResizeLeft<CR>
nnoremap <silent> <Right> :CmdResizeRight<CR>
nnoremap <silent> <Up>    :CmdResizeUp<CR>
nnoremap <silent> <Down>  :CmdResizeDown<CR>

" -- barbar.nvim --
let g:bufferline = get(g:, 'bufferline', {
      \ 'closable': v:false,
      \ 'no_name_title': '[No Name]',
      \ 'insert_at_end': v:true,
      \ 'exclude_name': ['[dap-repl]'],
      \ 'exclude_ft': ['qf'],
      \ })

nmap <silent> <M-w>         :BufferClose<CR>
nmap <silent> <M-W>         :BufferClose<CR>:wincmd c<CR>
nmap <silent> <leader>bC    :BufferClose<CR>:wincmd c<CR>
nmap <silent> <leader><M-w> :BufferClose!<CR>

" Magic buffer-picking mode
nnoremap <silent> <C-Space> :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Leader>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Leader>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <Leader>bc :BufferClose<CR>
nnoremap <silent> <Leader>bo :BufferCloseAllButCurrent<CR><CR>
" Move to previous/next
nnoremap <silent> <C-Tab>         :BufferNext<CR>
nnoremap <silent> <C-S-Tab>       :BufferPrevious<CR>
nnoremap <silent> <M-l>           :BufferNext<CR>
nnoremap <silent> <M-h>           :BufferPrevious<CR>
nnoremap <silent> <Leader><Tab>   :BufferNext<CR>
nnoremap <silent> <Leader><S-Tab> :BufferPrevious<CR>
" Re-order to previous/next
nnoremap <silent> <M-.> :BufferMoveNext<CR>
nnoremap <silent> <M-,> :BufferMovePrevious<CR>
" Goto buffer in position...
nnoremap <silent> <M-1> :BufferGoto 1<CR>
nnoremap <silent> <M-2> :BufferGoto 2<CR>
nnoremap <silent> <M-3> :BufferGoto 3<CR>
nnoremap <silent> <M-4> :BufferGoto 4<CR>
nnoremap <silent> <M-5> :BufferGoto 5<CR>
nnoremap <silent> <M-6> :BufferGoto 6<CR>
nnoremap <silent> <M-7> :BufferGoto 7<CR>
nnoremap <silent> <M-8> :BufferGoto 8<CR>
nnoremap <silent> <M-9> :BufferLast<CR>
nnoremap <silent> <Leader>1 :BufferGoto 1<CR>
nnoremap <silent> <Leader>2 :BufferGoto 2<CR>
nnoremap <silent> <Leader>3 :BufferGoto 3<CR>
nnoremap <silent> <Leader>4 :BufferGoto 4<CR>
nnoremap <silent> <Leader>5 :BufferGoto 5<CR>
nnoremap <silent> <Leader>6 :BufferGoto 6<CR>
nnoremap <silent> <Leader>7 :BufferGoto 7<CR>
nnoremap <silent> <Leader>8 :BufferGoto 8<CR>
nnoremap <silent> <Leader>9 :BufferLast<CR>

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

" -- VSnip --
let g:vsnip_snippet_dir = '~/.config/nvim/vsnip/'

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

" -- ConflictMotions --
nmap <leader>xb     :ConflictTake both<CR>
nmap <leader>x<Esc> <Esc>

if !exists('g:vscode')
  " -- Peekaboo --
  let g:peekaboo_delay = 300

  " -- Matchup --
  let g:matchup_matchparen_offscreen = {} " Disables displaying off-screen matching pair
endif

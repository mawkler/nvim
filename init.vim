" -- Vundle plugins --
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
Plugin 'bling/vim-airline'
Plugin 'powerline/fonts'
Plugin 'joshdick/onedark.vim'                " Atom dark theme for vim
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'scrooloose/nerdcommenter'
Plugin 'unblevable/quick-scope'
Plugin 'Valloric/MatchTagAlways'             " Highlight matching HTML tags
Plugin 'tmhedberg/matchit'                   " Ads `%` command for HTML tags
Plugin 'andymass/vim-matchup'                " Ads additional `%` commands
Plugin 'jiangmiao/auto-pairs'                " Add matching brackets, quotes, etc
Plugin 'neoclide/coc.nvim'
" Plugin 'dense-analysis/ale'                " Use either ALE or Syntastic
Plugin 'honza/vim-snippets'
Plugin 'easymotion/vim-easymotion'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter'              " Shows git status for each line
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'magicalbanana/vim-sql-syntax'
Plugin 'visualrepeat'                        " Allows repeating using `.` over visual selection
Plugin 'ingo-library'                        " Required by visualrepeat
Plugin 'capslock.vim'                        " Adds caps lock mapping to insert mode
Plugin 'StripWhiteSpaces'
Plugin 'ConflictMotions'                     " Adds motions for Git conflicts
Plugin 'restore_view.vim'                    " Automatically restores cursor position and folds
Plugin 'inkarkat/vim-CountJump'              " Dependency for ConflictMotions
Plugin 'MarcWeber/vim-addon-commandline-completion'
Plugin 'milkypostman/vim-togglelist'         " Adds mapping to toggle QuickFix window
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-function'
Plugin 'kana/vim-textobj-line'
Plugin 'kana/vim-textobj-entire'
Plugin 'kana/vim-niceblock'                  " Improves visual mode
Plugin 'haya14busa/vim-textobj-function-syntax'
Plugin 'AndrewRadev/dsf.vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'wellle/targets.vim'                  " Adds arguments, etc. as text objects
Plugin 'PeterRincker/vim-argumentative'      " Adds mappings for swapping arguments
Plugin 'google/vim-searchindex'              " Display index and number of search matches
Plugin 'Yggdroot/indentLine'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'captbaritone/better-indent-support-for-php-with-html'
Plugin 'romainl/vim-cool'                    " Highlights all search matches until moving cursor
Plugin 'haya14busa/incsearch.vim'            " Better incsearch
Plugin 'dkarter/bullets.vim'                 " Autocomplete markdown lists, etc.
Plugin 'plasticboy/vim-markdown'             " Adds extra features to markdown
Plugin 'mjbrownie/swapit'                    " For toggling words like `true` to `false`, etc.
Plugin 'tommcdo/vim-exchange'                " For swapping the place of two text objects
Plugin 'moll/vim-bbye'
Plugin 'Julian/vim-textobj-variable-segment' " Adds camel case and snake case text objects
Plugin 'wsdjeg/vim-fetch'                    " Process line and column jump specification in file path
Plugin 'wsdjeg/notifications.vim'
Plugin 'yuttie/comfortable-motion.vim'       " Smooth scrolling
Plugin 'markonm/traces.vim'                  " Better highlighting when searching/replacing
Plugin 'MaxMEllon/vim-jsx-pretty'
Plugin 'ryanoasis/vim-devicons'              " vim-devicons should be loaded last
Plugin 'meain/vim-printer'
Plugin 'lervag/vimtex'
Plugin 'rhysd/git-messenger.vim'
" Plugin 'camspiers/animate.vim'             " Causes bug with window sizes when opening :help
Plugin 'camspiers/lens.vim'                  " An automatic window resizing plugin
Plugin 'itchyny/vim-highlighturl'            " Highlights URLs everywhere
Plugin 'AndrewRadev/bufferize.vim'           " Execute a :command and show the output in a temporary buffer
Plugin 'benshuailyu/online-thesaurus-vim'    " Retrieves the synonyms and antonyms of a given word
Plugin 'mbbill/undotree'
call vundle#end()

" -- File imports --
source ~/.vim/visual-at.vim
autocmd VimEnter * source ~/.vim/nerdtree_custom_map.vim

if !empty(glob('~/.vimrc-private'))
  source ~/.vimrc-private
endif

" -- General --
syntax on
set vb t_vb=      " Disable error bells
set ttyfast       " Speed up drawing
set shortmess+=A  " Ignores swapfiles when opening file
set autoread      " Automatically read in the file when changed externally
autocmd! FocusGained,BufEnter * if mode() != 'c' | checktime | endif " Check if any file has changed
set termguicolors " Use GUI colors in terminal as well
set noshowmode    " Don't write out `--INSERT--`, etc.
set linebreak     " Don't break lines in the middle of a word
set showcmd       " Write out commands typed in status line
set hidden
set lazyredraw
set swapfile
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
set undodir=~/.vim/undo//
set viewoptions=cursor,folds,slash,unix

" -- Menu autocompletion --
set completeopt=longest,preview " menuone seems to be causing bug error with multiple-cursors
set wildmenu                    " List and cycle through autocomplete suggestions on Tab
set wildcharm=<Tab>             " Allows remapping of <Down> in wildmenu
set wildignorecase              " Case insensitive file- and directory name completion
set path+=**                    " Let's `find` search recursively into subfolders

" -- Searching --
set ignorecase " Case insensitive searching
set smartcase  " Except for when searching in CAPS
set incsearch  " Search while typing
set hlsearch   " Highligt all search matches

" -- Yankstack --
call yankstack#setup() " Has to be called before remap of any yankstack_yank_keys

" -- Key mappings --
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

map      <C-Tab>          :bnext<CR>
map      <C-S-Tab>        :bprevious<CR>
map      <leader><C-w>    :Bdelete<CR>
map      <leader><C-M-w>  :Bdelete!<CR>
nnoremap Y                y$
nnoremap yp               yyp
map      <leader>y        "+y
map      <leader>Y        "+Y
map      <leader>d        "+d
map      <leader>D        "+D
map      <leader>p        "+p
map      <leader>P        "+P
map!     <M-v>            <C-r>+
map      <C-q>            :qa<CR>
inoremap <Tab>            <C-t>
nnoremap <S-Tab>          <<
vnoremap <S-Tab>          <gv
imap     <S-Tab>          <C-d>
nnoremap <M-o>            <C-i>
map      <S-CR>           <C-w>W
" nnoremap <M-+>            :call animate#window_delta_height(2)<CR>
" nnoremap <M-->            :call animate#window_delta_height(-2)<CR>
" nnoremap +                :call animate#window_delta_width(5)<CR>
" nnoremap -                :call animate#window_delta_width(-5)<CR>
map      -                3<C-W><
map      +                3<C-W>>
nmap     <M-+>            <C-W>+
nmap     <M-->            <C-W>-
imap     <C-k>            <c-o>O
nnoremap <C-j>            o<Esc>
nmap     g<C-j>           i<CR><Esc>
nmap     <C-k>            O<Esc>
nmap     g<C-k>           DO<Esc>P_
nmap     gK               kjddkPJ<C-y>
nmap     <C-s>            :w<CR>
imap     <C-s>            <C-o>:w<CR>
vmap     <C-s>            <Esc>:w<CR>gv
nmap     d_               d^
nmap     <BS>             X
nmap     <S-BS>           x
nmap     <A-BS>           db
map!     <A-BS>           <C-w>
nmap     <A-S-BS>         dw
imap     <A-S-BS>         <C-o>dw
map      <M-d>            dw
imap     <C-j>            <CR>
map      <M-a>            v<C-a>
map      <M-x>            v<C-x>
" Cursor movement in cmd and insert mode--------
map!     <C-f>            <Right>
map!     <M-f>            <C-Right>
map!     <C-b>            <Left>
map!     <M-b>            <C-Left>
map!     <M-h>            <Left>
map!     <M-j>            <Down>
map!     <M-k>            <Up>
map!     <M-l>            <Right>
map!     <M-w>            <C-Right>
cmap     <C-a>            <Home>
cmap     <C-p>            <Up>
cmap     <C-n>            <Down>
imap     <M-o>            <C-o>o
imap     <M-O>            <C-o>O
"----------------------------------------------
map      <M-j>            }
map      <M-k>            {
map      <C-Space>        zt
map      <leader>¨        <C-]>
map      <C-¨>            <C-]>
map      <C-W><C-]>       <C-w>v<Plug>(coc-definition)
map      <C-W>¨           <C-w><C-]>
map      ¨                ]
map      å                [
map      ¨¨               ]]
map      åå               [[
nmap     ö                ;
nmap     Ö                :
nmap     <C-c>            <Nop>
" vim-surround----------------------------------
vmap     s                <Plug>VSurround
vmap     S                <Plug>VgSurround
sunmap   s
sunmap   S
nmap     s                ys
nmap     S                ys$
onoremap ir               i]
onoremap ar               a]
" ----------------------------------------------
vmap     <                <gv
vmap     >                >gv
map      <leader>;        :call VisualAppend(";")<CR>
map      <leader>,        :call VisualAppend(",")<CR>
map      <leader>.        :call VisualAppend(".")<CR>
map      <leader>?        :call VisualAppend("?")<CR>
map      <leader>v        :source ~/.config/nvim/init.vim<CR>
map      <leader>V        :edit ~/.vimrc<CR>
map      <leader>N        :edit ~/.config/nvim/init.vim<CR>
map      <leader>G        :edit ~/.config/nvim/ginit.vim<CR>
map      <leader>Z        :edit ~/.zshrc<CR>
map      <leader>I        :edit ~/.dotfiles/install-dotfiles.sh<CR>
map      <leader>M        :cd $DROPBOX/Dokument/Markdowns/<CR>:echo "cd " . $DROPBOX . "Dokument/Markdowns/"<CR>
map      <leader>E        :cd $DROPBOX/Exjobb/<CR>:echo "cd " . $DROPBOX . "Exjobb/"<CR>
map      <leader>~        :cd ~<CR>
map      gX               :exec 'silent !google-chrome-stable % &'<CR>
nmap     gF               :e <C-r>+<CR>
nmap     <leader>F        :let @+ = expand("%")<CR>:echo "Yanked file path: <C-r>+"<CR>
vnoremap .                :normal .<CR>
vnoremap //               y/<C-R>"<CR>
noremap  /                ms/
noremap  *                ms*
map      '/               `s
map      <leader>/        :execute '/\V' . escape(input('/'), '\\/')<CR><C-r>+<CR>
map      g/               /\<\><Left><Left>
map      <leader>S        :setlocal spell!<CR>:echo "Toggled spell checking"<CR>
nmap     <leader>r        :%substitute/<C-R><C-W>//gci<Left><Left><Left><Left>
nmap     <leader>R        :%substitute/<C-R><C-W>//I<Left><Left>
vmap     <leader>r        y:<C-U>%substitute/<C-R>0//gci<Left><Left><Left><Left>
vmap     <leader>R        y:<C-U>%substitute/<C-R>0//I<Left><Left>
map      <leader>gd       <C-w>v<C-w>lgdzt<C-w><C-p>
map      Q                @@
map      <leader>q        qqqqq
nnoremap §                <C-^>
tnoremap <Esc>            <C-\><C-n>
nmap     cg*              *Ncgn
xnoremap g.               .
nmap     dage             viw<Esc>bhdaw
nmap     cage             viw<Esc>bhcaw

nmap <silent> <expr> <leader>z &spell ? "1z=" : ":setlocal spell!<CR>1z="
map           <expr> o         &modifiable ? "o" : "\<CR>"
map           <expr> <CR>      &modifiable ? "\<Plug>NERDCommenterToggle" : "\<CR>"

augroup vertical_help " Open :help in vertical instead of horizontal split
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

 " Appends `char` to current line or visual selection
function! VisualAppend(char)
  exe "normal! m0"
  exe "normal! A" . a:char
  exe "normal! `0"
endfunction

" Prints the syntax highlighting values under cursor
function! SynStack()
  if exists("*synstack")
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endif
endfunc
map <leader>H :call SynStack()<CR>

" Tries to perform a regular `gf`, if that doesn't work try to call
" vim-markdown's Markdown_EditUrlUnderCursor
function MarkdownGf()
  set path-=**
  try
    normal! gf
  catch:
    execute "normal \<Plug>Markdown_EditUrlUnderCursor"
  endtry
  set path+=**
endfunc
noremap gf :call MarkdownGf()<CR>

if has("gui_running") " Gvim specific configuration
  set lines=999 columns=999 " Start in maximized window
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
endif

if has('nvim')
  " Because NeoVim's menu completions are in a vertical pum
  cmap <expr> <C-p> pumvisible() ? "\<C-p>" : "\<Up>"
  cmap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<Down>"
  cmap <expr> <C-j> pumvisible() ? "\<Down>" : "\<CR>"
  cmap <expr> <C-f> pumvisible() ? "\<C-e>" : "\<Right>"
endif

if exists('$TMUX')
  set notermguicolors " Tmux screws up the colors if `set termguicolors` is used
endif

" -- Language specific mappings --
autocmd filetype *           nnoremap <buffer> <Tab> ==
autocmd filetype *           vnoremap <buffer> <Tab> =gv
autocmd filetype python,markdown nmap <buffer> <Tab> >>
autocmd filetype python,markdown vmap <buffer> <Tab> >gv

" -- netrw --
let g:netrw_silent = 1
" let g:netrw_preview = 1
let g:netrw_browse_split = 0
" let g:netrw_altv = 1
autocmd filetype netrw nmap <buffer> o <CR>

" -- Lines and cursor --
set number relativenumber
hi  CursorLineNr term=bold gui=bold
set cursorline                    " Cursor highlighting
set scrolloff=8                   " Cursor margin
set textwidth=0                   " Disable auto line breaking
set nrformats+=hex,bin            " Allow Ctrl-A/X for hex and binary
set guicursor+=n:blinkwait0       " Disables cursor blinking in normal mode
set guicursor+=i:ver25-blinkwait0 " And in insert mode
set mouse=a                       " Enable mouse
set conceallevel=2                " Hide concealed characters completely
set concealcursor=nic             " Conceal characters on the cursor line
" Except for in markdown and LaTeX files (LaTeX files' config don't seem to be overwritten though)
autocmd Filetype markdown,latex,tex setlocal concealcursor=""

" -- Tab characters --
filetype plugin indent on
set expandtab                              " Use spaces for indentation
set shiftwidth=2                           " Width of indentation
set tabstop=4                              " Width of <Tab> characters
set list listchars=tab:\▏\                 " Show line for each tab indentation
set autoindent                             " Follow previous line's indenting
set backspace=indent,eol,start             " Better backspace behaviour
set cinkeys-=0#                            " Indent lines starting with `#`
au  filetype css,python setlocal sw=4 ts=4 " Custom filetype indent settings

" Disable toolbar, scrollbar and menubar
set guioptions-=T
set guioptions-=r
set guioptions-=m
set guioptions-=L

" Command to change directory to the current file's
command! CDHere cd %:p:h

" Format JSON file to readable form
command! JSONFormat %!python -m json.tool

" -- Quickscope (highlight settings have to come before setting `colorscheme`) --
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight default link QuickScopePrimary EasyMotionTarget
  autocmd ColorScheme * highlight default link QuickScopeSecondary markdownBold
  autocmd ColorScheme * highlight default link QuickScopePrimary EasyMotionTarget
  autocmd ColorScheme * highlight default link QuickScopeSecondary markdownBold
augroup END

" -- Themes --
colorscheme onedark   " Atom color scheme
let g:onedark_termcolors = 256
set encoding=utf-8
set fillchars+=vert:▏ " Adds nicer lines for vertical splits

" -- Vundle --
cnoreabbrev PlugInstall PluginInstall

" -- IndentLine --
autocmd BufEnter,BufRead * let b:indentLine_enabled = 1
autocmd BufEnter,BufRead *.json
      \ let b:indentLine_enabled = 0 |
      \ setlocal conceallevel=1 |
      \ setlocal concealcursor=""
autocmd BufEnter *.txt if &buftype == 'help' | let b:indentLine_enabled = 0
let g:indentLine_color_gui = '#4b5263'
let g:indentLine_char = '▏'
let g:indentLine_setConceal = 0 " Doesn't hide quotes in JSON files

" For toggling caps lock in insert mode
imap <C-C> <Plug>CapsLockToggle

" -- Vim-easy-align --
" Start in visual mode (e.g. vipga):
xmap ga <Plug>(EasyAlign)
" Start for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" -- Vim-easymoion --
" <leader>f{char} to move to {char}:
map  <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}:
nmap <leader>s <Plug>(easymotion-overwin-f2)
" Move to word:
map  <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)

" -- NERDCommenter --
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters
let g:NERDTrimTrailingWhitespace = 1 " Trim trailing whitespace when uncommenting
let g:NERDCustomDelimiters = {
\ 'html': { 'left': '<!-- ', 'right': '-->', 'leftAlt': '//'},
\ 'javascript': { 'left': '//', 'leftAlt': '<!-- ', 'rightAlt': '-->'}
\ }
map <leader>C <plug>NERDCommenterToEOL

" -- Gitgutter --
set updatetime=100

" -- AutoPairs --
let g:AutoPairsShortcutToggle     = '' " Disables some mappings
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsShortcutFastWrap   = ''
let g:AutoPairsShortcutJump       = ''
let g:AutoPairsMoveCharacter      = ''

" -- For editing multiple files with `*` --
com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"

" " -- Targets.vim --
" let g:targets_nl   = 'nN'   " Uses `N` instead of `l` for moving targeting backwards
let g:targets_aiAI = 'aIAi' " Swaps meaning of `I` and `i`

" -- Vim Fugitive --
cnoreabbrev Gdiff Gvdiff

" -- Vim Sleuth --
let g:sleuth_automatic = 1

" -- Coc.nvim --
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> <leader>rn <Plug>(coc-rename)
" Use `<CR>` to confirm completion
imap <C-j> <NL>
imap <expr> <NL> pumvisible() ? "\<C-y>" : "\<CR>"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
set statusline+=%{coc#status()}

let g:coc_snippet_next = '<Tab>'   " Use Tab to jump to next place in snippet
let g:coc_snippet_prev = '<S-Tab>' " Use Shift-Tab to jump to previous place in snippet

let g:coc_global_extensions = [
  \ 'coc-syntax',
  \ 'coc-tag',
  \ 'coc-snippets',
  \ 'coc-python',
  \ 'coc-java',
  \ 'coc-ccls',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-prettier',
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-yank',
  \ 'coc-stylelint',
  \ 'coc-calc',
  \ 'coc-eslint',
  \ 'coc-tslint',
  \ 'coc-tslint-plugin',
  \ 'coc-explorer',
  \ 'coc-vimtex',
  \ 'coc-bibtex',
  \ 'coc-texlab',
  \ 'coc-omnisharp',
  \ 'coc-tabnine'
  \]

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" coc-explorer
" noremap <silent> ½ :execute 'CocCommand explorer --file-columns=selection,icon,clip,indent,filename,size ' . expand('%:p:h')<CR>
noremap <silent> ½ :execute 'CocCommand explorer'<CR>

" coc-snippets
vmap gs <Plug>(coc-snippets-select)

" -- Commentary --
nmap cm <Plug>Commentary

" -- swapit --
autocmd VimEnter * SwapList BOOLEANS TRUE FALSE
autocmd VimEnter * SwapList numbers
\ zero one two three four five six seven eight nine ten eleven twelve
autocmd VimEnter * SwapList nummer
\ noll en ett två tre fyra fem sex sju åtta nio tio elva tolv

" -- textobj-function --
let g:textobj_function_no_default_key_mappings = 1
vmap aF <Plug>(textobj-function-A)
omap aF <Plug>(textobj-function-A)
vmap iF <Plug>(textobj-function-i)
omap iF <Plug>(textobj-function-i)

" -- Cool.vim --
if has('nvim') || has('gui_running')
  " Causes regular Vim to launch in replace mode for some reason
  nmap <silent> <Esc> :nohlsearch<CR>
endif

" -- exchange.vim --
vmap x <Plug>(Exchange)
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

" -- Java syntax highlighting --
let g:java_highlight_functions = 1
let g:java_highlight_all = 1

" -- Comfortable motion --
let g:comfortable_motion_friction = 300.0
let g:comfortable_motion_air_drag = 0.0

" -- Fzf --
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
let $FZF_DEFAULT_OPTS='--bind ctrl-j:accept,alt-k:up,alt-j:down --history=' . $HOME . '/.fzf_history'
" Preview window
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, {
      \ 'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']
      \ }, <bang>0)

" -- vim-printer --
let g:vim_printer_print_below_keybinding = 'gp'
let g:vim_printer_print_above_keybinding = 'gP'

" -- LaTeX and Vimtex --
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura' " Zathura automatically reloads documents
let g:tex_comment_nospell=1
let g:surround_{char2nr('c')} = "\\\1command\1{\r}" " Add vim-surround noun `c`
let g:vimtex_toc_config = {
      \ 'layer_status': { 'label': 0 }
      \ }

" Disable custom warnings based on regexp
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull \\hbox',
      \]

" -- textobj-entire --
let g:textobj_entire_no_default_key_mappings=1
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

" -- togglelist.vim --
let g:toggle_list_no_mappings=1
nmap <script> <silent> <leader>L :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>Q :call ToggleQuickfixList()<CR>

" -- lens.vim --
let g:lens#disabled_filetypes = ['coc-explorer', 'fzf']

" -- vim-markdown --
let g:vim_markdown_folding_disabled = 1
" Make italic words actually look italic in Markdown
hi htmlItalic cterm=italic gui=italic
" Underline link names in Markdown in-line links
hi mkdLink cterm=underline gui=underline
" Underline Markdown URLs
hi mkdInlineURL guifg=#61AFEF gui=underline

" --- vim-highlighturl ---
" Disable vim-highlighturl in Markdown files
augroup highlighturl-filetype
  autocmd!
  autocmd FileType markdown call highlighturl#disable_local()
augroup END
let g:highlighturl_guifg = '#61AFEF'

if !exists("g:gui_oni") " ----------------------- Oni excluded stuff below -----------------------

" -- Airline --
set laststatus=2 " Always display status line
let g:airline_powerline_fonts = 1
let g:airline_theme           = 'onedark'
let g:Powerline_symbols       = 'unicode'
let g:airline_section_x       = '%{&filetype}' " Don't shorten file type on small window
" let g:airline_left_sep = "\ue0bc"
" let g:airline_right_sep = "\ue0be"
" let g:airline_left_alt_sep = "\ue0bd"
" let g:airline_right_alt_sep = "\ue0bf"

" -- Airline Tabline --
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#close_symbol = '✕'
let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#left_sep = ' '
map <leader>1 <Plug>AirlineSelectTab1
map <leader>2 <Plug>AirlineSelectTab2
map <leader>3 <Plug>AirlineSelectTab3
map <leader>4 <Plug>AirlineSelectTab4
map <leader>5 <Plug>AirlineSelectTab5
map <leader>6 <Plug>AirlineSelectTab6
map <leader>7 <Plug>AirlineSelectTab7
map <leader>8 <Plug>AirlineSelectTab8
map <leader>9 :blast<CR>

" -- AutoComplPop --
let g:acp_completeOption = '.,w,b,k,u,t'

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" autocmd CompleteDone * pclose " Auto close `scratch` window after autocompletion

" -- CtrlP --
map <C-M-p> :CtrlPMRUFiles<CR>
let g:ctrlp_show_hidden       = 1
let g:ctrlp_max_depth         = 100
let g:ctrlp_working_path_mode = ''
let g:ctrlp_max_height        = 12
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor                           "  Use ag over grep
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""' "  Use ag in CtrlP for listing files
  let g:ctrlp_use_caching = 0                                    "  ag doesn't need to cache
else
  let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](\.(git||vim/bundle|npm|config|chromium|cargo)|node_modules)$',
    \ 'file': '\v(\.(exe|sw.|dll|pyc)|__init__.py)$',
    \ }
endif
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<C-j>', '<CR>'],
  \ 'PrtSelectMove("j")':   ['<m-j>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<m-k>', '<up>'],
  \ } " Open files with Ctrl-O

" -- vim-devicons --
let g:webdevicons_enable                      = 1
let g:webdevicons_enable_ctrlp                = 1
let g:webdevicons_enable_nerdtree             = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsUnicodeDecorateFolderNodes   = 0 " Disabled because of bug with spacing after icon
let g:DevIconsEnableNERDTreeRedraw            = 1
let g:WebDevIconsNerdTreeBeforeGlyphPadding   = ''
if has("gui_running")
  let g:WebDevIconsNerdTreeAfterGlyphPadding  = ''
endif
if exists('g:loaded_webdevicons')
  call webdevicons#refresh() " Fixes bug with `[]` appearing around icons after `source ~/.vimrc`
endif

" " -- ALE --
" let g:ale_fix_on_save = 1
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_python_prospector_executable = 'python' " Use Python 2. Change to 'python3' for Python 3
" let g:ale_python_autopep8_options = '--aggressive --max-line-length 160'
" let g:ale_fixers  = {
" \   '*':          ['remove_trailing_lines', 'trim_whitespace'],
" \   'javascript': ['prettier', 'eslint'],
" \   'python':     ['autopep8']
" \}
" let g:ale_linters = {
" \   'python': ['flake8'],
" \   'c':      ['gcc -fopenmp'],
" \   'cpp':    ['g++ -fopenmp']
" \}
" command! ALEDisableFixOnSave let g:ale_fix_on_save=0
" command! ALEEnableFixOnSave let g:ale_fix_on_save=1

" -- Vim-lsc --
let g:lsc_server_commands = { 'javascript': 'javascript-typescript-stdio' }
let g:lsc_auto_map        = { 'GoToDefinition': '<leader>g' }

" -- Vim-javascript --
hi clear jsStorageClass " Change color of 'var'
hi link jsStorageClass Keyword

" ColorScheme corrections
hi! link Search Visual
hi! link SpecialKey Directory

endif

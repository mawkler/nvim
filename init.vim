"Vundle plugins

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'powerline/fonts'
Plugin 'joshdick/onedark.vim'          "Atom dark theme for vim
Plugin 'vim-scripts/zoom.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
if hostname() != "esekilxv7127"
    Plugin 'ryanoasis/vim-devicons'
    Plugin 'Valloric/MatchTagAlways'
    Plugin 'ryanoasis/nerd-fonts'
endif
"Plugin 'valloric/youcompleteme'
Plugin 'easymotion/vim-easymotion'
Plugin 'mattn/emmet-vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jiangmiao/auto-pairs'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'magicalbanana/vim-sql-syntax'
Plugin 'vim-scripts/AutoComplPop'      "Automatically pop up word suggestions
"Plugin 'Shutnik/jshint2.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'ervandew/supertab'
Plugin 'ap/vim-buftabline'             "Better vim tabs
Plugin 'scrooloose/nerdcommenter'
"Plugin 'fholgado/minibufexpl.vim'
"Plugin 'drmingdrmer/vim-tabbar'
"Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-repeat'
Plugin 'tmhedberg/matchit'
Plugin 'ihacklog/HiCursorWords'         "Highligt all occurences of current word
Plugin 'MarcWeber/vim-addon-commandline-completion'

"For SnipMate "----------------------
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
"------------------------------------


"Ericsson
Plugin 'Yggdroot/indentLine'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'vim-scripts/capslock.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'captbaritone/better-indent-support-for-php-with-html'

call vundle#end()
filetype plugin indent on
syntax on

"------------------------------------------------------------------------------

"File imports
source ~/.vim/visual-at.vim

"Autocompletion
set completeopt=longest,preview "menuone seems to be causing bug error with multiple-cursors
set wildmenu                    "List and cycle through autocomplete suggestions on Tab
set wildcharm=<Tab> "Allows remapping of <Down> in wildmenu

"Tab characters
filetype plugin indent on "show existing tab with 4 spaces width
"set tabstop=4 "when indenting with '>', use 4 spaces width
"set shiftwidth=2 "On pressing tab, insert 2 spaces
"set expandtab

"Searching
set ignorecase "Case insensitive searching
set smartcase  "Except for when searching in CAPS
set incsearch  "Search while typing

"Key mapping
set hidden
let mapleader = "\<Space>"

nmap <silent> §     :NERDTreeToggle<CR>

map      <C-Tab>         :bnext<CR>
map      <C-S-Tab>       :bprevious<CR>
nmap     <C-CR>          <leader>c<space>
vmap     <C-CR>          <leader>c<space>
imap     <C-CR>          <Up><End><CR>
nnoremap Y               y$
map      <leader>y       "+y
map      <leader>Y       "+Y
map      <leader>p       "+p
map      <leader>P       "+P
map!     <C-v>           <C-r>+
map      <leader><C-w>   :NERDTreeClose<CR>:bdelete<CR>
map      <leader><C-M-w> :NERDTreeClose<CR>:bdelete!<CR>
map      <C-q>           :qa<CR>
"nnoremap <Tab>           ==
"vnoremap <Tab>           =gv
nnoremap <S-Tab>         <<
vnoremap <S-Tab>         <gv
inoremap <S-Tab>         <C-o><<
autocmd  BufEnter *      nnoremap <Tab> ==
autocmd  BufEnter *      vnoremap <Tab> =gv
autocmd  BufEnter *.py      nmap <Tab> >>
autocmd  BufEnter *.py      vmap <Tab> >gv
map      <CR>            <C-w><C-w>
map      <S-CR>          <C-w>W
nmap     <C-j>           o<Esc>
nmap     <C-k>           O<Esc>
"nmap     <C-s>           :set buftype=<CR>:w<CR>
nmap     <C-s>           :w<CR>
"the `:set buftype=` fixes a bug with tcp
imap     <C-s>           <C-o>:w<CR>
vmap     <C-s>           <Esc>:w<CR>gv
nmap     d_              d^
nmap     <BS>            X
nmap     <S-BS>          x
nmap     <A-BS>          db
map!     <A-BS>          <C-w>
nmap     <A-S-BS>        dw
imap     <A-S-BS>        <C-o>dw
map      <M-d>           dw
imap     <C-j>           <CR>
map      <M-a>           v<C-a>
map      <M-x>           v<C-x>
"Cursor movement in cmd and insert mode--------
map!     <C-f>           <Right>
map!     <M-f>           <C-Right>
map!     <C-b>           <Left>
map!     <M-b>           <C-Left>
map!     <M-h>           <Left>
map!     <M-j>           <Down>
map!     <M-k>           <Up>
map!     <M-l>           <Right>
map!     <M-w>           <C-Right>
cmap     <C-a>           <Home>
cmap     <C-p>           <Up>
cmap     <C-n>           <Down>
imap     <M-o>           <C-o>o
imap     <M-O>           <C-o>O
"----------------------------------------------
map      <M-j>           }
map      <M-k>           {
map      <C-Space>       zz
nmap     ö               ciw
nmap     Ö               ciW
nmap     ä               viw
nmap     Ä               viW
nmap     å               ci(
nmap     Å               ci"
nmap     <C-c>           <Nop>
"vim-surround----------------------------------
vmap     s               <Plug>VSurround
vmap     S               <Plug>VgSurround
nmap     s               ys
nmap     S               yS
"----------------------------------------------
vmap     <               <gv
vmap     >               >gv
map      <Leader>v       :source ~/.vimrc<CR>
map      <Leader>V       :edit ~/.vimrc<CR>
map      <Leader>Z       :edit ~/.zshrc<CR>
map      <leader>U       :cd ~/Dropbox/Uppsala/<CR>
nmap     gF              :e <C-r>+<CR>
nmap     <leader>F       :let @+ = expand("%")<CR>:echo "Yanked file path: <C-r>+"<CR>
vnoremap .               :normal .<CR>
vnoremap //              y?<C-R>"<CR>
map      <leader>/       :execute '/\V' . escape(input('/'), '\\/')<CR><C-r>+<CR>
map      <leader>S       :setlocal spell!<CR>:echo "Toggled spell checking"<CR>

"Line numbering
set number
set relativenumber
hi CursorLineNr term=bold ctermfg=Yellow gui=bold guifg=Yellow

set cursorline  "Cursor highlighting
set scrolloff=8 "Cursor margin
set textwidth=0 "Disable auto line breaking

"Themes
colorscheme onedark
let g:onedark_termcolors = 256
set encoding=utf8

"Airline
set laststatus=2 "Always display status line
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
let g:airline_powerline_fonts = 1
let g:airline_theme           = 'onedark'
let g:Powerline_symbols       = 'unicode'

"NERDTree
"autocmd vimenter * NERDTree
let NERDTreeIgnore = ['\.pyc$', 'radiosw$', '__init__.py']
"If not in NERDTree go to it, if in NERDTree close it (doens't work yet)
"autocmd FileType nerdtree noremap <buffer> § :NERDTreeClose<CR>

"Disable toolbar, scrollbar and menubar
set guioptions-=T
set guioptions-=r
set guioptions-=m
set guioptions-=L

"Start in maximized window
"if has("gui_running")
    "set lines=999 columns=999
"endif

"YouCompleteMe
"let g:ycm_path_to_python_interpreter = '/usr/bin/python'
"let g:ycm_min_num_of_chars_for_completion = 1
"let g:ycm_auto_trigger = 1

"Emmet
let g:user_emmet_install_global = 1
let g:user_emmet_mode           = 'a' "enable all function in all mode.

"Gitgutter
set updatetime=100

set runtimepath+=~/.vim/bundle/jshint2.vim/

"Yankstack
let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 'x', 'X', 'y', 'Y']
call yankstack#setup()

"AutoPairs disable <M-p>
let g:AutoPairsShortcutToggle     = ''
let g:AutoPairsShortcutBackInsert = ''

"Vim-tabbar colorscheme
hi default link BufTabLineCurrent Pmenu
hi default link BufTabLineActive  TabLineSel
hi default link BufTabLineHidden  TabLine
hi default link BufTabLineFill    TabLineFill

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0
let g:syntastic_enable_highlighting      = 1

"Supertab and Snipmate
let g:SuperTabCrMapping             = 1
let g:SuperTabMappingForward        = '<C-n>'
let g:SuperTabMappingBackward       = '<C-b>'
let g:SuperTabDefaultCompletionType = 'context'
smap <Tab> <Plug>snipMateNextOrTrigger
imap <Tab> <Plug>snipMateNextOrTrigger

"CtrlP
map <C-M-p> :CtrlPMRUFiles<CR>
let g:ctrlp_show_hidden       = 1
let g:ctrlp_max_depth         = 100
let g:ctrlp_working_path_mode = ''
let g:ctrlp_max_height = 12
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor                           " Use ag over grep
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""' " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_use_caching = 0                                    " ag is fast enough that CtrlP doesn't need to cache
else
  let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](\.(git|dotfiles|vim/bundle|npm|config|chromium)|node_modules)$',
    \ 'file': '\v(\.(exe|sw.|dll|pyc)|__init__.py)$',
    \ }
endif

"vim-devicons
let g:webdevicons_enable                      = 1
let g:webdevicons_enable_ctrlp                = 1
let g:webdevicons_enable_nerdtree             = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding    = ''
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsUnicodeDecorateFolderNodes   = 1

set guicursor=n:blinkwait0 "Disables cursor blinking
"set virtualedit=onemore    "Allow for cursor beyond last character

"Ericsson
set swapfile
set directory^=~/.vim/tmp//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set shortmess+=A "Ignores swapfiles when opening file
set autoread     "Automatically read in the file when changed externally

set list lcs=tab:\|\ "Show line for each tab indentation
set shiftwidth=2     "Use indent of 2 spaces
autocmd Filetype javascript setlocal sw=4 "But 4 for JavaScript
set tabstop=4        "An indentation every fourth column
set autoindent       "Follow previous line's indenting
set expandtab        "Tabs are spaces
let g:syntastic_python_pylint_args = '--rcfile=./.pylintrc'
"set autochdir "Change the directory to the current file's
set backspace=indent,eol,start "Better backspace
autocmd FileType python set expandtab

"indentLine
autocmd FileType json let g:indentLine_enabled   = 0
autocmd FileType python let g:indentLine_enabled = 1
"let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
let g:indentLine_color_gui  = '#4b5263'
let g:indentLine_char       = '|'
"let g:syntastic_python_checkers=["flake8"]
"""g:vim_json_syntax_conceal = 0

"Underlines AutoHighligted word:
"highlight Search guibg=NONE guifg=NONE gui=underline
let g:HiCursorWords_delay = 1 "Delay after highlighting current word, low dealy may cause lag

"For toggling caps lock in insert mode
imap <C-C> <Plug>CapsLockToggle

"Vim-easy-align
"Start in visual mode (e.g. vipga):
xmap ga <Plug>(EasyAlign)
"Start for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Vim-easymoion
"<Leader>f{char} to move to {char}:
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
"s{char}{char} to move to {char}{char}:
nmap <Leader>s <Plug>(easymotion-overwin-f2)
"Move to line:
map  <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
"Move to word:
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"Attempt to fix conflict between multiple_cursors and AutoComplPop
"nnoremap <C-m> :call multiple_cursors#new()<CR>
"xnoremap <C-m> :call multiple_cursors#new()<CR>

if !empty(glob('~/.vimrc.ericsson'))
  source ~/.vimrc.ericsson
endif

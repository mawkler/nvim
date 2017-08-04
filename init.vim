"Vundle plugins

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
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
Plugin 'vim-scripts/AutoComplPop'      "Automatically pop up word suggestsions
"Plugin 'Shutnik/jshint2.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'ervandew/supertab'
Plugin 'ap/vim-buftabline'             "Better vim tabs
Plugin 'scrooloose/nerdcommenter'
"Plugin 'fholgado/minibufexpl.vim'
"Plugin 'drmingdrmer/vim-tabbar'
Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-repeat'
Plugin 'tmhedberg/matchit'
Plugin 'ihacklog/HiCursorWords'         "Highligt all occurences of current word

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

call vundle#end()
filetype plugin indent on
syntax on

"------------------------------------------------------------------------------

"File imports
source ~/.vim/visual-at.vim

"Autocompletion
"set completeopt=longest,menuone "Seems to be causing bug error with multiple-cursors

"Tab characters
filetype plugin indent on "show existing tab with 4 spaces width
"set tabstop=4 "when indenting with '>', use 4 spaces width
"set shiftwidth=2 "On pressing tab, insert 2 spaces
"set expandtab

"Search insensetive
set ignorecase
set smartcase

"Key mapping
set      hidden
let      mapleader       = "\<Space>"
map      <C-Tab>         :bnext<CR>
map      <C-S-Tab>       :bprevious<CR>
nmap     <silent>        § :NERDTreeToggle<CR>
nmap     <C-CR>          <leader>c<space>
vmap     <C-CR>          <leader>c<space>
imap     <C-CR>          <Up><End><CR>
map      <leader>y       "+y
map      <leader>Y       "+Y
map      <leader>p       "+p
map      <leader>P       "+P
map      <leader><C-w>   :NERDTreeClose<CR>:bdelete<CR>
map      <leader><C-M-w> :NERDTreeClose<CR>:bdelete!<CR>
map      <C-Q>           :qa<CR>
nmap     <Tab>           ==
vmap     <Tab>           =gv
nmap     <S-Tab>         <<
vmap     <S-Tab>         <gv
imap     <S-Tab>         <C-o><<
map      <CR>            <C-w><C-w>
map      <S-CR>          <C-w>W
nmap     <C-j>           o<Esc>
nmap     <C-k>           O<Esc>
map      <C-s>           :w<CR>
nmap     <A-BS>          db
map!     <A-BS>          <C-w>
nmap     <A-S-BS>        dw
imap     <A-S-BS>        <C-o>dw
map      <M-d>           dw
map      <C-Space>       <Esc>
imap     <C-Space>       <Esc>
imap     <C-f>           <Right>
imap     <M-f>           <C-Right>
imap     <C-b>           <Left>
imap     <M-b>           <C-Left>
map      <M-j>           :move +1<CR>
map      <M-k>           :move -2<CR>
imap     <C-j>           <CR>
autocmd  FileType        Python nmap <Tab> >>
autocmd  FileType        Python vmap <Tab> >gv
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
imap     <M-h>           <Left>
imap     <M-j>           <Down>
imap     <M-k>           <Up>
imap     <M-l>           <Right>
imap     <M-o>           <C-o>o
imap     <M-O>           <C-o>O
nmap     gF              :e <C-r>+<CR>
nmap     <leader>F       :let @+ = expand("%")<CR>
vnoremap .               :normal .<CR>

"Enable numbering
set number
set relativenumber
hi CursorLineNr term=bold ctermfg=Yellow gui=bold guifg=Yellow

set cursorline  "Cursor highlighting
set scrolloff=8 "Cursor margin
set textwidth=0 "Disable auto line breaking

"Themes
colorscheme onedark
let g:onedark_termcolors = 256
let g:airline_theme      = 'onedark'

set encoding=utf8

"Airline
set laststatus=2 "Always display status line
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
let g:Powerline_symbols = 'unicode'


"NERDTree
"autocmd vimenter * NERDTree
let NERDTreeIgnore = ['\.pyc$', 'radiosw$']

"vim-devicons, doesn't seem to work
let g:webdevicons_enable                    = 1
let g:webdevicons_enable_nerdtree           = 1
let g:webdevicons_enable_airline_tabline    = 1
let g:webdevicons_enable_airline_statusline = 1

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
    \ 'dir': '\v[\/](\.(git|dotfiles|vim/bundle|npm|config|chromium|google-chrome|mozilla|snapshot|kde|eclipse|m2)|node_modules|radiosw|chromium|trash|workspace)$',
    \ 'file': '\v\.(exe|sw.|dll|pyc)$',
    \ }
  nmap <C-M-p> :CtrlP ~/servit/radiosw/external/xRU/database/<CR>
endif

set guicursor=n:blinkwait0 "Disables cursor blinking in visual mode



"Ericsson
set swapfile
set directory^=~/.vim/tmp//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set shortmess+=A "Ignores swapfiles when opening file



set list lcs=tab:\|\ "Show line for each tab indentation
"set autoindent noexpandtab tabstop=4 shiftwidth=4 "use tabs instead of spaces
set autoindent expandtab tabstop=4 shiftwidth=2    "use spaces instead of tabs
set autoread
let g:syntastic_python_pylint_args = '--rcfile=./.pylintrc'
"set autochdir "Change the directory to the current file's
set backspace=indent,eol,start
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
set incsearch "Search while typing

"Underlines AutoHighligted word:
"highlight Search guibg=NONE guifg=NONE gui=underline
let g:HiCursorWords_delay = 1 "Delay after highlighting current word, low dealy may cause lag

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

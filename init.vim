set nocompatible
filetype off

" -- Vundle plugins --
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-speeddating'
Plugin 'bling/vim-airline'
Plugin 'powerline/fonts'
Plugin 'joshdick/onedark.vim'          " Atom dark theme for vim
" Plugin 'vim-scripts/zoom.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'ryanoasis/vim-devicons'
" Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Valloric/MatchTagAlways'
Plugin 'ryanoasis/nerd-fonts'
" Plugin 'valloric/youcompleteme'
Plugin 'easymotion/vim-easymotion'
Plugin 'mattn/emmet-vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jiangmiao/auto-pairs'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'magicalbanana/vim-sql-syntax'
Plugin 'vim-scripts/AutoComplPop'      " Automatically pop up word suggestions
" Plugin 'Shutnik/jshint2.vim'
" Plugin 'vim-syntastic/syntastic'
Plugin 'w0rp/ale'                      " Use either ALE or Syntastic
Plugin 'ervandew/supertab'
Plugin 'ap/vim-buftabline'             " Better vim tabs
Plugin 'scrooloose/nerdcommenter'
" Plugin 'fholgado/minibufexpl.vim'
" Plugin 'drmingdrmer/vim-tabbar'
" Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-repeat'
Plugin 'tmhedberg/matchit'
" Plugin 'ihacklog/HiCursorWords'         " Highligt all occurences of current word
Plugin 'MarcWeber/vim-addon-commandline-completion'
Plugin 'milkypostman/vim-togglelist'
" Plugin 'autozimu/LanguageClient-neovim' " LSP
Plugin 'natebosch/vim-lsc'
Plugin 'vim-scripts/argtextobj.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-function'
Plugin 'vim-scripts/visualrepeat'
Plugin 'wellle/targets.vim'
Plugin 'michaeljsmith/vim-indent-object'

" For SnipMate -----------------------
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
" ------------------------------------

" Ericsson
Plugin 'Yggdroot/indentLine'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'vim-scripts/capslock.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'captbaritone/better-indent-support-for-php-with-html'

call vundle#end()

"------------------------------------------------------------------------------

" -- File imports --
source ~/.vim/visual-at.vim

if !empty(glob('~/.vimrc-private'))
  source ~/.vimrc-private
endif

" -- General --
syntax on
set vb t_vb= " Disable error bells
set ttyfast  " Spped up drawing
set swapfile
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
set undodir=~/.vim/undo//
set shortmess+=A " Ignores swapfiles when opening file
set autoread     " Automatically read in the file when changed externally
set hidden
set lazyredraw

" -- Autocompletion --
set completeopt=longest,preview " menuone seems to be causing bug error with multiple-cursors
set wildmenu                    " List and cycle through autocomplete suggestions on Tab
set wildcharm=<Tab> " Allows remapping of <Down> in wildmenu

" -- Searching --
set ignorecase " Case insensitive searching
set smartcase  " Except for when searching in CAPS
set incsearch  " Search while typing
set nohlsearch " Don't highligt search results

" -- Yankstack --
call yankstack#setup() " Has to be called before remap of any yankstack_yank_keys

" -- Key mappings --
let mapleader = "\<Space>"

map      <C-Tab>          :bnext<CR>
map      <C-S-Tab>        :bprevious<CR>
nmap     <C-CR>           <leader>c<space>
vmap     <C-CR>           <leader>c<space>
imap     <C-k>            <c-o>O
nnoremap Y                y$
map      <leader>y        "+y
map      <leader>Y        "+Y
map      <leader>d        "+d
map      <leader>D        "+D
map      <leader>p        "+p
map      <leader>P        "+P
map!     <C-v>            <C-r>+
map      <C-q>            :qa<CR>
nnoremap <S-Tab>          <<
vnoremap <S-Tab>          <gv
inoremap <S-Tab>          <C-o><<
autocmd  BufEnter,BufRead *      nnoremap <Tab> ==
autocmd  BufEnter,BufRead *      vnoremap <Tab> =gv
autocmd  BufEnter,BufRead *.py   nmap <Tab> >>
autocmd  BufEnter,BufRead *.py   vmap <Tab> >gv
nnoremap <M-o>            <C-i>
map      <S-CR>           <C-w>W
map      -                3<C-W><
map      +                3<C-W>>
nmap     <M-+>            <C-W>+
nmap     <M-->            <C-W>-
nmap     <C-j>            o<Esc>
nmap     <C-k>            O<Esc>
nmap     <C-s>            :w<CR>
" The `:set buftype=` fixes a bug with tcp
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
nmap     ö                ciw
nmap     Ö                ciW
nmap     ä                viw
nmap     Ä                viW
nmap     å                ci(
nmap     Å                ci"
nmap     <C-c>            <Nop>
" vim-surround----------------------------------
vmap     s                <Plug>VSurround
vmap     S                <Plug>VgSurround
nmap     s                ys
nmap     S                ys$
" ----------------------------------------------
vmap     <                <gv
vmap     >                >gv
map      <Leader>;        m0A;<Esc>`0
map      <Leader>,        m0A,<Esc>`0
map      <Leader>.        m0A.<Esc>`0
map      <Leader>v        :source ~/.vimrc<CR>
map      <Leader>V        :edit ~/.vimrc<CR>
map      <Leader>N        :edit ~/.config/nvim/init.vim<CR>
map      <Leader>Z        :edit ~/.zshrc<CR>
map      <leader>U        :cd ~/Dropbox/Uppsala/<CR>
nmap     gF               :e <C-r>+<CR>
nmap     <leader>F        :let @+ = expand("%")<CR>:echo "Yanked file path: <C-r>+"<CR>
vnoremap .                :normal .<CR>
vnoremap //               y?<C-R>"<CR>
map      <leader>/        :execute '/\V' . escape(input('/'), '\\/')<CR><C-r>+<CR>
map      g/               /\<\><Left><Left>
map      <leader>S        :setlocal spell!<CR>:echo "Toggled spell checking"<CR>
nmap     <leader>r       :%substitute/<C-R><C-W>//gci<Left><Left><Left><Left>
nmap     <leader>R       :%substitute/<C-R><C-W>//I<Left><Left>
vmap     <leader>r       y:<C-U>%substitute/<C-R>0//gci<Left><Left><Left><Left>
vmap     <leader>R       y:<C-U>%substitute/<C-R>0//I<Left><Left>
map      <leader>gd      <C-w>v<C-w>lgdzt<C-w><C-p>
map      Q                @@
map      <S-space>        qq
map      <leader>T       :set tabstop=4 shiftwidth=4 noexpandtab<CR>:retab!<CR>m0gg=G`0m
map      <leader>t       :set tabstop=2 shiftwidth=2 expandtab<CR>:retab!<CR>m0gg=G`0m

" -- Quickfix window remap --
map <CR> <C-w><C-w>
" autocmd BufEnter,BufRead * noremap  <CR> <C-w><C-w>
" autocmd BufEnter,BufRead quickfix map o <CR>
" autocmd BufLeave quickfix :echo "*"
" autocmd BufWinEnter * :echo "*"
autocmd WinEnter quickfix :echo "quickfix"

" -- Lines and cursor --
set number
set relativenumber
hi  CursorLineNr term=bold ctermfg=Yellow gui=bold guifg=Yellow
set cursorline                   " Cursor highlighting
set scrolloff=8                  " Cursor margin
set textwidth=0                  " Disable auto line breaking
set nrformats+=hex,bin,alpha     " Allow Ctrl-A/X for hex, binary and letters
set guicursor=n:blinkwait0       " Disables cursor blinking in normal mode
set guicursor=i:ver25-blinkwait0 " And in insert mode

" -- Themes --
colorscheme onedark " Atom color scheme
let g:onedark_termcolors = 256
set encoding=utf8

" -- Airline --
set laststatus=2 " Always display status line
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
let g:airline_powerline_fonts = 1
let g:airline_theme           = 'onedark'
let g:Powerline_symbols       = 'unicode'
let g:airline_section_x       = '%{&filetype}' " Don't shorten file type on small window

" -- NERDTree --
let NERDTreeIgnore = ['\.pyc$', 'radiosw$', '__init__.py']
" The `§` mapping works great together with ~/.vim/bundle/nerdtree/plugin/custom_map.vim
nmap <silent> §                :NERDTreeFocus<CR>
map           <leader><C-w>    :NERDTreeClose<CR>:lclose<CR>:bdelete<CR>
map           <leader><C-M-w>  :NERDTreeClose<CR>:lclose<CR>:bdelete!<CR>
nnoremap      <C-w><C-c>       :NERDTreeClose<CR><C-w><C-c>

" Disable toolbar, scrollbar and menubar
set guioptions-=T
set guioptions-=r
set guioptions-=m
set guioptions-=L

" Start in maximized window
if has("gui_running")
  set lines=999 columns=999
endif

" -- Emmet --
let g:user_emmet_install_global = 1
let g:user_emmet_mode           = 'a' " enable all function in all mode.
let g:user_emmet_leader_key = '<c-ö>'

" -- Gitgutter --
set updatetime=100

" -- AutoPairs disable <M-p> --
let g:AutoPairsShortcutToggle     = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsShortcutFastWrap   = ''

" -- Vim tab bar colorscheme --
hi default link BufTabLineCurrent Pmenu
hi default link BufTabLineActive  TabLineSel
hi default link BufTabLineHidden  TabLine
hi default link BufTabLineFill    TabLineFill
let g:buftabline_show=1

" -- Supertab and Snipmate --
let g:SuperTabCrMapping             = 1
let g:SuperTabMappingForward        = '<C-n>'
let g:SuperTabMappingBackward       = '<C-b>'
let g:SuperTabDefaultCompletionType = 'context'
smap <Tab> <Plug>snipMateNextOrTrigger
imap <Tab> <Plug>snipMateNextOrTrigger

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
    \ 'dir': '\v[\/](\.(git|dotfiles|vim/bundle|npm|config|chromium)|node_modules)$',
    \ 'file': '\v(\.(exe|sw.|dll|pyc)|__init__.py)$',
    \ }
endif

" -- vim-devicons --
let g:webdevicons_enable                      = 1
let g:webdevicons_enable_ctrlp                = 1
let g:webdevicons_enable_nerdtree             = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding    = ''
let g:WebDevIconsNerdTreeBeforeGlyphPadding   = ''
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsUnicodeDecorateFolderNodes   = 0 " Disabled because of bug with spacing after icon
let g:DevIconsEnableNERDTreeRedraw            = 1

" -- Tab characters --
filetype plugin indent on                              " show existing tab with 4 spaces width
set list lcs=tab:\|\                                   " Show line for each tab indentation
autocmd BufEnter,BufRead * set sw=2                    " Use indent of 2 spaces
autocmd BufEnter,BufRead *.js,*.css,*py  setlocal sw=4 " But 4 spaces in certain files
set tabstop=4                                          " An indentation every fourth column
set autoindent                                         " Follow previous line's indenting
set expandtab                                          " Tabs are spaces
set backspace=indent,eol,start                         " Better backspace
set cinkeys-=0#                                        " Indent lines starting with `#`

" -- IndentLine --
autocmd BufEnter,BufRead * let g:indentLine_enabled      = 1
autocmd BufEnter,BufRead *.json let g:indentLine_enabled = 0
let g:indentLine_color_gui                               = '#4b5263'
let g:indentLine_char                                    = '|'

" Underlines AutoHighligted word:
" highlight Search guibg=NONE guifg=NONE gui=underline
let g:HiCursorWords_delay = 1 " Delay after highlighting current word, low dealy may cause lag

" For toggling caps lock in insert mode
imap <C-C> <Plug>CapsLockToggle

" -- Vim-easy-align --
" Start in visual mode (e.g. vipga):
xmap ga <Plug>(EasyAlign)
" Start for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" -- Vim-easymoion --
" <Leader>f{char} to move to {char}:
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}:
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" Move to line:
map  <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word:
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

let g:strip_whitespace_on_save = 1

" -- NERDCommenter --
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters
let g:NERDTrimTrailingWhitespace = 1 " Trim trailing whitespace when uncommenting
let g:NERDCustomDelimiters = {
\ 'html': { 'left': '<!-- ', 'right': '-->', 'leftAlt': '//'}
\ }
map <leader>C <plug>NERDCommenterToEOL

" -- ALE --
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'python': ['autopep8']
\}
let g:ale_linters = {
\   'python': ['flake8']
\}
let g:ale_python_autopep8_options = '--aggressive'

" -- Vim-lsc --
let g:lsc_server_commands = { 'javascript': 'javascript-typescript-stdio' }
let g:lsc_auto_map        = { 'GoToDefinition': '<Leader>g' }

" -- Vim-javascript --
hi clear jsStorageClass " Change color of 'var'
hi link jsStorageClass Keyword

" -- For editing multiple files with `*` --
com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"

" -- Targets.vim --
let g:targets_nl = 'nN' " Uses `N` instead of `l` for moving targeting backwards

" -- Vim Fugitive --
cnoreabbrev Gdiff Gvdiff

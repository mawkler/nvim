" -- plugins --
call plug#begin('~/.vim/bundle')
if has('nvim')
  Plug 'wsdjeg/notifications.vim'
  Plug 'coreyja/fzf.devicon.vim'
  Plug 'Xuyuanp/scrollbar.nvim'
endif
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'                  " Makes actions like `:Gpush` asynchronous
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'bling/vim-airline'
Plug 'enricobacis/vim-airline-clock'
Plug 'powerline/fonts'
Plug 'joshdick/onedark.vim'                " Atom dark theme for vim
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'unblevable/quick-scope'
Plug 'Valloric/MatchTagAlways'             " Highlight matching HTML tags
Plug 'tmhedberg/matchit'                   " Ads `%` command for HTML tags
Plug 'andymass/vim-matchup'                " Ads additional `%` commands
Plug 'jiangmiao/auto-pairs'                " Add matching brackets, quotes, etc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'dense-analysis/ale'                " Use either ALE or Syntastic
Plug 'honza/vim-snippets'
Plug 'rbonvall/snipmate-snippets-bib'
Plug 'terryma/vim-multiple-cursors'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'airblade/vim-gitgutter'              " Shows git status for each line
Plug 'cakebaker/scss-syntax.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'magicalbanana/vim-sql-syntax'
Plug 'vim-scripts/capslock.vim'            " Adds caps lock mapping to insert mode
Plug 'vim-scripts/StripWhiteSpaces'
Plug 'vim-scripts/restore_view.vim'        " Automatically restores cursor position and folds
Plug 'vim-scripts/git-time-lapse'          " Step through a file's git history
Plug 'inkarkat/vim-ingo-library'           " Required by visualrepeat and ConflictMotions
Plug 'inkarkat/vim-visualrepeat'           " Allows repeating using `.` over visual selection
Plug 'inkarkat/vim-CountJump'              " Dependency for ConflictMotions
Plug 'inkarkat/vim-ConflictMotions'        " Adds motions for Git conflicts
Plug 'MarcWeber/vim-addon-commandline-completion'
Plug 'milkypostman/vim-togglelist'         " Adds mapping to toggle QuickFix window
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-niceblock'                  " Improves visual mode
Plug 'kana/vim-textobj-syntax'
Plug 'haya14busa/vim-textobj-function-syntax'
Plug 'AndrewRadev/dsf.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim'                  " Adds arguments, etc. as text objects
Plug 'PeterRincker/vim-argumentative'      " Adds mappings for swapping arguments
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'romainl/vim-cool'                    " Highlights all search matches until moving cursor
Plug 'haya14busa/incsearch.vim'            " Better incsearch
Plug 'dkarter/bullets.vim'                 " Autocomplete markdown lists, etc.
Plug 'plasticboy/vim-markdown'             " Adds extra features to markdown
Plug 'coachshea/vim-textobj-markdown'
Plug 'mjbrownie/swapit'                    " For toggling words like `true` to `false`, etc.
Plug 'tommcdo/vim-exchange'                " For swapping the place of two text objects
Plug 'Julian/vim-textobj-variable-segment' " Adds camel case and snake case text objects
Plug 'wsdjeg/vim-fetch'                    " Process line and column jump specification in file path
Plug 'psliwka/vim-smoothie'                " Smooth scrolling animations
Plug 'markonm/traces.vim'                  " Better highlighting when searching/replacing
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'ryanoasis/vim-devicons'              " vim-devicond should be loaded last
Plug 'meain/vim-printer'
Plug 'lervag/vimtex'
Plug 'rhysd/git-messenger.vim'
" Plug 'camspiers/animate.vim'             " Causes bug with window sizes when opening :help
Plug 'camspiers/lens.vim'                  " An automatic window resizing plugin
Plug 'itchyny/vim-highlighturl'            " Highlights URLs everywhere
Plug 'AndrewRadev/bufferize.vim'           " Execute a :command and show the output in a temporary buffer
Plug 'benshuailyu/online-thesaurus-vim'    " Retrieves the synonyms and antonyms of a given word
Plug 'mbbill/undotree'
Plug 'semanser/vim-outdated-plugins'       " Gives notification on startup with number of outdated plugins
" Plug 'liuchengxu/vista.vim'
" Plug 'puremourning/vimspector', { 'do': './install_gadget.py --all' } " Multi language graphical debugger
Plug 'j5shi/CommandlineComplete.vim'
Plug 'lfilho/cosco.vim'                    " For appending commas and semicolons to the current line
Plug 'xolox/vim-misc'                      " Required by vim-session
Plug 'xolox/vim-session'                   " Extened session management
Plug 'mhinz/vim-startify'                  " Nicer start screen
Plug 'breuckelen/vim-resize'               " For resizing with arrow keys
Plug 'kyazdani42/nvim-web-devicons'        " Required by barbar.nvim
Plug 'romgrk/barbar.nvim'                  " Sexiest buffer tabline
call plug#end()

" -- File imports --
if !empty(glob('~/.vim/visual-at.vim'))
  source ~/.vim/visual-at.vim
endif

if !empty(glob('~/.vim/markdown-section-object.vim'))
  source ~/.vim/markdown-section-object.vim
endif

if !empty(glob('~/.vimrc-private'))
  source ~/.vimrc-private
endif

" -- General --
syntax on
set vb t_vb=      " Disable error bells
set ttyfast       " Speed up drawing
set shortmess+=A  " Ignores swapfiles when opening file
set shortmess+=c  " Disable completion menu messages like 'match 1 of 2'
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
set fileformat=unix fileformats=unix,dos " Use Unix eol format
set autoread        " Automatically read in the file when changed externally
augroup filechanged " Check if any file has changed
  autocmd!
  autocmd FocusGained * silent! checktime
augroup end

" -- Menu autocompletion --
set completeopt=longest,preview " menuone seems to be causing bug error with multiple-cursors
set wildmenu                    " List and cycle through autocomplete suggestions on Tab
set wildcharm=<Tab>             " Allows remapping of <Down> in wildmenu
set wildignorecase              " Case insensitive file- and directory name completion
set path+=**                    " Let's `find` search recursively into subfolders
set cedit=<C-k>                 " Enter Command-line Mode from command-mode (typcailly menu or search)

" -- Searching --
set ignorecase " Case insensitive searching
set smartcase  " Except for when searching in CAPS
set incsearch  " Search while typing
set hlsearch   " Highligt all search matches

" -- Custom filetypes --
autocmd BufNewFile,BufRead *.dconf set syntax=sh

" -- Yankstack --
call yankstack#setup() " Has to be called before remap of any yankstack_yank_keys

" -- Key mappings --
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
map <S-space> <space>

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
nmap     g<C-j>           i<CR><Esc>
nmap     <C-k>            O<Esc>
nmap     g<C-k>           DO<Esc>P_
nmap     gK               kjddkPJ<C-y>
nmap     <C-s>            :w<CR>
imap     <C-s>            <Esc>:w<CR>
vmap     <C-s>            <Esc>:w<CR>gv
smap     <C-s>            <Esc>:w<CR>
vmap     v                $h
nnoremap c_               c^
nnoremap d_               d^
nmap     <BS>             X
nmap     <S-BS>           x
nmap     <M-BS>           db
map!     <M-BS>           <C-w>
nmap     <M-S-BS>         dw
imap     <M-S-BS>         <C-o>dw
map      <M-d>            dw
imap     <C-j>            <CR>
imap     <C-.>            <C-r>.
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
omap     <M-j>            V}
omap     <M-k>            V{
map      <C-Space>        zt
map      <leader>¨        <C-]>
map      <C-¨>            <C-]>
map      <C-w><C-]>       <C-w>v<Plug>(coc-definition)
map      <C-w>¨           <C-w><C-]>
nnoremap <C-w>T           :tab split<CR>
map      ¨                ]
map      å                [
map      ¨¨               ]]
map      åå               [[
map      ^                }
map      Å                {
map      ö                ;
map      gö               g;
map      Ö                :
map      ¤                $
imap     ¤                $
map!     ¤                $
map      g¤               g$
map      ´                =
imap     ´                =
map      Ä                @
map      ÄÄ               @@
map      ÄÖ               @:
nmap     <C-c>            <Nop>
nmap     <Leader><Esc>    <Nop>
map      <leader>v        :source ~/.config/nvim/init.vim<CR>
map      <leader>V        :edit ~/.vimrc<CR>
map      <leader>N        :edit ~/.config/nvim/init.vim<CR>
map      <leader>G        :edit ~/.config/nvim/ginit.vim<CR>
map      <leader>Z        :edit ~/.zshrc<CR>
map      <leader>I        :edit ~/.dotfiles/install-dotfiles.sh<CR>
map      <leader>~        :cd ~<CR>
map      gX               :exec 'silent !google-chrome-stable % &'<CR>
nmap     gF               :e <C-r>+<CR>
xnoremap //               y/<C-R>"<CR>
noremap  /                ms/
noremap  *                ms*
map      '/               `s
map      <leader>/        :execute '/\V' . escape(input('/'), '\\/')<CR><C-r>+<CR>
map      g/               /\<\><Left><Left>
nmap     <leader>r        :%substitute/<C-R><C-W>//gci<Left><Left><Left><Left>
nmap     <leader>R        :%substitute/<C-R><C-W>//I<Left><Left>
vmap     <leader>r        y:<C-U>%substitute/<C-R>0//gci<Left><Left><Left><Left>
vmap     <leader>R        y:<C-U>%substitute/<C-R>0//I<Left><Left>
map      <leader>gd       <C-w>v<C-w>lgdzt<C-w><C-p>
map      Q                @@
map      <leader>q        qqqqq
nnoremap §                <C-^>
nmap     cg*              *Ncgn
nmap     dg*              *Ndgn
xnoremap g.               .
nmap     dage             viw<Esc>bhdaw
nmap     dagE             viw<Esc>bhdaW
nmap     cage             viw<Esc>bhcaw
nmap     cagE             viw<Esc>bhcaW
nmap     <leader>K        :vertical Man <C-R><C-W><CR>
vmap     <leader>K        y:vertical Man <C-R>"<CR>

map  <silent> <leader>; :call VisualAppend(";")<CR>
map  <silent> <leader>, :call VisualAppend(",")<CR>
map  <silent> <leader>. :call VisualAppend(".")<CR>
map  <silent> <leader>? :call VisualAppend("?")<CR>
map  <silent> <leader>M :FilesWithDevicons $DROPBOX/Dokument/Markdowns/<CR>
map  <silent> <leader>E :cd $DROPBOX/Exjobb/<CR>
nmap <silent> <leader>F :let @+ = expand("%:p")<CR>:call Print("Yanked file path <C-r>+")<CR>
map  <silent> <leader>S :setlocal spell!<CR>
map           g)        w)ge
omap <silent> g)        :silent normal vg)h<CR>
map           g(        (ge
omap <silent> g(        :silent normal vg(oh<CR>
nmap <silent> <C-W>N    :tabe<CR>

nmap <expr> <leader>z &spell ? "1z=" : ":setlocal spell<CR>1z=:setlocal nospell<CR>"
nmap <expr> ]s &spell ? "]s" : ":setlocal spell<CR>]s"
nmap <expr> [s &spell ? "[s" : ":setlocal spell<CR>[s"
map  <expr> <CR> &modifiable && !bufexists('[Command Line]') ? "<Plug>NERDCommenterToggle" : ":call Enter()<CR>"

" `;`/`,` always seach forward/backward, respectively
nnoremap <expr> ; getcharsearch().forward ? ';' : ','
nnoremap <expr> , getcharsearch().forward ? ',' : ';'

" Does `cd path` and prints the command using notifications.vim
function! CD(path)
  exe 'tcd' a:path
  call Print('cd ' . fnamemodify(getcwd(), ":~"))
endf

function! Print(message)
  try
    exe 'Echo' a:message
  catch " if notifications.vim is not installed
    echo a:message
  endtry
endf

function PrintError(message)
  try
    exe 'Echoerr' a:message
  catch " if notifications.vim is not installed
    echohl ErrorMsg
    echom a:message
    echohl None
  endtry
endf

" Prints the new directory after working path changes
augroup dir_changed
  " Ignoring 'nofile' and 'terminal' deals with fzf doing cd twice on trigger
  " for some reasone
  let blacklist = ['nofile', 'terminal']
  autocmd!
  autocmd DirChanged *
        \ if &runtimepath =~ 'notifications.vim' && index(blacklist, &buftype) < 0 |
        \   exe 'Echo  ⟶' fnamemodify(getcwd(), ":~") |
        \ endif
augroup end

function Enter()
  if bufname() == 'Table of contents (vimtex)'
    call b:toc.activate_current(1)
  elseif bufname() == 'undotree_2'
    exe "normal \<Plug>UndotreeEnter"
  elseif bufname() == '[coc-explorer]-1'
    exe "normal \<Plug>(coc-explorer-action-n-[cr])"
  elseif &filetype == 'startify'
    call startify#open_buffers()
  elseif !&modifiable || bufexists('[Command Line]')
    try
      exe "normal! \<CR>"
    catch
      call PrintError(v:exception)
    endtry
  else
    exe "normal o"
  endif
endf
nmap <silent> <C-j> :call Enter()<CR>

augroup vertical_help " Open :help in 80 character wide vertical instead of horizontal split
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | vertical resize 82 | endif
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
  cmap <M-p> <Up><C-p>
endif

if exists('$TMUX')
  set notermguicolors " Tmux screws up the colors if `set termguicolors` is used
endif

" -- Language specific settings --
nnoremap <expr> <Tab> index(['python', 'markdown'], &filetype) >= 0 ?
      \ ">>" : "=="
vnoremap <expr> <Tab> index(['python', 'markdown'], &filetype) >= 0 ?
      \ ">gv" : "=gv"

" -- Lines and cursor --
set number relativenumber
set cursorline                    " Cursor highlighting
set scrolloff=8                   " Cursor margin
set textwidth=0                   " Disable auto line breaking
set nrformats+=hex,bin            " Allow Ctrl-A/X for hex and binary
set guicursor+=n:blinkwait0       " Disables cursor blinking in normal mode
set guicursor+=i:ver25-blinkwait0 " And in insert mode
set mouse=a                       " Enable mouse
set conceallevel=2                " Hide concealed characters completely
set concealcursor=nic             " Conceal characters on the cursor line

" -- Tab characters --
filetype plugin indent on
set expandtab                              " Use spaces for indentation
set shiftwidth=2                           " Width of indentation
set tabstop=4                              " Width of <Tab> characters
set list listchars=tab:\▏\                 " Show line for each tab indentation
set autoindent                             " Follow previous line's indenting
set backspace=indent,eol,start             " Better backspace behaviour
set cinkeys-=0#                            " Indent lines starting with `#`

" Disable toolbar, scrollbar and menubar
set guioptions-=T
set guioptions-=r
set guioptions-=m
set guioptions-=L

" Command to change directory to the current file's
command! CDHere cd %:p:h

" Format JSON file to readable form
command! JSONFormat %!python -m json.tool

" Puts current file in trashcan using trash-cli
command! -bar -bang Trash
      \ let s:file = fnamemodify(bufname(<q-args>),':p') |
      \ execute 'BufferDelete<bang>' |
      \ execute 'silent !trash ' . s:file |
      \ unlet s:file

" -- vim-plug --
augroup vim_plug
  autocmd!
  autocmd FileType vim nmap <buffer> <F5> :source ~/.vimrc \| :PlugInstall<CR>
augroup end

" -- Surround --
vmap   s  <Plug>VSurround
vmap   S  <Plug>VgSurround
sunmap s
sunmap S
nmap   s  ys
nmap   S  ys$
omap   ir i]
omap   ar a]
vmap   ir i]
vmap   ar a]
omap   s¤ s$

" surround noun `¤` means `$`
nmap cs¤ cs$
nmap ds¤ ds$
omap i¤  i$
omap a¤  a$
vmap i¤  i$
vmap a¤  a$
let g:surround_{char2nr('¤')} = "$\r$"

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
vmap iQ  i"
vmap aQ  a"
let g:surround_{char2nr('Q')} = "\"\r\""

" surround noun `A` means `
nmap csA cs`
nmap dsA ds`
omap iA  i`
omap aA  a`
vmap iA  i`
vmap aA  a`
let g:surround_{char2nr('A')} = "`\r`"

" -- Quickscope (highlight settings have to come before setting `colorscheme`) --
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary   cterm=bold ctermfg=204 gui=bold guifg=#E06C75
  autocmd ColorScheme * highlight QuickScopeSecondary cterm=bold ctermfg=173 gui=bold guifg=#D19A66
augroup END

augroup language_specific
  autocmd!
  " Don't conceal current line in some file formatr (LaTeX files' configs don't seem to be overwritten though)
  autocmd FileType markdown,latex,tex,json setlocal concealcursor=""
  " Custom filetype indent settings
  autocmd FileType css,python,cs setlocal shiftwidth=4 tabstop=4
  " For adding a horizontal line below and entering insert mode below it
  autocmd FileType markdown nnoremap <buffer> <leader>- o<Esc>0Do<Esc>0C---<CR><CR>
augroup end

" -- netrw --
let g:netrw_silent = 1
" let g:netrw_preview = 1
let g:netrw_browse_split = 0
" let g:netrw_altv = 1
augroup netrw
  autocmd!
  autocmd FileType netrw nmap <buffer> o <CR>
augroup end

" -- Themes --
colorscheme onedark   " Atom color scheme
" colorscheme doom-one
let g:onedark_termcolors = 256
set encoding=utf-8
set fillchars+=vert:▏ " Adds nicer lines for vertical splits

" -- IndentLine and indent_blankline --
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#4b5263'
let g:indentLine_setConceal = 0 " Don't overwrite concealcursor and conceallevel
let g:indentLine_fileTypeExclude = ['json', 'coc-explorer', 'markdown', 'startify']
let g:indentLine_bufTypeExclude = ['fzf', 'help']
let g:indent_blankline_buftype_exclude = ['help']

" For toggling caps lock in insert mode
imap <C-C> <Plug>CapsLockToggle

" -- Vim-easy-align --
" Start in visual mode (e.g. vipga):
xmap ga <Plug>(EasyAlign)
" Start for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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
" Disable <leader>h-mappings
map <F14> <Plug>(GitGutterPreviewHunk)
map <F15> <Plug>(GitGutterStageHunk)
map <F16> <Plug>(GitGutterUndoHunk)

" -- AutoPairs --
let g:AutoPairsShortcutToggle     = '' " Disables some mappings
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsShortcutFastWrap   = ''
let g:AutoPairsShortcutJump       = ''
let g:AutoPairsMoveCharacter      = ''
let g:AutoPairsMapSpace           = 0
autocmd FileType markdown let b:AutoPairs = g:AutoPairs | let b:AutoPairs["*"] = "*"
autocmd FileType tex      let b:AutoPairs = g:AutoPairs | let b:AutoPairs["$"] = "$"
" TODO: Perhaps use snippets instead to allow `$$` and `**`

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
nmap <silent> gd    <Plug>(coc-definition)
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
  \ 'coc-texlab',
  \ 'coc-omnisharp',
  \ 'coc-tabnine',
  \ 'coc-sh',
  \ 'coc-terminal',
  \ 'coc-vimlsp',
  \]
  " \ 'coc-vimtex', " Clashes with coc-texlab
  " \ 'coc-ccls',
  " \ 'coc-sql'
  " \ 'coc-docker',

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim', 'help', 'markdown'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
    " TODO: catch and display errors
  else
    call CocAction('doHover')
  endif
endfunction

" coc-explorer
" noremap <silent> ½ :execute 'CocCommand explorer --file-columns=selection,icon,clip,indent,filename,size ' . expand('%:p:h')<CR>
noremap <silent> ½ :execute 'CocCommand explorer'<CR>

" coc-snippets
vmap gs <Plug>(coc-snippets-select)
command! Snippets CocList snippets

" -- Commentary --
nmap cm <Plug>Commentary

" -- swapit --
fun SwapLists()
  ClearSwapList
  SwapList BOOLEANS TRUE FALSE
  SwapList numbers zero one two three four five six seven eight nine ten eleven twelve
  SwapList Numbers Zero One Two Three Four Five Six Seven Eight Nine Ten Eleven Twelve
  SwapList nummer noll en ett två tre fyra fem sex sju åtta nio tio elva tolv
  SwapList Nummer Noll En Ett Två Tre Fyra Fem Sex Sju Åtta Nio Tio Elva Tolv
  SwapList a a an
  SwapList andor and or
  SwapList andorsymbols && ||
  SwapList is is are
  SwapList do do does
  SwapList isnt isn aren
  SwapList dont don doesn
endfun
augroup SwapList
  autocmd!
  autocmd BufEnter * call SwapLists()
augroup end


" -- textobj-function --
let g:textobj_function_no_default_key_mappings = 1
xmap aF <Plug>(textobj-function-A)
omap aF <Plug>(textobj-function-A)
xmap iF <Plug>(textobj-function-i)
omap iF <Plug>(textobj-function-i)

" --- vim-textobj-line ---
let g:textobj_line_no_default_key_mappings = 1
xmap aL <Plug>(textobj-line-a)
omap aL <Plug>(textobj-line-a)
xmap iL <Plug>(textobj-line-i)
omap iL <Plug>(textobj-line-i)

" -- Cool.vim --
if has('nvim') || has('gui_running')
  " Causes regular Vim to launch in replace mode for some reason
  nnoremap <silent> <expr> <Esc>
        \ v:hlsearch \|\| &modifiable && !bufexists('[Command Line]')
        \ ? ":nohlsearch<CR>"
        \ : "<C-w>c"
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

" -- Fzf --
function FZF_files()
  echohl Comment
  echo 'Directory: ' . fnamemodify(getcwd(), ':~')
  echohl None
  exe 'FilesWithDevicons'
endf

if has('nvim')
  " Use floating window
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8, 'highlight': 'SpecialKey', 'border': 'rounded' } }
  map <silent> <C-p> :call FZF_files()<CR>
else
  map <silent> <C-p> :Files<CR>
endif
map <silent> <leader>m :History<CR>
map <silent> <leader>h :Helptags<CR>
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
let $FZF_DEFAULT_COMMAND='ag --hidden -g "" -p $HOME/.agignore-vim'
let $FZF_DEFAULT_OPTS='--bind ctrl-j:accept,alt-k:up,alt-j:down --multi --prompt ">>> " --history=' . $HOME . '/.fzf_history'

" Disable statusbar, numbers and IndentLines in FZF
autocmd! FileType fzf              set laststatus=0 ruler! nonumber norelativenumber
      \| autocmd BufLeave <buffer> set laststatus=2 ruler! number   relativenumber

let g:fzf_mru_case_sensitive = 0
let g:fzf_colors = {
      \ "fg":      ["fg", "Normal"],
      \ "fg+":     ["fg", "SpecialKey", "CursorColumn", "Normal"],
      \ "bg":      ["bg", "Normal"],
      \ "bg+":     ["bg", "CursorLine", "CursorColumn"],
      \ "hl":      ["fg", "ErrorMsg"],
      \ "hl+":     ["fg", "ErrorMsg"],
      \ "gutter":  ["bg", "Normal"],
      \ "pointer": ["fg", "SpecialKey"],
      \ "marker":  ["fg", "Title"],
      \ "border":  ["fg", "VisualNC"],
      \ "header":  ["fg", "WildMenu"],
      \ "info":    ["fg", "ErrorMsg"],
      \ "spinner": ["fg", "SpecialKey"],
      \ "prompt":  ["fg", "Question"]
      \ }

" -- vim-clap --
let g:clap_insert_mode_only = 1
hi default link ClapDisplay CursorColumn

" -- vim-printer --
let g:vim_printer_print_below_keybinding = 'gp'
let g:vim_printer_print_above_keybinding = 'gP'

" -- LaTeX and Vimtex --
augroup latex
  autocmd!
  autocmd FileType latex,tex setlocal iskeyword-=:                               " `:` counts as a separator
  autocmd FileType latex,tex let b:surround_{char2nr('c')} = "\\\1command\1{\r}" " Add vim-surround noun `c`
  autocmd FileType latex,tex nmap <buffer> <silent> <leader>t <Plug>(vimtex-toc-open)
augroup END
let g:tex_flavor = 'latex'
let g:tex_indent_items=0        " Disables indent before new `\item`
let g:vimtex_indent_enabled = 0 " Disables indent before new `\item` by vimtex
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
      \]
" Disables default mappings that start with `t`
let g:vimtex_mappings_disable = {
      \ 'x': ['tsf', 'tsc', 'tse', 'tsd', 'tsD'],
      \ 'n': ['tsf', 'tsc', 'tse', 'tsd', 'tsD'],
      \}
let g:vimtex_toc_config = {
      \ 'todo_sorted': 1,
      \ 'split_width': 30,
      \ 'name': 'Table of contents (vimtex)',
      \ 'hotkeys_leader': '',
      \ 'show_numbers': 1,
      \ 'hotkeys_enabled': 1,
      \ 'hotkeys': 'acdeilmnopuvwx',
      \ 'show_help': 0,
      \ 'layer_status': { 'label': 0, 'todo': 0},
      \ }

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
let g:toggle_list_no_mappings=1
nmap <script> <silent> <leader>L :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>Q :call ToggleQuickfixList()<CR>

" -- lens.vim --
let g:lens#disabled_filetypes = ['coc-explorer', 'fzf', 'fugitiveblame']

" -- markdown --
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
" Disables default `ge` mapping by overriding the default
map <F13> <Plug>Markdown_EditUrlUnderCursor
" Make italic words actually look italic in Markdown
hi htmlItalic cterm=italic gui=italic
" Underline link names in Markdown in-line links
hi mkdLink cterm=underline gui=underline
" Underline Markdown URLs
hi mkdInlineURL guifg=#61AFEF gui=underline

augroup toc_markdown
  autocmd!
  autocmd FileType markdown nmap <buffer> <leader>t :Toc<CR>
  autocmd FileType markdown setlocal keywordprg=:help commentstring=<!--%s-->
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
  autocmd FileType undotree nmap <silent> <buffer> <Tab> <Plug>UndotreeFocusTarget
  autocmd FileType undotree nmap <silent> <buffer> <leader>u <Plug>UndotreeClose
  autocmd FileType undotree nmap <silent> <buffer> <Esc> <Plug>UndotreeClose
augroup end

" -- bullets --
map <silent> <leader>X :ToggleCheckbox<CR>
let g:bullets_nested_checkboxes = 0 " Don't toggle parent and child boxes automatically
let g:bullets_checkbox_markers  = ' x'

" -- CommandlineComplete --
cmap <M-k> <Plug>CmdlineCompleteBackward
cmap <M-j> <Plug>CmdlineCompleteForward

" -- Online Thesaurus --
let g:use_default_key_map = 0
nnoremap <silent> <leader>T :call thesaurusPy2Vim#Thesaurus_LookCurrentWord()<CR>

" Looks up the provided word(s) in a thesaurus
command! -nargs=+ -bar Thesaurus call thesaurusPy2Vim#Thesaurus_LookWord('<args>')

" -- Cosco --
map <silent> <leader>a <Plug>(cosco-commaOrSemiColon)

" -- Startify --
" Add devicsons in front of file names
function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_enable_special = 0 " Dont' show <empty buffer> or <quit>
let g:startify_custom_indices = 'asdfghlcvnmcyturieowpqxz' " Use letters instead of numbers
let g:startify_files_number = 8
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

" -- vim-session --
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:session_lock_enabled = 0
nmap <leader><C-q> :SaveSession \| qa<CR>

" -- vim-resize --
let g:vim_resize_disable_auto_mappings = 1
let g:resize_count = 3
nnoremap <silent> <Left>  :CmdResizeLeft<CR>
nnoremap <silent> <Right> :CmdResizeRight<CR>
nnoremap <silent> <Up>    :CmdResizeUp<CR>
nnoremap <silent> <Down>  :CmdResizeDown<CR>

" -- scrollbar --
if has('nvim')
  let g:scrollbar_right_offset = 0
  let g:scrollbar_highlight = {
        \ 'head': 'NonText',
        \ 'body': 'NonText',
        \ 'tail': 'NonText',
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
endif

" -- vim-smoothie --
let g:smoothie_base_speed = 18

" -- barbar.nvim --
if (!exists('g:bufferline'))
  " Prevents overriding the config on reload of .vimrc
  let g:bufferline = { 'closable': v:false }
endif
hi TabLineFill guifg=Normal guibg=#21242b
hi BufferVisible guifg=#888888

map <leader><C-w>   :BufferDelete<CR>
map <leader><C-M-w> :BufferDelete!<CR>

" Magic buffer-picking mode
nnoremap <silent> <Leader>b :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Leader>Bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Leader>Bl :BufferOrderByLanguage<CR>
" Move to previous/next
nnoremap <silent> <C-Tab>   :BufferNext<CR>
nnoremap <silent> <C-S-Tab> :BufferPrevious<CR>
" Re-order to previous/next
nnoremap <silent> >b :BufferMoveNext<CR>
nnoremap <silent> <b :BufferMovePrevious<CR>
" Goto buffer in position...
nnoremap <silent> <A-1> :BufferGoto 1<CR>
nnoremap <silent> <A-2> :BufferGoto 2<CR>
nnoremap <silent> <A-3> :BufferGoto 3<CR>
nnoremap <silent> <A-4> :BufferGoto 4<CR>
nnoremap <silent> <A-5> :BufferGoto 5<CR>
nnoremap <silent> <A-6> :BufferGoto 6<CR>
nnoremap <silent> <A-7> :BufferGoto 7<CR>
nnoremap <silent> <A-8> :BufferGoto 8<CR>
nnoremap <silent> <A-9> :BufferLast<CR>
nnoremap <silent> <Leader>1 :BufferGoto 1<CR>
nnoremap <silent> <Leader>2 :BufferGoto 2<CR>
nnoremap <silent> <Leader>3 :BufferGoto 3<CR>
nnoremap <silent> <Leader>4 :BufferGoto 4<CR>
nnoremap <silent> <Leader>5 :BufferGoto 5<CR>
nnoremap <silent> <Leader>6 :BufferGoto 6<CR>
nnoremap <silent> <Leader>7 :BufferGoto 7<CR>
nnoremap <silent> <Leader>8 :BufferGoto 8<CR>
nnoremap <silent> <Leader>9 :BufferLast<CR>

if !exists("g:gui_oni") " ----------------------- Oni excluded stuff below -----------------------

" -- Airline --
set laststatus=2 " Always display status line
let g:airline_powerline_fonts = 1
let g:airline_theme           = 'onedark'
let g:Powerline_symbols       = 'unicode'
let g:airline_section_x       = '%{&filetype}' " Don't shorten file type on small window

let g:airline#extensions#clock#updatetime = 200 " Has to be greater than updatetime for scrollbar.nvim to work

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tex'] = ''

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

" " -- NERDTree --
" augroup nerdtree
"   if !empty(glob('~/.vim/nerdtree_custom_map.vim'))
"     autocmd!
"     autocmd VimEnter * source ~/.vim/nerdtree_custom_map.vim
"   endif
" augroup end

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

" -- Vim-javascript --
hi clear jsStorageClass " Change color of 'var'
hi link jsStorageClass Keyword

" ColorScheme corrections
hi! link Search Visual
hi! link SpecialKey Directory

endif

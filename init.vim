" -- plugins --
call plug#begin('~/.vim/bundle')

if !$NVIM_MINIMAL
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-dispatch'                  " Makes actions like `:Gpush` asynchronous
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-abolish'
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'vim-scripts/restore_view.vim'        " Automatically restores cursor position and folds
  Plug 'vim-scripts/git-time-lapse'          " Step through a file's git history
  Plug 'inkarkat/vim-visualrepeat'           " Allows repeating using `.` over visual selection
  Plug 'milkypostman/vim-togglelist'         " Adds mapping to toggle QuickFix window
  Plug 'kana/vim-niceblock'                  " Improves visual mode
  Plug 'kana/vim-textobj-syntax'
  Plug 'haya14busa/vim-textobj-function-syntax'
  Plug 'PeterRincker/vim-argumentative'      " Adds mappings for swapping arguments
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'dkarter/bullets.vim'                 " Autocomplete markdown lists, etc.
  Plug 'mjbrownie/swapit'                    " For toggling words like `true` to `false`, etc.
  Plug 'Julian/vim-textobj-variable-segment' " Adds camel case and snake case text objects
  Plug 'wsdjeg/vim-fetch'                    " Process line and column jump specification in file path
  Plug 'meain/vim-printer'
  Plug 'rhysd/git-messenger.vim'
  Plug 'camspiers/lens.vim'                  " An automatic window resizing plugin
  Plug 'Ron89/thesaurus_query.vim'           " Retrieves the synonyms and antonyms of a given word
  Plug 'mbbill/undotree'
  Plug 'Melkster/vim-outdated-plugins'       " Gives notification on startup with number of outdated plugins
  Plug 'Melkster/CommandlineComplete.vim'
  Plug 'breuckelen/vim-resize'               " For resizing with arrow keys
  Plug 'junegunn/vim-peekaboo'               " Opens preview when selecting register
  Plug 'RishabhRD/popfix'                    " Required by nvim-cheat.sh
  Plug 'RishabhRD/nvim-cheat.sh'             " cheat.sh integration for neovim
  Plug 'RRethy/vim-hexokinase', { 'do': 'make' } " Displays the colours (rgb, etc.) in files
  Plug 'mhinz/vim-startify'                  " Nicer start screen
  Plug 'DanilaMihailov/beacon.nvim'
endif
if has('nvim')
  Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
  Plug 'wsdjeg/notifications.vim'
  Plug 'coreyja/fzf.devicon.vim'
  Plug 'Xuyuanp/scrollbar.nvim'
  Plug 'kyazdani42/nvim-web-devicons' " Required by barbar.nvim
  Plug 'romgrk/barbar.nvim'           " Sexiest buffer tabline
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'powerline/fonts'
Plug 'RRethy/nvim-base16'           " Collection of base16 colorschemes in Lua
Plug 'scrooloose/nerdcommenter'
Plug 'unblevable/quick-scope'
Plug 'andymass/vim-matchup'         " Ads additional `%` commands
Plug 'windwp/nvim-autopairs'        " Automatically add closing brackets, quotes, etc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'rbonvall/snipmate-snippets-bib'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'            " Shows git status for each line
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'magicalbanana/vim-sql-syntax'
Plug 'vim-scripts/capslock.vim'     " Adds caps lock mapping to insert mode
Plug 'vim-scripts/StripWhiteSpaces'
Plug 'inkarkat/vim-ingo-library'    " Required by visualrepeat and ConflictMotions
Plug 'inkarkat/vim-CountJump'       " Dependency for ConflictMotions
Plug 'inkarkat/vim-ConflictMotions' " Adds motions for Git conflicts
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'lervag/vimtex'
Plug 'AndrewRadev/dsf.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim'           " Adds arguments, etc. as text objects
Plug 'romainl/vim-cool'             " Highlights all search matches until moving cursor
Plug 'plasticboy/vim-markdown'      " Adds extra features to markdown
Plug 'coachshea/vim-textobj-markdown'
Plug 'tommcdo/vim-exchange'         " For swapping the place of two text objects
Plug 'markonm/traces.vim'           " Better highlighting when searching/replacing
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'ryanoasis/vim-devicons'       " vim-devicond should be loaded last
Plug 'itchyny/vim-highlighturl'     " Highlights URLs everywhere
Plug 'AndrewRadev/bufferize.vim'    " Execute a :command and show the output in a temporary buffer
Plug 'xolox/vim-misc'               " Required by vim-session
Plug 'xolox/vim-session'            " Extened session management
Plug 'idbrii/vim-jumpmethod'        " Better ]m/[m for C#, C++ and Java
Plug 'rhysd/vim-grammarous'         " Grammar checking using LanguageTool
Plug 'karb94/neoscroll.nvim'        " Smooth scrolling animations
Plug 'glepnir/galaxyline.nvim'
call plug#end()

" -- General --
syntax on
set shortmess+=A  " Ignores swapfiles when opening file
set shortmess+=c  " Disable completion menu messages like 'match 1 of 2'
set shortmess+=s  " Disable 'Search hit BOTTOM, continuing at TOP' messages
set termguicolors " Use GUI colors in terminal as well
set noshowmode    " Don't write out `--INSERT--`, etc.
set linebreak     " Don't break lines in the middle of a word
set hidden
set lazyredraw
set undofile
set viewoptions=cursor,folds,slash,unix
set fileformat=unix   " Use Unix eol format
set spelllang=en,sv   " Use both Engligh and Swedish spell check
set splitright        " Open vertical window splits to the right instead of left
set nojoinspaces      " Only add one space after a `.`/`?`/`!` when joining lines
set fillchars+=vert:▏ " Adds nicer lines for vertical splits
set encoding=utf-8

augroup filechanged
  autocmd!
  autocmd FocusGained * silent! checktime " Check if any file has changed when Vim is focused
augroup end

" -- Menu autocompletion --
set completeopt=menu,preview,noinsert
set wildcharm=<Tab> " Allows remapping of <Down> in wildmenu
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
map!     <M-p>            <C-r>"
smap     <M-p>            <C-g>p
map      <M-a>            v<C-a>
map      <M-x>            v<C-x>
" Cursor movement in cmd and insert mode--------
map!     <C-f>            <Right>
map!     <M-f>            <C-Right>
map!     <C-b>            <Left>
map!     <M-b>            <C-Left>
map!     <M-h>            <Left>
map!     <M-l>            <Right>
map!     <M-w>            <C-Right>
cmap     <C-a>            <Home>
imap     <M-o>            <C-o>o
imap     <M-O>            <C-o>O
"----------------------------------------------
map      <M-j>            }
map      <M-k>            {
omap     <M-j>            V}
omap     <M-k>            V{
map      <C-Space>        zt
nnoremap <C-w>T           :tab split<CR>
nnoremap <C-w>C           :tabclose<CR>
map      ¨                ]
map      å                [
map      ¨¨               ]]
map      åå               [[
map      Å                {
map      ö                ;
map      gö               g;
map      Ö                :
map      ¤                $
imap     ¤                $
map!     ¤                $
map      g¤               g$
map      ´                =
imap     §                `
map      §                `
map!     ½                ~
map      ½                ~
map      Ä                @
map      ÄÄ               @@
map      ÄÖ               @:
nmap     <C-c>            <Nop>
nmap     <Leader><Esc>    <Nop>
map      <leader>v        :source ~/.config/nvim/init.vim<CR>
map      <leader>V        :drop ~/.vimrc<CR>
map      <leader>Ii       :drop ~/.config/nvim/init.vim<CR>
map      <leader>Ig       :drop ~/.config/nvim/ginit.vim<CR>
map      <leader>Z        :drop ~/.zshrc<CR>
map      <leader>~        :cd ~<CR>
map      gX               :exec 'silent !brave %:p &'<CR>
nmap     gF               :e <C-r>+<CR>
xnoremap //               omsy/<C-R>"<CR>`s
noremap  /                ms/
noremap  *                ms*
noremap  g*               msg*`s
noremap  <leader>*        ms*`s
noremap  <leader>g*       msg*`s
noremap  #                ms#
noremap  g#               msg#`s
map      `/               `s
map      <leader>/        :execute '/\V' . escape(input('/'), '\\/')<CR><C-r>+<CR>
map      g/               /\<\><Left><Left>
nmap     <leader>r        :%substitute/<C-R><C-W>//gci<Left><Left><Left><Left>
nmap     <leader>R        :%substitute/<C-R><C-W>//I<Left><Left>
vmap     <leader>r        y:<C-U>%substitute/<C-R>0//gci<Left><Left><Left><Left>
vmap     <leader>R        y:<C-U>%substitute/<C-R>0//I<Left><Left>
map      Q                @@
map      <leader>q        qqqqq
nnoremap §                <C-^>
nnoremap cg*              *Ncgn
nnoremap dg*              *Ndgn
vnoremap gcn              //Ncgn
vnoremap gdn              //Ndgn
xnoremap g.               .

nmap     <leader>K        :vertical Man <C-R><C-W><CR>
vmap     <leader>K        y:vertical Man <C-R>"<CR>

map  <silent> <leader>M :FilesWithDevicons $DROPBOX/Dokument/Markdowns/<CR>
map  <silent> <leader>E :cd $DROPBOX/Exjobb/<CR>
nmap <silent> <leader>F :let @+ = expand("%:p")<CR>:call Print("Yanked file path <C-r>+")<CR>
map  <silent> <leader>S :setlocal spell!<CR>
map           g)        w)ge
omap <silent> g)        :silent normal vg)h<CR>
map           g(        (ge
omap <silent> g(        :silent normal vg(oh<CR>
nmap <silent> <C-W>N    :tabe<CR>

nmap <silent> <expr> <leader>z &spell ? "1z=" : ":setlocal spell<CR>1z=:setlocal nospell<CR>"
nmap <silent> <expr> ]s &spell ? "]s" : ":setlocal spell<CR>]s"
nmap <silent> <expr> [s &spell ? "[s" : ":setlocal spell<CR>[s"

nmap <silent> ]l :lbelow<CR>
nmap <silent> [l :labove<CR>
nmap <silent> ]q :cbelow<CR>
nmap <silent> [q :cabove<CR>

" -- Git commands --
map <silent> <leader>Gm <Plug>(git-messenger)
map <silent> <leader>Gb :Git blame<CR>
map <silent> <leader>Gd :tab Gvdiffsplit
      \\| BufferMovePrevious<CR>:windo set wrap \| wincmd w<CR>
map <silent> <leader>Gs :vertical Git<CR>
map <silent> <leader>Gp :Git pull<CR>
map          <leader>GP :Git push
map          <leader>Gc :vertical Git commit -va

" `;`/`,` always seach forward/backward, respectively
noremap <expr> ; getcharsearch().forward ? ';' : ','
noremap <expr> , getcharsearch().forward ? ',' : ';'

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

function s:print_error(message)
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
        \   exe 'Echo  ' fnamemodify(getcwd(), ":~") |
        \ endif
augroup end

augroup vertical_help
  " Open :help in vertical split instead of horizontal
  autocmd!
  autocmd FileType help
        \ setlocal bufhidden=unload |
        \ wincmd L |
        \ vertical resize 79
augroup END

" Prints the syntax highlighting values under cursor
function! SynStack()
  if exists("*synstack")
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endif
endf
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
endf
noremap gf :call MarkdownGf()<CR>

" Increases the font zise with `amount`
function! Zoom(amount) abort
  call ZoomSet(matchlist(g:GuiFont, ':h\(\d\+\)')[1] + a:amount)
endf

" Sets the font size
function ZoomSet(font_size) abort
  execute 'GuiFont! ' .  substitute(&guifont, ':h\d\+', ':h' . a:font_size, '')
endf

noremap <silent> <C-=> :call Zoom(v:count1)<CR>
noremap <silent> <C-+> :call Zoom(v:count1)<CR>
noremap <silent> <C--> :call Zoom(-v:count1)<CR>
noremap <silent> <C-0> :call ZoomSet(12)<CR>

if has('nvim')
  " Because NeoVim's menu completions are in a vertical pum
  cnoremap <expr> <C-k> pumvisible() ? "\<C-p>"       : "\<C-k>"
  cnoremap <expr> <C-j> pumvisible() ? "\<C-n>"       : "\<Down>"
  cnoremap <expr> <Tab> pumvisible() ? "\<C-y>"       : "\<Tab>"
  cnoremap <expr> <C-f> pumvisible() ? "\<C-e>"       : "\<Right>"
  cnoremap <expr> <C-p> pumvisible() ? "\<Up><C-p>"   : "\<Up>"
  cnoremap <expr> <C-n> pumvisible() ? "\<C-e><Down>" : "\<Down>"
  set cpoptions-=_ " Makes cw/cW include the whitespace after the word
  set shada=!,'1000,<50,s10,h
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
set guicursor+=n:blinkwait0       " Disables cursor blinking in normal mode
set guicursor+=i:ver25-blinkwait0 " And in insert mode
set mouse=a                       " Enable mouse
set conceallevel=2                " Hide concealed characters completely
set concealcursor=nic             " Conceal characters on the cursor line
set breakindent                   " Respect indent when line wrapping

" -- Tab characters --
set expandtab                              " Use spaces for indentation
set shiftwidth=2                           " Width of indentation
set tabstop=4                              " Width of <Tab> characters
set list listchars=tab:▏\ ,nbsp:·          " Show line for tab indentation, and a dot for non-breaking spaces
set shiftround                             " Round indent to multiple of shiftwdith
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
command! -bar -bang -complete=file Trash
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
xmap   s  <Plug>VSurround
xmap   S  <Plug>VgSurround
nmap   s  ys
nmap   S  ys$
omap   ir i]
omap   ar a]
xmap   ir i]
xmap   ar a]
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
hi QuickScopePrimary   cterm=bold ctermfg=204 gui=bold guifg=#E06C75
hi QuickScopeSecondary cterm=bold ctermfg=173 gui=bold guifg=#D19A66

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
augroup end

" -- netrw --
let g:netrw_silent = 1
let g:netrw_preview = 1
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_bufsettings = 'noma nomod nonu nowrap ro bl'
augroup netrw
  autocmd!
  autocmd FileType netrw nmap <buffer> o <CR>
augroup end

" -- Colorscheme modifications --
lua require('base16-colorscheme').setup('onedark')
hi link Search     Visual
hi link SpecialKey Directory
hi link DiffChange Boolean

hi VertSplit  guifg=#181A1F
hi MatchParen guifg=NONE guibg=NONE gui=underline

" -- IndentLine and indent_blankline --
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#4b5263'
let g:indentLine_setConceal = 0 " Don't overwrite concealcursor and conceallevel
let g:indentLine_fileTypeExclude = ['json', 'coc-explorer', 'markdown', 'startify']
let g:indentLine_bufTypeExclude = ['fzf', 'help']
let g:indent_blankline_buftype_exclude = ['help']
let g:indent_blankline_show_first_indent_level = v:false

" For toggling caps lock in insert mode
imap <S-Esc> <Plug>CapsLockToggle

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
map <silent> <expr> <CR>
      \ &modifiable && !bufexists('[Command Line]') ?
      \ "<Plug>NERDCommenterToggle" : "<CR>"

" -- Signify --
set updatetime=100
let g:signify_sign_show_count        = 0
let g:signify_sign_add               = '┃'
let g:signify_sign_delete            = '▁'
let g:signify_sign_delete_first_line = '▔'
let g:signify_sign_change            = '┃'

" -- For editing multiple files with `*` --
com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"

" " -- Targets.vim --
" let g:targets_nl   = 'nN'   " Uses `N` instead of `l` for moving targeting backwards
let g:targets_aiAI = 'aIAi' " Swaps meaning of `I` and `i`
augroup targets
  autocmd!
  " Resets ib/ab to Vim's default behaviour
  autocmd User targets#mappings#user call targets#mappings#extend({
        \ 'b': {'pair': [{'o':'(', 'c':')'}]}
        \ })
augroup end

" -- Vim Sleuth --
let g:sleuth_automatic = 1

" -- Coc.nvim --
nmap <silent> <C-]>   <Plug>(coc-definition)
nmap <silent> gd      <Plug>(coc-definition)
map  <silent> <C-w>gd <C-w>v<Plug>(coc-definition)

nmap <silent> <leader>rn <Plug>(coc-rename)

" Use `<Tab>` to confirm completion, expand snippet, jump to next snippet
" position, and trigger completion
inoremap <silent> <expr> <Tab>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ?
      \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endf

augroup coc_nvim_custom
  autocmd!
  " Disable coc.nvim in command-line-window
  autocmd CmdwinEnter * let b:coc_suggest_disable = 1
  autocmd CmdwinEnter * inoremap <expr> <buffer> <Tab> pumvisible() ?
        \ "\<C-y>" : "\<C-x><C-v>"
augroup END

" Use <C-k>/<C-j> to move up/down in PUM selection
imap <silent> <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-o>O"
imap <silent> <expr> <C-j> pumvisible() ? "\<C-n>" : ""

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

let g:coc_snippet_next = '<Tab>'   " Use Tab to jump to next place in snippet
let g:coc_snippet_prev = '<S-Tab>' " Use Shift-Tab to jump to previous place in snippet

let g:coc_global_extensions = [
  \ 'coc-syntax',
  \ 'coc-tag',
  \ 'coc-snippets',
  \ 'coc-jedi',
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
  \ 'coc-lua',
  \ ]
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
endf

" coc-explorer
noremap <silent> <Leader>§ :execute 'CocCommand explorer'<CR>
noremap <silent> <Leader>` :execute 'CocCommand explorer'<CR>

" coc-snippets
vmap gs <Plug>(coc-snippets-select)
command! Snippets CocList snippets

" -- Commentary --
nmap cm  <Plug>Commentary
nmap cmm <Plug>CommentaryLine

if !$NVIM_MINIMAL
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

  " Git-timelapse
  nmap <leader>gt :call TimeLapse() <cr>
endif

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
  let g:fzf_layout = {
        \ 'window': {
        \   'width': 0.9,
        \   'height': 0.8,
        \   'highlight': 'SpecialKey',
        \   'border': 'rounded'
        \ }}
  map <silent> <C-p> :call FZF_files()<CR>
else
  map <silent> <C-p> :Files<CR>
endif
map <silent> <leader>m :History<CR>
map <silent> <leader>h :Helptags<CR>
map          <leader>a :Ag<Space>
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
let $FZF_DEFAULT_COMMAND = 'ag --hidden -g "" -p $HOME/.agignore-vim'
let $FZF_DEFAULT_OPTS = '
      \ --multi
      \ --prompt ">>> "
      \ --pointer="▶"
      \ --info=inline
      \ --history=' . $HOME . '/.fzf_history
      \ --history-size=10000
      \ '

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
  autocmd ColorScheme * call s:TexHighlight()
augroup END

function! s:TexHighlight() abort
  " Special highlight for \texttt{}
  highlight link texCTextttArg String
endf
call s:TexHighlight()

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
nmap <script> <silent> <leader>Q :call ToggleQuickfixList()<CR>
augroup quickfix
  autocmd!
  " autocmd FileType qf nunmap <buffer> <space>
  autocmd FileType qf nmap <buffer> <Space> <CR><C-w>p
augroup END
" nmap <buffer> <Space> <CR><C-w>p

" -- lens.vim --
let g:lens#disabled_filetypes = ['coc-explorer', 'fzf', 'fugitiveblame']

" -- Markdown --
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
" Disables vim-markdown's default `ge` mapping
map <F13> <Plug>Markdown_EditUrlUnderCursor
" Disables vim-markdown's default `]c` mapping
map <F14> <Plug>Markdown_MoveToCurHeader
" Make italic words actually look italic in Markdown
hi htmlItalic cterm=italic gui=italic
" Underline Markdown URLs
hi mkdInlineURL guifg=#61AFEF gui=underline cterm=underline
" Underline link names in Markdown in-line links
hi link mkdLink mkdInlineURL

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
  autocmd FileType undotree nmap <silent> <buffer> <Tab> <Plug>UndotreeFocusTarget
  autocmd FileType undotree nmap <silent> <buffer> <leader>u <Plug>UndotreeClose
  autocmd FileType undotree nmap <silent> <buffer> <Esc> <Plug>UndotreeClose
augroup end

" -- bullets --
map <silent> <leader>X :ToggleCheckbox<CR>
let g:bullets_nested_checkboxes = 0 " Don't toggle parent and child boxes automatically
let g:bullets_checkbox_markers  = ' x'

" -- CommandlineComplete --
cmap <M-i> <Plug>CmdlineCompleteBackward
cmap <M-I> <Plug>CmdlineCompleteForward

" -- Thesaurus --
let g:tq_map_keys = 0
nnoremap <silent> <leader>T :ThesaurusQueryLookupCurrentWord<CR>

" Looks up the provided word(s) in a thesaurus
command! -nargs=+ -bar Thesaurus call thesaurusPy2Vim#Thesaurus_LookWord('<args>')

" -- restore_view --
let g:skipview_files = ['COMMIT_EDITMSG']

" -- Startify --
" Add devicsons in front of file names
function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endf
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_enable_special = 0 " Dont' show <empty buffer> or <quit>
let g:startify_custom_indices = 'asdfghlvnmyturieowpqxz' " Use letters instead of numbers
let g:startify_files_number = 8
let g:startify_change_to_dir = 0 " Don't `cd` to selected file's directory
let g:startify_session_sort = 1  " Sort sessions based on mru rather than name
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
let g:session_autosave = 'yes'
let g:session_autoload = 'no'
let g:session_lock_enabled = 0

" -- vim-resize --
let g:vim_resize_disable_auto_mappings = 1
let g:resize_count = 3
nnoremap <silent> <Left>  :CmdResizeLeft<CR>
nnoremap <silent> <Right> :CmdResizeRight<CR>
nnoremap <silent> <Up>    :CmdResizeUp<CR>
nnoremap <silent> <Down>  :CmdResizeDown<CR>

" -- barbar.nvim --
" Gets the highlight value of highlight group `name`
" Set `layer` to either 'fg' or 'bg'
function GetHiVal(name, layer)
  return synIDattr(synIDtrans(hlID(a:name)), a:layer . '#')
endf

" Creates highlight group `name` with guifg `guifg`, and guibg s:barbar_bg
" If a third argument is provided gui is set to that
function BarbarHi(name, guifg, ...)
  let gui = a:0 > 0 ? 'gui=' . get(a:, 1, '') : ''
  exe 'hi!' a:name 'guifg=' a:guifg 'guibg=' s:barbar_bg gui
endf

let g:bufferline = get(g:, 'bufferline', {
      \ 'closable': v:false, 'no_name_title': '[No Name]'
      \ })
let s:barbar_bg  = '#21242b'

let fg_visible  = GetHiVal('Normal', 'fg')     " #abb2bf
let fg_sign     = GetHiVal('NonText', 'fg')    " #3b4048
let fg_modified = GetHiVal('WarningMsg', 'fg') " #e5c07b
let fg_tabpages = GetHiVal('Directory', 'fg')  " #61AFEF

call BarbarHi('BufferTabpageFill', fg_sign)
call BarbarHi('BufferTabpages', fg_tabpages, 'bold')
call BarbarHi('BufferVisible', fg_visible)
call BarbarHi('BufferVisibleSign', fg_sign)
call BarbarHi('BufferVisibleMod', fg_modified)
call BarbarHi('BufferVisibleIndex', fg_sign)
call BarbarHi('BufferInactive', '#707070')
call BarbarHi('BufferInactiveSign', fg_sign)
call BarbarHi('BufferInactiveMod', fg_modified)
call BarbarHi('BufferInactiveIndex', fg_sign)
call BarbarHi('BufferInactiveTarget', 'red', 'bold')
call BarbarHi('BufferModifiedIndex', fg_sign)

map <M-w>         :BufferDelete<CR>
map <leader><M-w> :BufferDelete!<CR>

" Magic buffer-picking mode
nnoremap <silent> <C-Space> :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Leader>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Leader>bl :BufferOrderByLanguage<CR>
" Move to previous/next
nnoremap <silent> <C-Tab>         :BufferNext<CR>
nnoremap <silent> <C-S-Tab>       :BufferPrevious<CR>
nnoremap <silent> <Leader><Tab>   :BufferNext<CR>
nnoremap <silent> <Leader><S-Tab> :BufferPrevious<CR>
" Re-order to previous/next
nnoremap <silent> <M-.> :BufferMoveNext<CR>
nnoremap <silent> <M-,> :BufferMovePrevious<CR>
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

" -- Neovim specific
if has('nvim')

" -- scrollbar --
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

" -- Lua stuff --

lua << EOF

-- Statusline --
require('statusline')

-- Nvim-web-devicons --
require('nvim-web-devicons').setup {
  override = {
    md = {
      icon = '',
      color = '#519aba',
      name = "Markdown"
    },
    tex = {
      icon = '',
      color = '#3D6117',
      name = 'Tex'
    }
  },
  default = true
}

-- Treesitter --
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = {"latex"},
  },
}

-- Neoscroll --
require('neoscroll').setup()

-- Autopairs --
local rule = require('nvim-autopairs.rule')
local n_pairs = require('nvim-autopairs')

n_pairs.setup()

n_pairs.add_rules({
  rule("$","$","tex"),
  rule("*","*","markdown"),
})
EOF

endif

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

nmap <silent> <leader>gc :GrammarousCheck<CR>
nmap <leader>gg <Plug>(grammarous-move-to-info-window)
nmap <leader>gd <Plug>(grammarous-open-info-window)<Plug>(grammarous-move-to-info-window)
nmap <leader>gQ <Plug>(grammarous-reset)
nmap <leader>gf <Plug>(grammarous-fixit)
nmap <leader>gF <Plug>(grammarous-fixall)
nmap <leader>gq <Plug>(grammarous-close-info-window)
nmap <leader>gr <Plug>(grammarous-remove-error)
nmap <leader>gD <Plug>(grammarous-disable-rule)

exe 'hi SpellBad        gui=undercurl guisp=' . GetHiVal('SpellRare', 'fg') . ' guifg=NONE'
exe 'hi GrammarousError gui=undercurl guisp=' . GetHiVal('Error', 'fg')

" -- Peekaboo --
let g:peekaboo_delay = 300

if !exists("g:gui_oni") " ----------------------- Oni excluded stuff below -----------------------

" Matchup
let g:matchup_matchparen_offscreen = {} " Disables displaying off-screen matching pair

endif

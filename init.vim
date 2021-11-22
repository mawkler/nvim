" -- Plugins --
call plug#begin('~/.config/nvim/packages/')

if !$NVIM_MINIMAL
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-dispatch'                  " Makes actions like `:Gpush` asynchronous
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-abolish'
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
  Plug 'Julian/vim-textobj-variable-segment' " Adds camel case and snake case text objects
  Plug 'wsdjeg/vim-fetch'                    " Process line and column jump specification in file path
  Plug 'meain/vim-printer'
  Plug 'rhysd/git-messenger.vim'
  Plug 'camspiers/lens.vim'                  " An automatic window resizing plugin
  Plug 'Ron89/thesaurus_query.vim'           " Retrieves the synonyms and antonyms of a given word
  Plug 'mbbill/undotree'
  Plug 'Melkster/vim-outdated-plugins'       " Gives notification on startup with number of outdated plugins
  Plug 'breuckelen/vim-resize'               " For resizing with arrow keys
  Plug 'junegunn/vim-peekaboo'               " Opens preview when selecting register
  Plug 'RishabhRD/popfix'                    " Required by nvim-cheat.sh
  Plug 'RishabhRD/nvim-cheat.sh'             " cheat.sh integration for neovim
  Plug 'RRethy/vim-hexokinase', { 'do': 'make' } " Displays the colours (rgb, etc.) in files
  Plug 'mhinz/vim-startify'                  " Nicer start screen
  Plug 'DanilaMihailov/beacon.nvim'          " Flash the cursor location on jump
endif
if has('nvim')
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'wsdjeg/notifications.vim'
  Plug 'coreyja/fzf.devicon.vim'
  Plug 'Xuyuanp/scrollbar.nvim'
  Plug 'kyazdani42/nvim-web-devicons'  " Required by barbar.nvim
  Plug 'kyazdani42/nvim-tree.lua'      " File explorer
  Plug 'romgrk/barbar.nvim'            " Sexiest buffer tabline
  Plug 'mhartington/formatter.nvim'    " Auto formatting
  Plug 'karb94/neoscroll.nvim'         " Smooth scrolling animations
  Plug 'famiu/feline.nvim'             " Statusline creation framework
  Plug 'SmiteshP/nvim-gps'             " For displaying the current scope in statusline
  Plug 'windwp/floatline.nvim'         " One global statusline
  Plug 'lewis6991/gitsigns.nvim'       " Shows git status for each line
  " Neovim LSP
  Plug 'neovim/nvim-lspconfig'         " Enables built-in LSP
  Plug 'kabouzeid/nvim-lspinstall'     " Adds LspInstall command
  Plug 'glepnir/lspsaga.nvim'          " Various LSP functionality
  Plug 'hrsh7th/nvim-compe'            " Auto completion
  Plug 'onsails/lspkind-nvim'          " VSCode-like completion icons
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'hrsh7th/vim-vsnip'             " Snippet engine
  Plug 'Melkster/friendly-snippets'    " Set of snippets
  Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
  Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-textobjects', { 'branch': '0.5-compat' }
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'nvim-treesitter/playground'
  Plug 'nvim-lua/lsp-status.nvim'
  Plug 'nvim-lua/popup.nvim'           " Required by telescope.nvim
  Plug 'nvim-lua/plenary.nvim'         " Required by telescope.nvim
  Plug 'nvim-telescope/telescope.nvim' " Fuzzy finder
  Plug 'milisims/nvim-luaref'          " Vim :help reference for lua
  Plug 'ethanholz/nvim-lastplace'      " Reopen files at last edit position
  Plug 'monaqa/dial.nvim'              " Enhanced increment/decrement functionality
  Plug 'b3nj5m1n/kommentary'           " For toggling comments
  Plug 'NTBBloodbath/rest.nvim'        " For sending GET/POST/etc. requests
  Plug 'mfussenegger/nvim-dap'         " Debugger client
  Plug 'rcarriga/nvim-dap-ui'          " UI for nvim-dap
  Plug 'Pocco81/DAPInstall.nvim'       " For installing and managing debuggers
  Plug 'jbyuki/one-small-step-for-vimkind' " Lua plugin debug adapter
  Plug 'ful1e5/onedark.nvim'
  Plug 'ThePrimeagen/refactoring.nvim'
  Plug 'Darazaki/indent-o-matic'       " Automatic fast indentation detection
  Plug 'lewis6991/impatient.nvim'      " Improve startup time for Neovim
endif
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'unblevable/quick-scope'
Plug 'andymass/vim-matchup'         " Ads additional `%` commands
Plug 'windwp/nvim-autopairs'        " Automatically add closing brackets, quotes, etc
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'junegunn/fzf.vim'
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
Plug 'itchyny/vim-highlighturl'     " Highlights URLs everywhere
Plug 'AndrewRadev/bufferize.vim'    " Execute a :command and show the output in a temporary buffer
Plug 'xolox/vim-misc'               " Required by vim-session
Plug 'xolox/vim-session'            " Extened session management
Plug 'rhysd/vim-grammarous'         " Grammar checking using LanguageTool
Plug 'gelguy/wilder.nvim'           " Auto-show suggetsions in command-line mode
Plug 'github/copilot.vim'
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
set updatetime=100
if exists('g:goneovim')
  set guifont=FiraCode\ Nerd\ Font:h12
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
nnoremap <S-Tab>          <<
vnoremap <S-Tab>          <gv
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
smap     <C-h>            <BS>
xmap     v                $h
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
nmap     <M-j>            :m .+1<CR>==
nmap     <M-k>            :m .-2<CR>==
xmap     <M-j>            :m '>+1<CR>gv=gv
xmap     <M-k>            :m '<-2<CR>gv=gv
imap     <M-j>            <Esc>:m .+1<CR>==gi
imap     <M-k>            <Esc>:m .-2<CR>==gi
map      <C-Space>        zt
map      <C-w>gd          <C-w>vgd
nnoremap <C-w>T           :tab split<CR>
nnoremap <C-w>C           :tabclose<CR>
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
nnoremap /                ms/
nnoremap *                ms*
nnoremap g*               msg*`s
nnoremap <leader>*        ms*`s
nnoremap <leader>g*       msg*`s
nnoremap #                ms#
nnoremap g#               msg#`s
map      `/               `s
map      <leader>/        :execute '/\V' . escape(input('/'), '\\/')<CR><C-r>+<CR>
map      g/               /\<\><Left><Left>
nnoremap n                nzz
nnoremap N                Nzz
nmap     <leader>R        :%substitute/<C-R><C-W>//gci<Left><Left><Left><Left>
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
nmap <silent> ]Q :cnext<CR>
nmap <silent> [Q :cprev<CR>

" -- Git commands --
map <silent> <leader>gm <Plug>(git-messenger)
map <silent> <leader>gB :Git blame<CR>
map <silent> <leader>gd :call GitDiff()<CR>

function GitDiff() abort
  let tmp = g:bufferline.insert_at_end
  let g:bufferline.insert_at_end = v:false
  tabnew %
  exe 'Gvdiffsplit'
  exe 'BufferMovePrevious'
  windo set wrap
  let g:bufferline.insert_at_end = tmp
endf
map <silent> <leader>gs :vertical Git<CR>
map <silent> <leader>gp :Git pull<CR>
map          <leader>gP :Git push
map          <leader>gc :vertical Git commit -va

" `;`/`,` always seach forward/backward, respectively
noremap <expr> ; getcharsearch().forward ? ';' : ','
noremap <expr> , getcharsearch().forward ? ',' : ';'

" Adds previous cursor location to jumplist if count is > 5
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

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
map <leader>H :TSHighlightCapturesUnderCursor<CR>

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
noremap gf :call MarkdownGf()<CR>

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
noremap <silent> <C-0> :call ZoomSet(12)<CR>

if has('nvim')
  cnoremap <C-p> <Up>
  cnoremap <C-n> <Down>
  cnoremap <C-q> <Esc>
  set cpoptions-=_ " Makes cw/cW include the whitespace after the word
  set shada=!,'1000,<50,s10,h
endif

if exists('$TMUX')
  set notermguicolors " Tmux screws up the colors if `set termguicolors` is used
endif

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
set expandtab                     " Use spaces for indentation
set shiftwidth=2                  " Width of indentation
set tabstop=4                     " Width of <Tab> characters
set list listchars=tab:\ \ ,nbsp:·
set shiftround                    " Round indent to multiple of shiftwdith
set cinkeys-=0#                   " Indent lines starting with `#`

" Disable toolbar, scrollbar and menubar
set guioptions-=T
set guioptions-=r
set guioptions-=m
set guioptions-=L

" Command to change directory to the current file's
command! CDHere cd %:p:h

" Puts current file in trashcan using trash-cli
command! -bar -bang -nargs=? -complete=file Trash
      \ let s:file = fnamemodify(bufname(<q-args>),':p') |
      \ execute 'BufferClose<bang>' |
      \ execute 'silent !trash ' . s:file |
      \ unlet s:file

" Highlight text object on yank
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=350}
augroup END

" -- vim-plug --
augroup vim_plug
  autocmd!
  autocmd FileType vim nmap <buffer> <F5> :source ~/.vimrc \| :PlugInstall<CR>
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

" -- Quickscope --
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" -- Colorscheme modifications --
lua << EOF
require('onedark').setup {
  colors = {
    fg_cursor_linenumber = 'blue',
  }
}
EOF

" Gets the highlight value of highlight group `name`
" Set `layer` to either 'fg' or 'bg'
function GetHiVal(name, layer)
  return synIDattr(synIDtrans(hlID(a:name)), a:layer . '#')
endf

fun! s:colorschemeMods() abort
  hi IncSearch    guibg=#61afef
  hi VertSplit    guifg=#181a1f
  hi MatchParen   guifg=NONE guibg=NONE gui=underline,bold
  " hi CursorLine   guibg=#313742
  " hi CursorLineNr guifg=#61afef guibg=#313742
  " hi NormalFloat  guibg=#3E4452
  " hi FloatBorder  guibg=#3E4452

  hi link TSTagDelimiter TSPunctBracket
  exe 'hi! CursorLineNr guifg=' . GetHiVal('Question', 'fg') .
        \ ' guibg=' . GetHiVal('CursorLine', 'bg') . ' gui=bold'

  hi! link Search     Visual
  " hi! link PmenuSel   IncSearch
  " hi! link Statement  Keyword
  " hi! link TSField    TSVariable
  " hi! link TSInclude  Keyword

  hi! QuickScopePrimary   cterm=bold ctermfg=204 gui=bold guifg=#E06C75
  hi! QuickScopeSecondary cterm=bold ctermfg=173 gui=bold guifg=#D19A66
endf

augroup colorschemeMods
  autocmd!
  autocmd ColorScheme * call s:colorschemeMods()
augroup END
call s:colorschemeMods()

" -- IndentLine and indent_blankline --
let g:indent_blankline_char = '▏'
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_buftype_exclude = ['fzf', 'help']
let g:indent_blankline_filetype_exclude = [
      \   'markdown', 'startify', 'sagahover', 'NvimTree'
      \ ]
" Fixes bug where blank lines get highlighted by cursorline highlighting
" https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
" TODO: remove this once the bug is fixed
set colorcolumn=99999

" For toggling caps lock in insert mode
imap <S-Esc> <Plug>CapsLockToggle
imap <M-c> <Plug>CapsLockToggle

" -- Vim-easy-align --
" Start in visual mode (e.g. vipga):
xmap ga <Plug>(EasyAlign)
" Start for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" -- For editing multiple files with `*` --
com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"

" -- Targets.vim --
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

" -- Command-line window --
nnoremap <silent><expr>
      \ <Esc> v:hlsearch \|\| &modifiable ? ':nohlsearch<CR>' : '<C-w>c'
augroup cmd_win
  autocmd!
  autocmd CmdwinEnter * nnoremap <buffer> <Esc> <C-w>c
  autocmd CmdwinEnter * nnoremap <buffer> <CR>  <CR>
augroup END

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

" " -- Java syntax highlighting --
" let g:java_highlight_functions = 1
" let g:java_highlight_all = 1

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
nmap <script> <silent> <leader>Q :call ToggleQuickfixList()<CR>
augroup quickfix
  autocmd!
  autocmd FileType qf nmap <buffer><nowait> <Space> <CR><C-w>p
  autocmd FileType qf nmap <buffer><nowait> <CR> <CR>
  autocmd FileType qf xmap <buffer><nowait> <CR> <CR>
augroup END

" -- lens.vim --
let g:lens#disabled_filetypes = ['fzf', 'fugitiveblame', 'NvimTree']

" -- Markdown --
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
" Disables vim-markdown's default `ge` mapping
map <F13> <Plug>Markdown_EditUrlUnderCursor
" Disables vim-markdown's default `]c` mapping
map <F14> <Plug>Markdown_MoveToCurHeader
" Make italic words actually look italic in Markdown
" hi htmlItalic cterm=italic gui=italic
" Underline Markdown URLs
" hi mkdInlineURL guifg=#61AFEF gui=underline cterm=underline
" Underline link names in Markdown in-line links
" hi link mkdLink mkdInlineURL

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
"
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
  autocmd FileType undotree nmap <silent> <buffer> <Tab> <Plug>UndotreeFocusTarget
  autocmd FileType undotree nmap <silent> <buffer> <leader>u <Plug>UndotreeClose
  autocmd FileType undotree nmap <silent> <buffer> <Esc> <Plug>UndotreeClose
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
let g:startify_session_dir = '~/.config/nvim/sessions/'
let g:startify_enable_special = 0 " Dont' show <empty buffer> or <quit>
let g:startify_custom_indices = 'asdfghlvnmyturieowpqxz' " Use letters instead of numbers
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
let g:session_default_overwrite = 1
let g:session_autoload = 'no'
let g:session_lock_enabled = 0
let g:session_directory = '~/.config/nvim/sessions/'

map <leader>o :OpenSession <Tab>

" -- vim-resize --
let g:vim_resize_disable_auto_mappings = 1
let g:resize_count = 3
nnoremap <silent> <Left>  :CmdResizeLeft<CR>
nnoremap <silent> <Right> :CmdResizeRight<CR>
nnoremap <silent> <Up>    :CmdResizeUp<CR>
nnoremap <silent> <Down>  :CmdResizeDown<CR>

" -- barbar.nvim --
" Creates highlight group `name` with guifg `guifg`, and guibg s:barbar_bg
" If a third argument is provided gui is set to that
function BarbarHi(name, guifg, ...)
  let gui = a:0 > 0 ? 'gui=' . get(a:, 1, '') : ''
  exe 'hi!' a:name 'guifg=' a:guifg 'guibg=' s:barbar_bg gui
endf

let g:bufferline = get(g:, 'bufferline', {
      \ 'closable': v:false,
      \ 'no_name_title': '[No Name]',
      \ 'insert_at_end': v:true,
      \ 'exclude_name': ['[dap-repl]'],
      \ 'exclude_ft': ['qf'],
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

map <M-w>         :BufferClose<CR>
map <leader><M-w> :BufferClose!<CR>

" Magic buffer-picking mode
nnoremap <silent> <C-Space> :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Leader>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Leader>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <Leader>bc :BufferClose<CR>
nnoremap <silent> <Leader>bC :bufdo BufferClose<CR>
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

" -- Scrollbar --
let g:scrollbar_right_offset = 0
let g:scrollbar_excluded_filetypes = ['NvimTree']
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

" -- VSnip --
let g:vsnip_snippet_dir = '~/.config/nvim/vsnip/'

" -- Import lua config --
lua require('config')

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

nmap <silent> <leader>Gc :GrammarousCheck<CR>
nmap <leader>Gg <Plug>(grammarous-move-to-info-window)
nmap <leader>Gd <Plug>(grammarous-open-info-window)<Plug>(grammarous-move-to-info-window)
nmap <leader>GQ <Plug>(grammarous-reset)
nmap <leader>Gf <Plug>(grammarous-fixit)
nmap <leader>GF <Plug>(grammarous-fixall)
nmap <leader>Gq <Plug>(grammarous-close-info-window)
nmap <leader>Gr <Plug>(grammarous-remove-error)
nmap <leader>GD <Plug>(grammarous-disable-rule)

exe 'hi SpellBad        gui=undercurl guisp=' . GetHiVal('SpellRare', 'fg') . ' guifg=NONE'
exe 'hi GrammarousError gui=undercurl guisp=' . GetHiVal('ErrorMsg', 'fg')

" -- ConflictMotions --
nmap <leader>xb :ConflictTake both<CR>

if !exists('g:vscode')
  " -- Peekaboo --
  let g:peekaboo_delay = 300

  " -- Matchup --
  let g:matchup_matchparen_offscreen = {} " Disables displaying off-screen matching pair

  " -- Wilder --
  call wilder#enable_cmdline_enter()
  set wildcharm=<Tab>

  cnoremap <expr> <C-j> wilder#in_context() ? wilder#next()     : "\<C-n>"
  cnoremap <expr> <C-k> wilder#in_context() ? wilder#previous() : "\<C-p>"
  cnoremap <expr> <Tab> wilder#can_accept_completion() ?
        \ wilder#accept_completion(0) :
        \ wilder#in_context() ?
        \ wilder#next() :
        \ pumvisible() ?
        \ "\<C-y>" :
        \ "\<Tab>"

  call wilder#set_option('noselect', 0)

  call wilder#set_option('modes', ['/', '?', ':'])

  call wilder#set_option('pipeline', [
        \   wilder#branch(wilder#python_file_finder_pipeline({
        \     'file_command': {_, arg ->
        \       stridx(arg, '.') != -1 ? ['fd', '-tf', '-H'] : ['fd', '-tf']
        \     },
        \     'dir_command': ['fd', '-td'],
        \     'cache_timestamp': {-> 1}
        \   }),
        \   wilder#cmdline_pipeline({'fuzzy': 1}),
        \     wilder#python_search_pipeline({
        \       'pattern': wilder#python_fuzzy_pattern({'start_at_boundary': 0})
        \     })
        \   )
        \ ])

  let s:highlighters = [wilder#pcre2_highlighter()]

  call wilder#set_option('renderer', wilder#renderer_mux({
        \   ':': wilder#popupmenu_renderer({
        \     'highlighter': s:highlighters,
        \     'left': [' ', wilder#popupmenu_devicons()],
        \     'right': [' ', wilder#popupmenu_scrollbar()]
        \   }),
        \   '/': wilder#wildmenu_renderer({
        \     'highlighter': s:highlighters
        \   })
        \ }))
endif

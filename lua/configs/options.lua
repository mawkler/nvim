-------------
-- Options --
-------------
local opt = vim.opt

-- General --
opt.showmode  = false      -- Don't write out `--INSERT--`, etc.
opt.linebreak = true       -- Don't break lines in the middle of a word
opt.shortmess:append('A')  -- Ignores swapfiles when opening file
opt.shortmess:append('s')  -- Disable 'Search hit BOTTOM, continuing at TOP'
opt.shortmess:append('FW') -- Disable message after editing/writing file
opt.spelllang = {'en','sv'}
opt.spelloptions:append('camel')

-- Windows --
opt.termguicolors = true  -- Use GUI colors in terminal as well
opt.winblend      = 5     -- Transparent floating windows
opt.pumblend      = 5     -- Transparent popup-menu
opt.splitright    = true  -- Open vertical windows to the right instead of left
opt.splitkeep     = vim.fn.exists('g:neovide') == 1 and 'cursor' or 'screen'
opt.lazyredraw    = true
opt.updatetime    = 500
opt.viewoptions   = { 'cursor', 'folds', 'slash', 'unix' }

-- File options --
opt.undofile   = true
opt.fileformat = 'unix'
opt.encoding   = 'utf-8'
opt.shada      = "!,'1000,<50,s10,h"

-- Command line mode --
opt.wildignorecase = true  -- Case insensitive file/directory completion
opt.path:append('**')      -- Lets `find` search recursively into subfolders
opt.cedit='<C-y>'          -- Enter Command-line Mode from command-mode

-- Searching --
opt.ignorecase = true      -- Case insensitive searching
opt.smartcase  = true      -- Except for when searching in CAPS

-- Lines and cursor --
opt.number         = true
opt.relativenumber = true
opt.cursorline     = true  -- Cursor highlighting
opt.scrolloff      = 10    -- Cursor margin
opt.conceallevel   = 2     -- Hide concealed characters completely
opt.concealcursor  = 'nic' -- Conceal characters on the cursor line
opt.breakindent    = true  -- Respect indent when line wrapping
opt.cpoptions:remove('_')  -- Makes cw/cW include trailing whitespace

-- Indent characters --
opt.expandtab   = true     -- Use spaces for indentation
opt.shiftwidth  = 2        -- Width of indentation
opt.tabstop     = 4        -- Width of <Tab> characters
opt.shiftround  = true     -- Round indent to multiple of shiftwdith
opt.cinkeys:remove('0#')   -- Indent lines starting with `#`
opt.list        = true
opt.listchars   = 'tab:  ,nbsp:·'

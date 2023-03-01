-------------
-- Options --
-------------
local opt, o, exists = vim.opt, vim.o, vim.fn.exists

-- General --
o.showmode  = false        -- Don't write out `--INSERT--`, etc.
o.linebreak = true         -- Don't break lines in the middle of a word
opt.shortmess:append('A')  -- Ignores swapfiles when opening file
opt.shortmess:append('s')  -- Disable 'Search hit BOTTOM, continuing at TOP'
opt.shortmess:append('cS') -- Disable "[1/5]", "Pattern not found", etc.
opt.shortmess:append('FW') -- Disable message after editing/writing file
opt.spelllang = { 'en', 'sv' }
opt.spelloptions:append('camel')
opt.sessionoptions:append('globals') -- Store global variables in sessions

-- Windows --
o.termguicolors   = true  -- Use GUI colors in terminal as well
o.winblend        = 5     -- Transparent floating windows
o.pumblend        = 5     -- Transparent popup-menu
o.splitright      = true  -- Open vertical windows to the right instead of left
if exists('&splitkeep') == 1 then
  opt.splitkeep = exists('g:neovide') == 1 and 'cursor' or 'screen'
end
o.lazyredraw    = true
o.updatetime    = 500
opt.viewoptions = { 'cursor', 'folds', 'slash', 'unix' }

-- File options --
o.undofile   = true
o.fileformat = 'unix'
o.encoding   = 'utf-8'
o.shada      = "!,'2000,<50,s10,h"

-- Command line mode --
o.wildignorecase = true -- Case insensitive file/directory completion
opt.path:append('**')   -- Lets `find` search recursively into subfolders
o.cedit = '<C-y>'       -- Enter Command-line Mode from command-mode
o.cmdheight = 0         -- Don't show command-line by default

-- Searching --
o.ignorecase = true -- Case insensitive searching
o.smartcase  = true -- Except for when searching in CAPS

-- Lines and cursor --
o.number         = true
o.relativenumber = true
o.cursorline     = true   -- Cursor highlighting
o.scrolloff      = 10     -- Cursor margin
o.conceallevel   = 2      -- Hide concealed characters completely
o.concealcursor  = 'nic'  -- Conceal characters on the cursor line
o.breakindent    = true   -- Respect indent when line wrapping
opt.cpoptions:remove('_') -- Makes cw/cW include trailing whitespace

-- Indent characters --
o.expandtab   = true     -- Use spaces for indentation
o.shiftwidth  = 2        -- Width of indentation
o.tabstop     = 4        -- Width of <Tab> characters
o.shiftround  = true     -- Round indent to multiple of shiftwdith
opt.cinkeys:remove('0#') -- Indent lines starting with `#`
o.list        = true
o.listchars   = 'tab:  ,nbsp:·'

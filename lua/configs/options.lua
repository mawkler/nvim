-------------
-- Options --
-------------
local opt, o, g, exists = vim.opt, vim.o, vim.g, vim.fn.exists

-- Font
if exists('g:goneovim') or exists('g:neovide') and not exists('g:font_set') then
  o.guifont = 'FiraCode Nerd Font:w-0.3:h07'
  g.font_set = true -- Prevents changing zoom level when re-sourcing
end

-- General --
o.showmode  = false        -- Don't write out `--INSERT--`, etc.
o.linebreak = true         -- Don't break lines in the middle of a word
opt.shortmess:append('A')  -- Ignores swapfiles when opening file
opt.shortmess:append('s')  -- Disable 'Search hit BOTTOM, continuing at TOP'
opt.shortmess:append('cS') -- Disable "[1/5]", "Pattern not found", etc.
opt.shortmess:append('FW') -- Disable message after editing/writing file
opt.shortmess:append('q')  -- Disable "recording @q" (it's shown in statusline instead)
opt.spelllang = { 'en', 'sv' }
opt.spelloptions:append('camel')
opt.sessionoptions:append('globals') -- Store global variables in sessions

-- Windows --
local opacity = vim.g.neovide and 40 or 18
o.winblend        = opacity -- Transparent floating windows
o.pumblend        = opacity -- Transparent popup-menu
o.splitright      = true    -- Open vertical windows to the right instead of left
if exists('&splitkeep') == 1 then
  opt.splitkeep = exists('g:neovide') == 1 and 'cursor' or 'screen'
end
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
-- Disabled until https://github.com/neovide/neovide/issues/1947 gets fixed
-- o.inccommand = 'split' -- Show preview window when doing :substitute

-- Lines and cursor --
o.number         = true
o.relativenumber = true
o.cursorline     = true   -- Cursor highlighting
o.smoothscroll   = true   -- Scroll screen wrapped lines visual line by line
o.scrolloff      = 10     -- Cursor margin
o.conceallevel   = 2      -- Hide concealed characters completely
o.concealcursor  = 'nic'  -- Conceal characters on the cursor line
o.breakindent    = true   -- Respect indent when line wrapping
opt.cpoptions:remove('_') -- Makes cw/cW include trailing whitespace

-- Indent/ special characters --
o.expandtab   = true     -- Use spaces for indentation
o.shiftwidth  = 2        -- Width of indentation
o.tabstop     = 4        -- Width of <Tab> characters
o.shiftround  = true     -- Round indent to multiple of shiftwdith
opt.cinkeys:remove('0#') -- Indent lines starting with `#`
o.list          = false  -- Disabled by default
vim.o.listchars = 'tab:󱦰 ,space:·,nbsp:,eol:↵'
opt.fillchars   = {
  diff = ' ',  -- Cleaner deleted lines in diff
  eob  = ' ',  -- Don't show `~` at end of buffer
}

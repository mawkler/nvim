--------------
-- Startify --
--------------
return { 'mhinz/vim-startify',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    local autocmd = require('../utils').autocmd
    local g = vim.g

    g.startify_session_dir    = vim.fn.stdpath('data') .. '/sessions/'
    g.startify_enable_special = 0 -- Don't show <empty buffer> or <quit>
    g.startify_custom_indices = 'asdfhlvnmytureowpqxz' -- Use letters instead of numbers
    g.startify_files_number   = 8
    g.startify_change_to_dir  = 0 -- Don't `cd` to selected file's directory
    g.startify_session_sort   = 1  -- Sort sessions based on mru rather than name
    g.startify_skiplist = {'COMMIT_EDITMSG'}
    g.startify_lists = {
      {type = 'sessions',  header = {'   Sessions'}},
      {type = 'files',     header = {'   Recent files'}},
      {type = 'bookmarks', header = {'   Bookmarks'}},
      {type = 'commands',  header = {'   Commands'}},
    }
    g.startify_custom_header = {
      '    _____   __                                      ',
      '   (\\    \\ |  \\                         __          ',
      '   | \\    \\|   :  ____    ____  ___  __[__]  _____  ',
      '   |  \\    \\   | / __ \\  /  _ \\ \\  \\/ /|  | /     \\ ',
      '   |   \\    \\  |(  ___/ (  (_) ) \\   / |  ||  Y Y  \\',
      '   :   |\\    \\ | \\_____) \\____/   \\_/  |__||__|_|__/',
      '    \\__| \\____\\)----------------------------------- ',
    }

    vim.api.nvim_create_augroup('Startify', {})
    autocmd('User Startified', {
      callback = function ()
        -- Disable q mapping
        -- vim.keymap.del('n', 'q', { buffer = true })
      end,
      group = 'Startify'
    })

    -- Use nvim-web-devicons
    function _G.webDevIcons(path)
      local filename = vim.fn.fnamemodify(path, ':t')
      local extension = vim.fn.fnamemodify(path, ':e')
      return require('nvim-web-devicons').get_icon(filename, extension, { default = true })
    end

    function StartifyEntryFormat()
      return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
    end
  end
}

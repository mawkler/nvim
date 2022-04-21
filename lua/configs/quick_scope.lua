-----------------
-- Quick-scope --
-----------------
vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

return { 'unblevable/quick-scope',
  keys = {
    {'i', 'f'},
    {'i', 'F'},
    {'i', 't'},
    {'i', 'T'},
  },
  setup = function()
    vim.cmd [[
      nmap <C-c> <cmd>call Esc()<CR>

      " Doing this mapping in Lua breaks quickscope for some reason
      function! Esc() abort
        if &diff
          exec 'tabclose'
        else
          exec 'DiffviewClose'
        end
      endfunction
    ]]
  end
}

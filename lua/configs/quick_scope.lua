-----------------
-- Quick-scope --
-----------------
vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

return { 'unblevable/quick-scope',
  keys = {'f', 'F', 't', 'T'},
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

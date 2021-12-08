" Select a directory using fzf and cd to it

let default_dirs = [".git", ".local", ".cache"]
let g:fzf_cd_ignore_dirs = get(g:, 'fzf_cd_ignore_dirs', default_dirs)

function s:fzf_cd(dir) abort
  if empty(a:dir)
    let dir = '~'
  else
    if !isdirectory(expand(a:dir))
      call s:print_error('Invalid directory: ' . a:dir)
      return
    endif
    let dir = a:dir
  endif

  let dir = fnamemodify(dir, ':p:~:.')
  let ignores = '-path ' . s:expand_ignores(g:fzf_cd_ignore_dirs)

  if executable('bfs')
    let find = 'bfs '
  else
    let find = 'find '
  endif

  " Add ctrl-T to cd only in this tab
  let command = find . dir . ' -type d -maxdepth 10 -not \( ' . ignores . ' \) 2>/dev/null'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'sink': 'cd'
        \ }))
endf

function s:expand_ignores(dirs) abort
  return join(map(a:dirs, '"\"**" . v:val . "**\""'), " -or -path ")
endf

command! -nargs=* -complete=dir Cd call s:fzf_cd(<q-args>)

" nnoremap <silent> cd :Cd .<CR>
" nnoremap <silent> cD :Cd ~<CR>

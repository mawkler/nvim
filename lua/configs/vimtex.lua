------------
-- Vimtex --
------------
return {
  'lervag/vimtex',
  ft = { 'tex', 'latex' },
  init = function()
    local g = vim.g
    g.tex_indent_items = 0      -- Disable indent before new `\item`
    g.vimtex_indent_enabled = 0 -- Disable indent before new `\item` by VimTex
    g.tex_comment_nospell = 1
    g.vimtex_view_method = 'zathura' -- Sioyek steals window focus on <leader>lv
    g.vimtex_view_general_viewer = 'zathura'
    g.vimtex_view_automatic = 0
    g.vimtex_complete_bib = { simple = 1 }
    g.vimtex_toc_config = {
      layer_status = { label = 0 },
    }

    g.vimtex_quickfix_enabled = 0
    -- Disable custom warnings based on regexp
    g.vimtex_quickfix_ignore_filters = { 'Underfull \\hbox' }
    -- Disables default mappings that start with `t`
    g.vimtex_mappings_disable = {
      x = { 'tsf', 'tsc', 'tse', 'tsd', 'tsD' },
      n = { 'tsf', 'tsc', 'tse', 'tsd', 'tsD' },
    }
    g.vimtex_toc_config = {
      todo_sorted = 1,
      split_width = 30,
      name = 'Table of contents',
      hotkeys_leader = '',
      show_numbers = 1,
      hotkeys_enabled = 1,
      hotkeys = 'acdeilmopuvwx',
      show_help = 0,
      layer_status = { label = 0, todo = 0 },
    }
    g.vimtex_syntax_conceal = { sections = 1 }
    g.vimtex_syntax_conceal_cites = {
      type = 'icon',
      icon = '龎',
    }
    g.vimtex_syntax_custom_cmds = {
      { name = 'texttt', conceal = true },
    }
  end,
  config = function()
    local map = require('utils').map
    local opt_local, cmd = vim.opt_local, vim.cmd

    vim.api.nvim_create_augroup('LaTeX', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'latex', 'tex' },
      callback = function()
        opt_local.iskeyword:remove(':') -- `:` counts as a separator
        cmd.syntax('spell toplevel')

        map('n', '<leader>T', '<Plug>(vimtex-toc-open)', { buffer = true })
      end,
      group = 'LaTeX',
    })
  end
}

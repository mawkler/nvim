------------------
-- HighlightURL --
------------------
return { 'itchyny/vim-highlighturl',
  config = function()
    local autocmd = vim.api.nvim_create_autocmd
    local augroup = vim.api.nvim_create_augroup
    local colors = require('utils.colorscheme').colors

    vim.g.highlighturl_guifg = colors.blue0

    augroup('HighlightURL', {})
    autocmd('User', {
      pattern  = 'LightspeedEnter',
      callback = 'highlighturl#disable',
      group    = 'HighlightURL'
    })
    autocmd('User', {
      pattern  = 'LightspeedLeave',
      callback = 'g:highlighturl#enable',
      group    = 'HighlightURL'
    })
  end
}

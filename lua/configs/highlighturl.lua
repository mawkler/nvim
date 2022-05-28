------------------
-- HighlightURL --
------------------
return { 'itchyny/vim-highlighturl',
  setup = function()
    local autocmd = require('../utils').autocmd
    local colors = require('onedark').get_colors()

    vim.g.highlighturl_guifg = colors.blue0

    vim.api.nvim_create_augroup('HighlightURL', {})

    autocmd('FileType', {
      callback = 'highlighturl#disable_local',
      group    = 'HighlightURL'
    })
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

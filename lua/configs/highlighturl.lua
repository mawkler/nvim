------------------
-- HighlightURL --
------------------
return { 'itchyny/vim-highlighturl',
  setup = function()
    local autocmd = require('../utils').autocmd
    local colors = require('onedark').get_colors()

    vim.g.highlighturl_guifg = colors.blue0

    autocmd('FileType', {
      callback = 'highlighturl#disable_local',
      group    = 'HighlightURLDisable'
    })
    autocmd('User', {
      pattern  = 'LightspeedEnter',
      callback = 'highlighturl#disable',
      group    = 'HighlightURLDisable'
    })
    autocmd('User', {
      pattern  = 'LightspeedLeave',
      callback = 'g:highlighturl#enable',
      group    = 'HighlightURLEnable'
    })
  end
}

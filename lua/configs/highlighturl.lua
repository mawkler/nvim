------------------
-- HighlightURL --
------------------
return {
  'itchyny/vim-highlighturl',
  event = 'VeryLazy',
  config = function()
    local get_highlight = require('utils.colors').get_highlight

    vim.g.highlighturl_guifg = get_highlight('@text.uri')

    local group = vim.api.nvim_create_augroup('HighlightURL', {})
    vim.api.nvim_create_autocmd('User', {
      pattern  = 'LightspeedEnter',
      callback = 'highlighturl#disable',
      group    = group
    })
    vim.api.nvim_create_autocmd('User', {
      pattern  = 'LightspeedLeave',
      callback = 'g:highlighturl#enable',
      group    = group
    })
  end
}

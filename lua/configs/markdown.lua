--------------
-- Markdown --
--------------
return {
  'plasticboy/vim-markdown',
  ft = 'markdown',
  config = function()
    local augroup = vim.api.nvim_create_augroup('Markdown', {})
    vim.api.nvim_create_autocmd('BufEnter', {
      group = augroup,
      callback = function()
        vim.cmd('syn clear mkdNonListItemBlock')
      end
    })
  end
}

-------------------
-- tsnode-marker --
-------------------
return {
  'atusy/tsnode-marker.nvim',
  ft = 'markdown',
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('tsnode-marker-markdown', {}),
      pattern = 'markdown',
      callback = function(context)
        require('tsnode-marker').set_automark(context.buf, {
          target = { 'code_fence_content' }, -- List of target node types
          hl_group = 'CursorLine', -- Highlight group
        })
      end
    })
  end
}

-----------------------
-- Ultimate Autopair --
-----------------------
return {
  'altermo/ultimate-autopair.nvim',
  dependencies = 'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  branch = 'v0.6',
  config = function()
    require('ultimate-autopair').setup({
      { '**', '**', ft = { 'markdown' }, multiline = false },
      { '*',  '*',  ft = { 'markdown' }, multiline = false },
      { '_',  '_',  ft = { 'markdown' }, multiline = false },
      { '$',  '$',  ft = { 'tex' },      multiline = false },
      bs = {
        map = { '<BS>',  '<C-h>' },
        cmap = { '<BS>', '<C-h>' },
      },
    })

    local cmp = require('cmp')
    local ind = cmp.lsp.CompletionItemKind

    -- Add parenthesis on completion confirmation
    cmp.event:on('confirm_done', function(event)
      local completion_kind = event.entry:get_completion_item().kind
      if vim.tbl_contains({ ind.Function, ind.Method }, completion_kind) then
        local left = vim.api.nvim_replace_termcodes('<Left>', true, true, true)
        vim.api.nvim_feedkeys('()' .. left, 'n', false)
      end
    end)
  end
}

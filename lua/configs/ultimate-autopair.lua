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
      extensions = {
        filetype = {
          nft = { 'TelescopePrompt', 'DressingInput', 'NoiceCommandline' },
        },
      },
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

    local function ls_name_from_event(event)
      return event.entry.source.source.client.config.name
    end

    -- Add parenthesis on completion confirmation
    cmp.event:on('confirm_done', function(event)
      local ok, ls_name = pcall(ls_name_from_event, event)
      local server_blacklist = { 'rust_analyzer', 'lua_ls', 'typst_lsp' }
      if ok and vim.tbl_contains(server_blacklist, ls_name) then
        return
      end

      local completion_kind = event.entry:get_completion_item().kind
      if vim.tbl_contains({ ind.Function, ind.Method }, completion_kind) then
        local left = vim.api.nvim_replace_termcodes('<Left>', true, true, true)
        vim.api.nvim_feedkeys('()' .. left, 'n', false)
      end
    end)
  end
}

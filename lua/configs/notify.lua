-------------
-- Notify --
-------------
return { 'rcarriga/nvim-notify',
  after = require('configs.colorscheme').colorscheme_names,
  config = function()
    local notify = require('notify')

    require('notify').setup( { timeout = 2000 })

    vim.notify = notify

    -- LSP window/showMessage
    vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local level = ({ 'ERROR', 'WARN', 'INFO', 'DEBUG' })[result.type]

      notify({ result.message }, level, {
        title = 'LSP | ' .. client.name,
        timeout = 10000,
        keep = function() return level == 'ERROR' or level == 'WARN' end,
      })
    end
  end
}

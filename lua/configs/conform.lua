-------------
-- Conform --
-------------
return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  config = function()
    local b = vim.b
    local javascript = { 'prettierd', 'prettier', stop_after_first = true }

    require('conform').setup({
      format_on_save = function()
        if vim.b.format_on_write ~= false then
          return { timeout_ms = 500, lsp_format = 'fallback' }
        end
      end,
      formatters_by_ft = {
        javascript = javascript,
        typescript = javascript,
        typescriptreact =  javascript ,
        javascriptreact = javascript,
      }
    })

    vim.keymap.set('n', '<F2>', function()
      b.format_on_write = (not b.format_on_write and b.format_on_write ~= nil)
      local state = b.format_on_write and 'enabled' or 'disabled'
      vim.notify('Format on write ' .. state)
    end, { desc = 'Toggle autoformatting on write' })
  end
}


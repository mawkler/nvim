-------------
-- Conform --
-------------
return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  config = function()
    local b = vim.b

    local function prettier_formatters()
      local prettier_config = { 'prettierd', 'prettier', stop_after_first = true }
      local prettier_filetypes = {
        'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue',
        'css', 'scss', 'less', 'html', 'json', 'jsonc', 'yaml', 'markdown.mdx',
        'graphql', 'handlebars', 'svelte', 'astro', 'htmlangular',
      }

      local prettier = {}
      for _, filetype in pairs(prettier_filetypes) do
        prettier[filetype] = prettier_config
      end

      return prettier
    end

    local formatters = {
      markdown = { 'prettierd', 'mdsf' },
      ['*'] = { 'trim_whitespace', 'trim_newlines' },
    }

    local formatters_by_ft = vim.tbl_extend('force', prettier_formatters(), formatters)

    require('conform').setup({
      formatters_by_ft = formatters_by_ft,
      format_after_save = function()
        if vim.b.format_on_write ~= false then
          return { timeout_ms = 500, lsp_format = 'fallback' }
        end
      end,
    })

    vim.keymap.set('n', '<F2>', function()
      b.format_on_write = (not b.format_on_write and b.format_on_write ~= nil)
      local state = b.format_on_write and 'enabled' or 'disabled'
      vim.notify('Format on write ' .. state)
    end, { desc = 'Toggle autoformatting on write' })
  end
}

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
      -- JSON is excluded from here since ts_ls does a better job than prettier
      local prettier_filetypes = {
        'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue',
        'css', 'scss', 'less', 'html', 'jsonc', 'yaml', 'markdown.mdx',
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
      json = { 'prettierd', lsp_format = 'never' },
      ['_'] = { lsp_format = 'first' },
      ['*'] = { 'trim_whitespace', 'trim_newlines', 'keep-sorted' },
    }

    local formatters_by_ft = vim.tbl_extend('force', prettier_formatters(), formatters)

    require('conform').setup({
      formatters_by_ft = formatters_by_ft,
      format_after_save = function()
        if vim.b.format_on_write ~= false then
          return { timeout_ms = 500 }
        end
      end,
      default_format_opts = { lsp_format = 'last' },
      formatters = {
        mdsf = {
          args = { 'format', '--cache', '$FILENAME' },
        }
      }
    })

    vim.keymap.set('n', '<F2>', function()
      b.format_on_write = (not b.format_on_write and b.format_on_write ~= nil)
      local state = b.format_on_write and 'enabled' or 'disabled'
      vim.notify('Format on write ' .. state)
    end, { desc = 'Toggle autoformatting on write' })
  end
}

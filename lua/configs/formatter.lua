---------------
-- Formatter --
---------------
return { 'mhartington/formatter.nvim',
  module = 'formatter',
  event = 'BufWritePost',
  cmd = { 'Format', 'FormatWrite' },
  config = function()
    local map = require('utils').map
    local b, api = vim.b, vim.api

    local prettier_config = {
      function()
        return {
          exe = 'prettier',
          args = { '--stdin-filepath', api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    }

    local lsp_format = function()
      vim.lsp.buf.format({ async = false })
    end

    require('formatter').setup {
      logging = false,
      filetype = {
        javascript = prettier_config,
        typescript = prettier_config,
        typescriptreact = prettier_config,
        html = prettier_config,
        yaml = prettier_config,
        json = prettier_config,
        lua = lsp_format,
        rust = lsp_format,
        markdown = {
          function()
            return {
              exe = 'prettier',
              args = {
                '--tab-width', 2,
                '--stdin-filepath', api.nvim_buf_get_name(0),
              },
              stdin = true
            }
          end
        },
        python = {
          function()
            return {
              exe = 'autopep8',
              args = {'-i'},
              stdin = false
            }
          end
        },
        bicep = {
          function()
            return {
              exe = 'bicep format',
              args = { '--stdout', api.nvim_buf_get_name(0) },
              stdin = true,
            }
          end
        },
      }
    }

    map('n', '<F2>', function()
      b.format_on_write = (not b.format_on_write and b.format_on_write ~= nil)
      vim.notify('Format on write ' .. (b.format_on_write and 'enabled' or 'disabled'))
    end, 'Toggle autoformatting on write')

    vim.api.nvim_create_augroup('AutoFormatting', {})
    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = {
        '*.js',
        '*.json',
        '*.md',
        '*.py',
        '*.ts',
        '*.tsx',
        '*.yml',
        '*.yaml',
        '*.html',
        '*.bicep',
        -- '*.lua', -- Disabled until
        -- https://github.com/CppCXY/EmmyLuaCodeStyle/issues/69 gets fixed
        '*.rs'
      },
      callback = function()
        if b.format_on_write ~= false then
          vim.cmd 'FormatWrite'
        end
      end,
      group = 'AutoFormatting'
    })
  end,
}

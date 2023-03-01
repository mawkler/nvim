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
          target = { 'fenced_code_block' },
          hl_group = 'CursorLine',
          range = function(_, node)
            -- Copied from README
            local start_row, start_col, end_row, end_col = node:range()

            for i = node:child_count() - 1, 2, -1 do
              local n = node:child(i)
              if n:type() == 'fenced_code_block_delimiter' then
                _, _, end_row, end_col = n:range()
              end
            end

            return start_row, start_col, end_row, end_col
          end,
        })
      end
    })
  end
}

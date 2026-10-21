---------
-- CSV --
---------
local filetypes = { 'csv', 'tsv' }

return {
  'hat0uma/csvview.nvim',
  ft = filetypes,
  cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function()
        vim.cmd.CsvViewEnable()
      end,
    })

    local ox, nx = { 'o', 'x' }, { 'n', 'x' }

    require('csvview').setup({
      parser = {
        comments = { '#', '//' },
      },
      view = {
        display_mode = 'border',
      },
      keymaps = {
        textobject_field_inner = { 'ic', mode = ox },
        textobject_field_outer = { 'ac', mode = ox },
        jump_next_field_end = { '}', mode = nx },
        jump_prev_field_end = { '{', mode = nx },
      }
    })

    vim.keymap.set('n', '<leader>lm', '<cmd>CsvViewToggle<CR>')
  end
}

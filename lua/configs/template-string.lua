-------------------------------
-- Template string converter --
-------------------------------
return {
  'axelvc/template-string.nvim',
  ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  config = function()
    require('template-string').setup(({
      remove_template_string = true,
      restore_quotes = { normal = '"' },
    }))
  end
}

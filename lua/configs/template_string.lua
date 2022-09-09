-------------------------------
-- Template string converter --
-------------------------------
return { 'axelvc/template-string.nvim',
  ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  config = function()
    local plugin_setup = require('utils').plugin_setup

    plugin_setup('template-string', ({
      remove_template_string = true,
      restore_quotes = {
        normal = '"',
      },
    }))
  end
}

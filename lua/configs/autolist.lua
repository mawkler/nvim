--------------
-- Autolist --
--------------
return { 'gaoDean/autolist.nvim',
  ft = { 'markdown', 'text', 'latex' },
  config = function()
    local autolist = require('autolist')

    autolist.setup({
      colon = { indent_raw = false },
    })

    local function create_mapping_hook(mode, mapping, hook, desc, alias)
      vim.keymap.set(
        mode,
        mapping,
        function(motion)
          local keys = hook(motion, alias or mapping)
          if not keys then keys = '' end
          return keys
        end,
        { expr = true, buffer = true, desc = desc }
      )
    end

    create_mapping_hook('i', '<CR>',      autolist.new,               'Autolist new line')
    create_mapping_hook('i', '<C-t>',     autolist.indent,            'Autolist indent')
    create_mapping_hook('i', '<C-d>',     autolist.indent,            'Autolist dedent')
    create_mapping_hook('n', 'dd',        autolist.force_recalculate, 'Autolist delete line')
    create_mapping_hook('n', 'o',         autolist.new,               'Autolist new line')
    create_mapping_hook('n', 'O',         autolist.new_before,        'Autolist new line above')
    create_mapping_hook('n', '>>',        autolist.indent,            'Autolist indent')
    create_mapping_hook('n', '<<',        autolist.indent,            'Autolist dedent')
    create_mapping_hook('n', '<leader>x', autolist.invert_entry,      'Autolist invert', '')
  end
}

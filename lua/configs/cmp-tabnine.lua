-------------
-- Tabnine --
-------------
return { 'tzachar/cmp-tabnine',
  run = './install.sh',
  after = 'nvim-cmp',
  config = function()
    local tabnine = require('cmp_tabnine.config')
    tabnine:setup {
      max_num_results = 3,
      show_prediction_strength = true,
      ignored_file_types = {},
    }
  end
}


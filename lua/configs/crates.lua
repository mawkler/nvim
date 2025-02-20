------------
-- Crates --
------------
return {
  'saecki/crates.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  event = { 'BufRead Cargo.toml' },
  config = function()
    local crates = require('crates')

    crates.setup({
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
      },
    })

    vim.api.nvim_create_autocmd('BufRead', {
      group = vim.api.nvim_create_augroup('CargoMappings', { clear = true }),
      pattern = 'Cargo.toml',
      callback = function(event)
        local map = require('utils').local_map(event.buf)

        -- Keymaps
        map('n', '<leader>lf', crates.show_features_popup,                'Show crate features')
        map('n', '<leader>lv', crates.show_versions_popup,                'Show crate versions')
        map('n', '<leader>ld', crates.show_dependencies_popup,            'Show crate dependencies')
        map('n', '<leader>lu', crates.upgrade_crate,                      'Upgrade crate')
        map('x', '<leader>lu', crates.upgrade_crates,                     'Upgrade crates')
        map('n', '<leader>lU', crates.upgrade_all_crates,                 'Upgrade all crates')
        map('n', '<leader>lt', crates.expand_plain_crate_to_inline_table, 'Expand crate to inline table')
        map('n', '<leader>lT', crates.extract_crate_into_table,           'Extract crate into table')
        map('n', '<leader>lh', crates.open_homepage,                      'Open crate homepage')
        map('n', '<leader>lr', crates.open_repository,                    'Open crate repository')
        map('n', '<leader>lD', crates.open_documentation,                 'Open crate documentation')
        map('n', '<leader>lC', crates.open_crates_io,                     'Open crate on crates.io')
      end,
    })
  end
}

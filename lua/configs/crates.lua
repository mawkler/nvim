------------
-- Crates --
------------
return {
  'saecki/crates.nvim',
  tag = 'v0.3.0',
  dependencies = 'nvim-lua/plenary.nvim',
  event = { "BufRead Cargo.toml" },
  config = function()
    local cmp = require('cmp')

    require('crates').setup({
      popup = {
        keys = {
          open_url = { 'gx' },
          toggle_feature = { '<space>lf' },
        },
      },
      null_ls = {
        enabled = true,
        name = 'crates.nvim',
      },
    })

    local function enable_cmp_cargo_completion()
      local cmp_config = cmp.get_config()
      table.insert(cmp_config.sources, { name = 'crates' })
      cmp.setup(cmp_config)
    end

    -- Crate version completion with nvim-cmp
    vim.api.nvim_create_autocmd('BufRead', {
      group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
      pattern = 'Cargo.toml',
      callback = enable_cmp_cargo_completion,
    })
    enable_cmp_cargo_completion()
  end
}

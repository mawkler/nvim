-----------------------
-- Ultimate Autopair --
-----------------------
return {
  'altermo/ultimate-autopair.nvim',
  dependencies = 'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  branch = 'v0.6',
  config = function()
    require('ultimate-autopair').setup({
      extensions = {
        filetype = {
          nft = { 'TelescopePrompt', 'DressingInput' },
        },
      },
      { '**', '**', ft = { 'markdown' }, multiline = false },
      { '*',  '*',  ft = { 'markdown' }, multiline = false },
      { '_',  '_',  ft = { 'markdown' }, multiline = false },
      { '$',  '$',  ft = { 'tex' },      multiline = false },

      { '<',  '>',  fly = true,          dosuround = true, multiline = false, space = true, surround = true },
      config_internal_pairs = {
        {
          "'",
          "'",
          multiline = false,
          surround = true,
          alpha = true,
          cond = function(fn)
            -- Don't autopair apostrophes in Rust (because they're usually used for lifetimes)
            return fn.get_ft() ~= 'rust'
          end,
          nft = { 'tex', 'lisp' } -- Taken from default config
        }
      },
      bs = {
        map = { '<BS>', '<C-h>' },
      },
      cmap = false, -- Disable in command-line-mode
    })
  end
}

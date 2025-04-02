-----------------------
-- Ultimate Autopair --
-----------------------
return {
  'altermo/ultimate-autopair.nvim',
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
      bs = {
        map = { '<BS>', '<C-h>' },
      },
      cmap = false, -- Disable in command-line-mode
    })
  end
}

---------------
-- Lastplace --
---------------
return { 'ethanholz/nvim-lastplace',
  config = function()
    require('nvim-lastplace').setup({
      lastplace_ignore_filetype = { 'gitcommit' },
    })
  end
}

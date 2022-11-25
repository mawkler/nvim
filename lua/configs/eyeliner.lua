--------------
-- Eyeliner --
--------------
return { 'jinh0/eyeliner.nvim',
  -- keys = { 'f', 'F', 't', 'T' },
  config = function()
    require'eyeliner'.setup({
      highlight_on_key = true
    })
  end
}

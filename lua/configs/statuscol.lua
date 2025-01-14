---------------
-- Statuscol --
---------------
return {
  'luukvbaal/statuscol.nvim', config = function()
    local builtin = require('statuscol.builtin')
    require('statuscol').setup({
      relculright = true,   -- right-align cursor line number
      segments = {
        { text = { '%s' }, click = 'v:lua.ScSa' },
        {
          text = { builtin.lnumfunc },
          condition = { true, builtin.not_empty },
          click = 'v:lua.ScLa',
        },
        {
          text = { builtin.foldfunc, ' ' },
          condition = { true },
          click = "v:lua.ScFa"
        },
      },
    })
  end,
}

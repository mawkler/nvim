--------------
-- Autolist --
--------------
return { 'gaoDean/autolist.nvim',
  ft = { 'markdown', 'text', 'latex' },
  config = function()
    require('autolist').setup({
    	invert = {
    		normal_mapping = '<space>x',
    	},
    	checkbox = {
    		left = '%[',
    		right = '%] ',
    		fill = 'x',
    	},
    	colon = {
    		indent_raw = false,
    		indent = false,
    	},
    })
  end,
}
